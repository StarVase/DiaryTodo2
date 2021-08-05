import "android.database.sqlite.*"
db = SQLiteDatabase.openOrCreateDatabase(path.app .. "data.db",MODE_PRIVATE, nil);
function exec(sql)
  db.execSQL(sql);
end
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




function decrypt(key,content)
  Thread(Runnable({run=function()
      import "rc4"
      trueKey=minicrypto.decrypt(key,"Diaryenced")
      if usrKey == trueKey then
        _TRUEKEY=true
        content=minicrypto.decrypt(content,usrKey)
        Widgetcontent.text=content
       else
        _TRUEKEY=false
        Widgetcontent.text="密钥错误。"
        Widgetcontent.setFocusable(false)
      end
    end})).run()
end

function startLoadDiary()
  Thread(Runnable({run=function()
      id=details.id
      sql="select * from diary WHERE id=?"
      raw(sql,{tostring(id)})
      if cursor.moveToFirst() then
        title = cursor.getString(1);
        isEmp = toBoolean(cursor.getInt(6))
        key = cursor.getString(7);
        content = cursor.getString(8);
      end
      if isEmp then
        __EMP=true
        decrypt(key,content)
       elseif content then
        Widgetcontent.text=content
        __EMP=false
      end
    end})).run()
end

function startLoadInspiration()
  Thread(Runnable({run=function()
      id=details.id
      sql="select * from inspiration WHERE id=?"
      raw(sql,{tostring(id)})
      if cursor.moveToFirst() then
        content = cursor.getString(2);
      end
      Widgetcontent.text=content
    end})).run()
end

function startLoadCollection()
    Thread(Runnable({run=function()
      id=details.id
      sql="select * from collection WHERE id=?"
      raw(sql,{tostring(id)})
      if cursor.moveToFirst() then
        content = cursor.getString(2);
      end
      Widgetcontent.text=content
    end})).run()
end


switch doctype
 case "diaryX" then
  task(500,function()
    usrKey=activity.getSharedData("diaryRC4PSK")
    startLoadDiary()
  end)
 case "inspirationX" then
  startLoadInspiration()
  case "collectionX" then
  startLoadCollection()
end
