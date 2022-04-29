import "android.database.sqlite.*"
db = CreateFileUtil.getDatabase()
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

_STATE={}


function decrypt(key,content,usrKey)
  _STATE.usrKey=usrKey
  --Thread(Runnable({run=function()
  import "rc4"
  _STATE.trueKey=minicrypto.decrypt(key,"Diaryenced")
  if usrKey == _STATE.trueKey then
    _STATE._TRUEKEY=true
    content=minicrypto.decrypt(content,usrKey)
    Widgetcontent.text=content
    _STATE._INITCONTENT=content
    Widgetcontent.focusable=true
    Widgetcontent.FocusableInTouchMode=true

   else
    _STATE._TRUEKEY=false
    Widgetcontent.text="Password Error"
    _STATE._INITCONTENT="Password Error"
    Widgetcontent.setFocusable(false)
    activity.finish()
  end
  mPerformEdit.setDefaultText(Widgetcontent.text)
  MarkText(Widgetcontent.text)
  -- end})).run()
end

function startLoadDiary()
  -- Thread(Runnable({run=function()
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
    _STATE.__EMP=true
    verfyPwd(key,content)
   elseif content then
    Widgetcontent.text=content
    _STATE._INITCONTENT=content
    Widgetcontent.focusable=true
    Widgetcontent.FocusableInTouchMode=true
    _STATE.__EMP=false
  end
  mPerformEdit.setDefaultText(Widgetcontent.text)
  MarkText(Widgetcontent.text)
  --end})).run()
end

function startLoadInspiration()
  -- Thread(Runnable({run=function()
  id=details.id
  sql="select * from inspiration WHERE id=?"
  raw(sql,{tostring(id)})
  if cursor.moveToFirst() then
    content = cursor.getString(2);
  end
  Widgetcontent.text=content
  _STATE._INITCONTENT=content
  Widgetcontent.focusable=true
  Widgetcontent.FocusableInTouchMode=true
  --  end})).run()
  mPerformEdit.setDefaultText(Widgetcontent.text)
  MarkText(Widgetcontent.text)
end

function startLoadCollection()
  --Thread(Runnable({run=function()
  id=details.id
  sql="select * from collection WHERE id=?"
  raw(sql,{tostring(id)})
  if cursor.moveToFirst() then
    content = cursor.getString(2);
  end
  Widgetcontent.text=content
  _STATE._INITCONTENT=content
  Widgetcontent.setFocusable(true)
  Widgetcontent.FocusableInTouchMode=true
  mPerformEdit.setDefaultText(Widgetcontent.text)
  --  end})).run()
  MarkText(Widgetcontent.text)
end

function startLoadNormalFile()
  --Thread(Runnable({run=function()
  filepath=details.path
  Widgetcontent.text=file.readFile(filepath)
  _STATE._INITCONTENT=file.readFile(filepath)
  Widgetcontent.setFocusable(true)
  Widgetcontent.FocusableInTouchMode=true
  --print(File(filepath).getParent())
  --print(file.readFile(activity.getApplication().getLuaDir().."/html/index.html"))
  --task(1,function()

  --webView.loadDataWithBaseURL(File(filepath).getParent(), "javascript:MarkText(\"" ..content.. "\");", "text/html", "UTF-8", null);
  --end)
  mPerformEdit.setDefaultText(Widgetcontent.text)
  -- end})).run()
  MarkText(Widgetcontent.text)
end

function startLoadTodoDetail()
  --Thread(Runnable({run=function()
  Widgetcontent.text=details.content
  _STATE._INITCONTENT=details.content
  Widgetcontent.setFocusable(true)
  Widgetcontent.FocusableInTouchMode=true
  mPerformEdit.setDefaultText(Widgetcontent.text)
  --  end})).run()
  MarkText(Widgetcontent.text)
end

function verfyPwd(key,content)
  import "com.google.android.material.bottomsheet.BottomSheetDialog"

  local dann=import "layout.typepwd"

  dl=BottomSheetDialog(activity)
  dl.setContentView(loadlayout(dann))
  dl.setCanceledOnTouchOutside(false)
  dl.setCancelable(false)
  an=dl.show()
  bottom = dl.findViewById(R.id.design_bottom_sheet);
  if (bottom != nil) then
    bottom
    .setBackgroundResource(android.R.color.transparent)
    .setPadding(math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(32))
  end
  okey.onClick=function()
    if typepsk.getText() then
      decrypt(key,content,typepsk.getText().toString())
    end
    dl.dismiss()
  end
  cancel.onClick=lambda -> activity.finish()

end


Thread(Runnable({
  run=function()
    switch doctype
     case "diaryX" then
      usrKey=activity.getSharedData("diaryRC4PSK")
      startLoadDiary()
     case "inspirationX" then
      startLoadInspiration()
     case "collectionX" then
      startLoadCollection()
     case "markdownX" then
      startLoadNormalFile()
     case "todoDetail" then
      startLoadTodoDetail()
    end
    MarkText(Widgetcontent.text)
    task(100,function()
      if (#Widgetcontent.getText().toString() > 0) then
        page.setCurrentItem(1)
      end
    end)
  end
})).run()