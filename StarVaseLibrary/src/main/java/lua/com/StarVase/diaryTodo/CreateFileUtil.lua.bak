require "import"
module(...,package.seeall)

import "android.database.sqlite.*"
--import "com.StarVase.app.path"
--打开数据库(没有自动创建)
function getDatabase()
  local path = import "com.StarVase.app.path"
  db = SQLiteDatabase.openOrCreateDatabase(path.app .. "data/database/data.db",MODE_PRIVATE, nil);
  return db
end


--execSQL()方法可以执行insert、delete、update和CREATE TABLE之类有更改行为的SQL语句
function exec(sql)
  getDatabase().execSQL(sql);
end

--rawQuery()方法用于执行select语句。
function raw(sql,text)
  cursor=getDatabase().rawQuery(sql,text)
  return cursor
end

function createDatabase()
tables={
  "create table diary(id integer primary key,title text,creatTimestamp int,year int,month int,day int,isEmp boolean,key text,content text)",
  "create table todo(id integer primary key,title text,isHighlight boolean,data text,timestamp int,noticeat int,highlightColor int)",
  "create table inspiration(id integer primary key,title text,content text,timestamp int,updated int)",
  "create table collection(id integer primary key,title text,content text,timestamp int,updated int)",
  "create table markdown(id integer primary key,path text,timestamp int)",
}
  
for k,v in ipairs(tables)
  pcall(exec,v)
end
end


function diary(config)
  db=getDatabase()
  import "android.content.ContentValues"
  title=tostring(config.title)
  isLocked=config.isLocked or false
  passkey=tostring(config.passkey)
  content=tostring(config.content)
  year=tostring(config.date.year)
  month=tostring(config.date.month)
  day=tostring(config.date.day)

  if isLocked then
    import "rc4"
    content=minicrypto.encrypt(content,passkey)
    key=minicrypto.encrypt(passkey,"Diaryenced")
    isEmp="1"
   else isEmp="0"
  end
  values = ContentValues();
  values.put("title",title);
  values.put("year", year);
  values.put("month", month);
  values.put("day", day);
  values.put("isEmp", isEmp);
  values.put("key", key);
  values.put("content", content);
  db.insert("diary", nil, values);

  cursor=raw("select max(id) from diary",nil)
  if cursor&&cursor.moveToFirst() then
    targetId=cursor.getInt(0)
  end
  return targetId
end



function collection(config)
  db=getDatabase()
  import "android.content.ContentValues"
  title=tostring(config.title)
  content=tostring(config.content)
  timestamp=tostring(config.timestamp)

  local values = ContentValues();
  values.put("title",title);
  values.put("content",content);
  values.put("timestamp",timestamp);
  db.insert("collection", nil, values);

  cursor=raw("select max(id) from collection",nil)
  if cursor&&cursor.moveToFirst() then
    targetId=cursor.getInt(0)
  end
  return targetId
end


function inspiration(config)
  db=getDatabase()
  import "android.content.ContentValues"
  title=tostring(config.title)
  content=tostring(config.content)
  timestamp=tostring(config.timestamp)

  local values = ContentValues();
  values.put("title",title);
  values.put("content",content);
  values.put("timestamp",timestamp);
  db.insert("inspiration", nil, values);

  cursor=raw("select max(id) from inspiration",nil)
  if cursor&&cursor.moveToFirst() then
    targetId=cursor.getInt(0)
  end
  return targetId
end






function todo(config)
  db=getDatabase()
  import "android.content.ContentValues"
  title=tostring(config.title)
  timestamp=tostring(config.timestamp)
  isHighlight=tostring(config.isHighlight)
  highlightColor=tostring(config.highlightColor)

  values = ContentValues();
  values.put("title",title);
  values.put("isHighlight",isHighlight);
  values.put("highlightColor",highlightColor);
  values.put("data", cjson.encode{});
  values.put("timestamp",timestamp);
  values.put("noticeat",nil);
  db.insert("todo", nil, values);

  cursor=raw("select max(id) from todo",nil)
  if cursor&&cursor.moveToFirst() then
    targetId=cursor.getInt(0)
  end
  return targetId
end

function markdownToDb(config)
  db=getDatabase()
  import "android.content.ContentValues"
  filepath=tostring(config.path)

  values = ContentValues();
  values.put("path",filepath);
  values.put("timestamp",tostring(os.time()));
  db.insert("markdown", nil, values);

  cursor=raw("select max(id) from markdown",nil)
  if cursor&&cursor.moveToFirst() then
    targetId=cursor.getInt(0)
  end
  return targetId
end

