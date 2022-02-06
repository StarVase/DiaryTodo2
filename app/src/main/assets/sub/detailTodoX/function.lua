import "com.StarVase.diaryTodo.CreateFileUtil"
function TrueAndFalseColor(text,word)
  if text then
    return MyTextStyle.TextColor(word,0,utf8.len(word),0xFFF44336)
   else
    return word
  end
end

function highLight(word)
  return MyTextStyle.TextColor(word,0,utf8.len(word),0xFFF44336)
end


function Refresh(id)
  nodata.setVisibility(View.GONE)
  adapter.clear()
  sql="select * from todo WHERE id=?"
  cursor=CreateFileUtil.raw(sql,{tostring(id)})
  if cursor.moveToFirst() then
    title = cursor.getString(1);
    content = cursor.getString(3);
  end

  editTitle.setText(title)

  tab=getTable(content)

  save_as_json(tab,todoid)
  loading.setVisibility(View.GONE)
  for i = 1,#tab do

    istrue=tab[i].istrue
    highLight=tab[i].highLight

    ts=math.ts2t(tonumber(tab[i].timestamp))
    date=TrueAndFalseColor(tab[i].highLight,tab[i].title)
    if istrue then
      alpha=0.4
     else
      alpha=1
    end
    date=TrueAndFalseColor(tab[i].highLight,tab[i].title)
    adapter.add({title={text=date,alpha=alpha},status={Checked=Boolean.valueOf(istrue),alpha=alpha}})
  end
if #data == 0 then
      nodata.setVisibility(View.VISIBLE)
    end
  loading.setVisibility(View.GONE)
  sr.setRefreshing(false);
end

function getTable(content)
  require "import"
  cjson=import"cjson"

  function BubbleSorthere(arr)

    len=table.maxn(arr)
    for i=1,len do
      for j=i+1,len do
        if arr[i].timestamp<arr[j].timestamp then
          arr[i],arr[j]=arr[j],arr[i]
        end
      end
    end
    return arr
  end

  if content then
    if pcall(function()
        json=cjson.decode(content)

      end) then
      json=BubbleSorthere(json)
      return json
    end
  end
end


function set_check_box(one,value,filename)
  local tab=getTable(content)
  tab[one].istrue=value
  save_as_json(tab,filename)
end


function save_as_json(arr,id)
  local cjson=import"cjson"
  local content=cjson.encode(arr)

  values = ContentValues();
  values.put("title",tostring(editTitle.getText()));
  values.put("data", content);
  CreateFileUtil.getDatabase().update("todo", values, "id=?", {tostring(id)});
end

function delete(id,filename)
  tab=getTable(content)
  table.remove(tab,id)
  save_as_json(tab,filename)
  Refresh(filename)
end