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
  editorHelper.setDefaultText(Widgetcontent.text)
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
  _STATE._INITTITLE=title
  editorHelper.setDefaultText(Widgetcontent.text)
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
  editorHelper.setDefaultText(Widgetcontent.text)
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
  editorHelper.setDefaultText(Widgetcontent.text)
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
  editorHelper.setDefaultText(Widgetcontent.text)
  -- end})).run()
  MarkText(Widgetcontent.text)
end

function startLoadTodoDetail()
  --Thread(Runnable({run=function()
  Widgetcontent.text=details.content
  _STATE._INITCONTENT=details.content
  Widgetcontent.setFocusable(true)
  Widgetcontent.FocusableInTouchMode=true
  editorHelper.setDefaultText(Widgetcontent.text)
  --  end})).run()
  MarkText(Widgetcontent.text)
end

function verfyPwd(key,content)
  import "com.google.android.material.bottomsheet.BottomSheetDialog"

  local dann=import "layout.typepwd"

  import "android.hardware.fingerprint.FingerprintManager"

  callback = FingerprintManager.AuthenticationCallback( {

    onAuthenticationSucceeded=function(result)
      --指纹验证成功
      import "rc4"
      --print(minicrypto.decrypt(key,"Diaryenced"),key)
      decrypt(key,content,minicrypto.decrypt(key,"Diaryenced"))

      dl.dismiss()
    end,

    onAuthenticationError=function(errorCode, errString)
      --指纹验证失败，不可再验

      fingerprint_txt.setText(errString);
      fingerprint_img.setColorFilter(activity.getColor(R.color.NewYearRed));
      fingerprint_img.setImageResource(R.drawable.ic_fingerprint_off)

    end,

    onAuthenticationHelp=function(helpCode, helpString)
      --指纹验证失败，可再验，可能手指过脏，或者移动过快等原因。
      fingerprint_txt.setText(helpString)
      fingerprint_img.setColorFilter(activity.getColor(R.color.NewYearRed));

    end,

    onAuthenticationFailed=function()
      --指纹验证失败，指纹识别失败，可再验，该指纹不是系统录入的指纹。
      --tv.setText("没有找到匹配的指纹信息，请重试");
      fingerprint_txt.setText(AdapLan("验证失败，请重试","Authentication failed, try again"));
      fingerprint_img.setColorFilter(activity.getColor(R.color.NewYearRed));

    end
  })




  dl=BottomSheetDialog(activity)
  dl.setContentView(loadlayout(dann))
  dl.setCanceledOnTouchOutside(false)
  dl.setCancelable(false)
  an=dl.show()
  pcall(function()
    fingerprintManager = activity.getContext().getSystemService(FingerprintManager);

    if (fingerprintManager.isHardwareDetected() && fingerprintManager.hasEnrolledFingerprints() && activity.getSharedData("EnableFingerprint")) then
      fingerprintManager.authenticate(null, null, 0, callback, null);
     else
      fingerprint_widget.setVisibility(View.GONE)
    end
  end)
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
  onEditorAction=function(v,actionId,event)
    if (actionId == EditorInfo.IME_ACTION_SEARCH) then
      --当按了搜索之后关闭软键盘
      (mSearch.getContext().getSystemService(
      Context.INPUT_METHOD_SERVICE)).hideSoftInputFromWindow(
      this.getCurrentFocus().getWindowToken(),
      InputMethodManager.HIDE_NOT_ALWAYS);
      okey.onClick(okey)
      return true;
    end
    return false;
  end
end


Thread(Runnable({
  run=function()
    switch doctype
     case "diaryX" then
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