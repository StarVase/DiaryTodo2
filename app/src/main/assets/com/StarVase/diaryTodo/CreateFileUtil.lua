require "import"
module(...,package.seeall)



--打开数据库(没有自动创建)
function getDatabase()
  import "android.database.sqlite.*"
  db = SQLiteDatabase.openOrCreateDatabase(path.app .. "data.db",MODE_PRIVATE, nil);
  return db
end

--rawQuery()方法用于执行select语句。
local function raw(sql,text)
  cursor=getDatabase().rawQuery(sql,text)
  return cursor
end

function diary(config)
  db=getDatabase()
  import "android.content.ContentValues"
  title=tostring(config.title)
  isLocked=config.isLocked
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

  cursor=raw("select last_insert_rowid() from diary",nil)
  return cursor.moveToFirst()
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

  cursor=raw("select last_insert_rowid() from collection",nil)
  return cursor.moveToFirst()
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

  cursor=raw("select last_insert_rowid() from inspiration",nil)
  return cursor.moveToFirst()
end






function todo(config)
  db=getDatabase()
  import "android.content.ContentValues"
  title=tostring(config.title)
  timestamp=tostring(config.timestamp)
  isHighlight=tostring(config.isHighlight)
  highlightColor=tonumber(config.highlightColor)

  values = ContentValues();
  values.put("title",title);
  values.put("isHighlight",isHighlight);
  values.put("highlightColor",highlightColor);
  values.put("data", cjson.encode{});
  values.put("timestamp",timestamp);
  values.put("noticeat",nil);
  db.insert("todo", nil, values);;

  cursor=raw("select last_insert_rowid() from todo",nil)
  return cursor.moveToFirst()
end