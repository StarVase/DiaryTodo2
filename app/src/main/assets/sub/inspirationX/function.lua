import "android.database.sqlite.*"

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
   else
    return false
  end
end



function getTimeStr(ts,updated)
  if (updated > 0 && ts != updated) then
    return string.format("%s->%s",math.ts2t(tonumber(ts)),math.ts2t(tonumber(updated)))
   else
    return math.ts2t(tonumber(ts))
  end
end


function Refresh()
  nodata.setVisibility(View.GONE)

  adapter.clear()
  sql="select * from inspiration ORDER BY id DESC"
  if pcall(raw,sql,nil) then
    while (cursor.moveToNext()) do

      id = cursor.getInt(0); --获取第一列的值,第一列的索引从0开始
      title = cursor.getString(1);--获取第二列的值
      content = cursor.getString(2);
      ts= cursor.getInt(3);
      updated = cursor.getInt(4)
      adapter.add(
      {
        title={
          Text=title,
        },
        sub={
          Text=getTimeStr(ts,updated),
        },
        id=id,
        date=ts,
      })
    end
    cursor.close()
   if #data == 0 then
      nodata.setVisibility(View.VISIBLE)
    end
  end
  loading.setVisibility(View.GONE)
  sr.setRefreshing(false);
end
Refresh()

function delete(id)
  db.delete("inspiration", "id=?", {tostring(id)});
  Refresh()
end
