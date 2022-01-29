import "android.database.sqlite.*"
cjson=require "cjson"
--打开数据库(没有自动创建)
db = CreateFileUtil.getDatabase()

--execSQL()方法可以执行insert、delete、update和CREATE TABLE之类有更改行为的SQL语句
function exec(sql)
  db.execSQL(sql);
end

--rawQuery()方法用于执行select语句。
function raw(sql,text)
  cursor=db.rawQuery(sql,text)
end

function toBoolean(int)
  if int==1 then
    return true
   elseif int==true then
    return true
   elseif int=="true" then
    return true
   else
    return false
  end
end

function computeProgress(data)
  xpcall(function()
    tab=cjson.decode(data)
    -- print(dump(tab))
    local val1=0
    for key,value in pairs(tab) do
      if toBoolean(value.istrue) then
        val1=val1+1
      end
    end
    result = (val1/#tab)*100
    if #tab > 0 then
      result = (val1/#tab)*100
     else result = 0
    end
  end,function()
    result=0
  end)
  return result
end





function autoHighLight(word,type)
  if Boolean.valueOf(type) && word && word != "" then
    return MyTextStyle.TextColor(word,0,utf8.len(word),0xFFF44336)
   else
    return word
  end
end
function int2Boolean(int)
  if int>0 then
    return true
   else
    return false
  end
end
function Refresh()
  sr.setRefreshing(true);
  loading.setVisibility(View.VISIBLE)

  adapter.clear()
  sql="select * from todo ORDER BY id DESC"
  if pcall(raw,sql,nil) then
    while (cursor.moveToNext()) do

      id = cursor.getInt(0); --获取第一列的值,第一列的索引从0开始
      title = cursor.getString(1);--获取第二列的值
      isHighlight = cursor.getInt(2)
      data0 = cursor.getString(3);

      ts = cursor.getInt(4);
      noticeat = cursor.getInt(5);
      highlightColor=cursor.getInt(6);
      if computeProgress(data0)==100 then
        alpha=0.4
       else
        alpha=1
      end
      if #cjson.decode(data0) == 0 then
        isPrgShow=0
       else
        isPrgShow=1
      end
      -- print(id,title,isHighlight,data,ts,noticeat)
      adapter.add(
      {
        p={alpha=alpha},
        title={
          Text=autoHighLight(title,int2Boolean(isHighlight)),
        },
        id=id,
        date=ts,
        isHighlight=isHighlight,
        progress={progress=computeProgress(data0),alpha=isPrgShow},
      })

    end
    cursor.close()
   else
  end
  loading.setVisibility(View.GONE)
  sr.setRefreshing(false);
end


function delete(id)
  db.delete("todo", "id=?", {tostring(id)});
  Refresh()
end
