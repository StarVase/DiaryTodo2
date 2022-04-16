require "import"
import "android.widget.*"
import "android.view.*"

db = CreateFileUtil.getDatabase()
--execSQL()方法可以执行insert、delete、update和CREATE TABLE之类有更改行为的SQL语句
function exec(sql)
  db.execSQL(sql);
end

--rawQuery()方法用于执行select语句。
function raw(sql,text)
  cursor=db.rawQuery(sql,text)
end

function getDateConfig()
  local conf = {}
  import "android.text.format.Time"
  time=Time().setToNow()

  conf.year=time.year
  conf.month=time.month+1
  conf.day=time.monthDay
  return conf
end
function isWrittenDiaryToday()
  condition=""
  dateConf=getDateConfig()
  if dateConf && dateConf.year && dateConf.month && dateConf.day then
    condition=" where year = "..tostring(dateConf.year)
    .." and month = "..tostring(dateConf.month)
    .." and day = "..tostring(dateConf.day)

  end
  sql="select * from diary"..condition.." order by id desc"

  if pcall(raw,sql,nil) then
    if (!cursor.moveToNext()) then
      print("getFocused -> 今天还未写日记！")
      return false
     else
      return true
    end
    cursor.close()
  end
end

function isReadArticleToday()
  time=Time().setToNow()
  conf={}
  conf.year=time.year
  conf.month=time.month+1
  conf.day=time.monthDay
  if (!activity.getSharedData("LastReadArticleDate")|| activity.getSharedData("LastReadArticleDate") < tointeger(tostring(conf.year)..tostring(conf.month)..tostring(conf.day))) then
    print("getFocused -> 今天还未读文章！")
    return false
   else return true
  end
end

function getUnfinishedTodo()
  sql="select * from todo where percent < 1 order by id desc"

  if pcall(raw,sql,nil) then
    print("getFocused -> UnfinishedTodo:\n")
    while (cursor.moveToNext()) do
      -- print("getFocused -> 今天还未写日记！")

      print(cursor.getInt(0).." "..cursor.getString(1).." "..cursor.getString(7))
      --[[   return false
     else
      return true]]
    end
    cursor.close()
  end
end

--print(isWrittenDiaryToday())
--print(isReadArticleToday())
getUnfinishedTodo()