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


--初始化创建数据库
--id integer
--title text,
--creatTimestamp integer,
--year integer,
--month integer,
--day integer,
--isEmp boolean
--key text,
--content text


function Refresh(dateConf)

  adapter.clear()
  condition=""
  if dateConf && dateConf.year && dateConf.month && dateConf.day then
    condition=" where year = "..tostring(dateConf.year)
    .." and month = "..tostring(dateConf.month)
    .." and day = "..tostring(dateConf.day)
    date.text=tostring(dateConf.year).."/"..tostring(dateConf.month).."/"..tostring(dateConf.day)
   else
    date.text=AdapLan("全部","All")
  end
  sql="select * from diary"..condition.." order by id desc"
  
  if pcall(raw,sql,nil) then
    while (cursor.moveToNext()) do

      id = cursor.getInt(0); --获取第一列的值,第一列的索引从0开始
      title = cursor.getString(1);--获取第二列的值
      year = cursor.getInt(3);--获取第三列的值
      month = cursor.getInt(4);
      day = cursor.getInt(5);
      isEmp = cursor.getInt(6);
      key = cursor.getString(7);
      datestr=tostring(year)..tostring(month)..tostring(day)
      if toBoolean(isEmp) then
        img=R.drawable.ic_lock_outline
        alpha=0.32
       else
        img=R.drawable.ic_lock_open_variant_outline
        alpha=1
      end
      adapter.add(
      {
        title={
          Text=title,
        },
        image={
          ImageResource=img,
          alpha=alpha,
        },
        sub={
          Text=tostring(year).."/"..tostring(month).."/"..tostring(day),
        },
        id=id,
        date={y=year,m=month,d=day},
        isEmp=toBoolean(isEmp)
      })
    end
    cursor.close()
   else
  end
  loading.setVisibility(View.GONE)
  sr.setRefreshing(false);
end

function delete(id)
  db.delete("diary", "id=?", {tostring(id)});
  Refresh()
end
