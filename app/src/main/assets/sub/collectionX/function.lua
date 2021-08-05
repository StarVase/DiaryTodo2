import "android.database.sqlite.*"

--打开数据库(没有自动创建)
db = SQLiteDatabase.openOrCreateDatabase(path.app .. "data.db",MODE_PRIVATE, nil);

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
   else
    return false
  end
end
--[[file_name=name,
        title=title,
        path=tostring(path),
        content=content,
        timestamp=ts,
   ]]

--title text,content text,timestamp int

CreatrTableSql="create table collection(id integer primary key,title text,content text,timestamp int)"
pcall(exec,CreatrTableSql)

values = ContentValues();
values.put("title",'灵感');
values.put("content", "我没有内容");
values.put("timestamp",tostring(os.time()));
--db.insert("inspiration", nil, values);


function Refresh()
  sr.setRefreshing(true);
  loading.setVisibility(View.VISIBLE)

  adapter.clear()
  sql="select * from collection"
  if pcall(raw,sql,nil) then
    while (cursor.moveToNext()) do

      id = cursor.getInt(0); --获取第一列的值,第一列的索引从0开始
      title = cursor.getString(1);--获取第二列的值
      content = cursor.getString(2);
      ts= cursor.getInt(3);
      adapter.add(
      {
        title={
          Text=title,
        },
      sub={
        Text=math.ts2t(tonumber(ts)),
      },
        id=id,
        date=ts,
      })
    end
    cursor.close()
   else
  end
  loading.setVisibility(View.GONE)
  sr.setRefreshing(false);
end
Refresh()

function delete(id)
  db.delete("collection", "id=?", {tostring(id)});
  Refresh()
end

function createCollection(tab)
  local values = ContentValues();
  values.put("title",tab.title);
  values.put("content",tab.content);
  values.put("timestamp",tostring(os.time()));
  db.insert("collection", nil, values);
end