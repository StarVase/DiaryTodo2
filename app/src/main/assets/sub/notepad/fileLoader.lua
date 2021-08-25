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
        _INITCONTENT=content
        Widgetcontent.focusable=true
        Widgetcontent.FocusableInTouchMode=true

       else
        _TRUEKEY=false
        Widgetcontent.text="Permission denied"
        _INITCONTENT="Permission denied"
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
        _INITCONTENT=content
        Widgetcontent.focusable=true
        Widgetcontent.FocusableInTouchMode=true
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
      _INITCONTENT=content
      Widgetcontent.focusable=true
      Widgetcontent.FocusableInTouchMode=true
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
      _INITCONTENT=content
      Widgetcontent.setFocusable(true)
      Widgetcontent.FocusableInTouchMode=true
    end})).run()
end

function startLoadNormalFile()
  Thread(Runnable({run=function()
      filepath=details.path
      Widgetcontent.text=file.readFile(filepath)
      _INITCONTENT=file.readFile(filepath)
      Widgetcontent.setFocusable(true)
      Widgetcontent.FocusableInTouchMode=true
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
 case "markdownX" then
  startLoadNormalFile()
end
