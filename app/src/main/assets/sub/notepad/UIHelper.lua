--沉浸状态栏
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(0xffffffff);
if tonumber(Build.VERSION.SDK) >= 23 then
  activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
end
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(mainColor);

parser = WebView(this)
parser.getSettings().setJavaScriptEnabled(true);
parser.loadUrl("file:///android_asset/html/index.html")



WebView.enableSlowWholeDocumentDraw();

activity.setContentView(loadlayout(layout))

editorHelper=EasyEditorHelper(this,Widgetcontent)

Widgetcontent.setLineSpacing(2,1.5)
editTitle=loadlayout({
  RelativeLayout;
  paddingBottom="4dp";
  layout_height="56dp";
  paddingTop="4dp";
  backgroundColor=mainColor,
  gravity="left";
  {
    TextInputEditText;
    Hint="标题";
    singleLine=true;
    textIsSelectable=true;
    lines=1;
    id="Widgettitle",
    inputType="text";

    backgroundColor=0;
    style="?android:attr/windowTitleStyle";
    textColor=titleColor;
    --textColor=autoActionbarAccent(0xFF000000,0xFFFFFFFF);
    --HintTextColor=autoActionbarAccent(0x80000000,0x80FFFFFF);
    padding=0;
    layout_height="48dp";
    gravity="center|left";
  },
})
activity.getSupportActionBar().setTitle(nil)
activity.getSupportActionBar().setDisplayShowCustomEnabled(true)
activity.getSupportActionBar().setCustomView(editTitle)
activity.getSupportActionBar().setDisplayHomeAsUpEnabled(true)
--activity.getSupportActionBar().getNavigationIcon().setColorFilter((0xff7cbcff),PorterDuff.Mode.SRC_IN);
--activity.getSupportActionBar().setHomeAsUpIndicator(getNavigationIcon().setColorFilter((0xff7cbcff),PorterDuff.Mode.SRC_IN))
mEditText = (Widgetcontent);
mPerformEdit = UndoRedoHelper(mEditText);

--创建菜单
function onCreateOptionsMenu(menu)
  local inflater=activity.getMenuInflater()
  inflater.inflate(R.menu.menu_npd,menu)
  menu.add(AdapLan("挂起到通知栏","Send to Notification Bar")).onMenuItemClick=function()
    task(100,function()
      import "android.content.Intent"
      import "android.net.Uri"
      if (not activity.getSystemService(activity.NOTIFICATION_SERVICE).areNotificationsEnabled()) then
        xpcall(function()
          activity.startActivity(Intent()
          .setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
          .setAction("android.settings.APP_NOTIFICATION_SETTINGS")
          .putExtra("app_package",activity.getPackageName())
          .putExtra("android.provider.extra.APP_PACKAGE",activity.getPackageName())
          .putExtra("app_uid"
          ,activity.getPackageManager().getApplicationInfo(activity.getPackageName(),0).uid))
        end,function()
          activity.startActivity(Intent()
          .setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
          .setAction("android.settings.APPLICATION_DETAILS_SETTINGS")
          .setData(Uri.fromParts("package",activity.getPackageName(),nil)))
        end)
      end
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
        notificationChannel= NotificationChannel("10002","挂起文本", NotificationManager.IMPORTANCE_DEFAULT);
        notificationChannel.setDescription("将文本内容挂起到通知栏");
        notificationManager=activity.getSystemService(activity.NOTIFICATION_SERVICE);
        notificationManager.createNotificationChannel(notificationChannel);
      end
      manager=this.getSystemService(Context.NOTIFICATION_SERVICE);
      builder=Notification.Builder(this,"10002");
      builder.setSmallIcon(R.drawable.ic_welcome);
      builder.setContentTitle(Widgettitle.Text);
      builder.setContentText(Widgetcontent.text)
      builder.setAutoCancel(false)
      notification=builder.build();
      notificationManagerCompat=NotificationManager.from(this);
      notificationManagerCompat.notify(os.time(),builder.build());

    end)
  end

end

function onOptionsItemSelected(item)
  --  task(1,function()
  local id=item.getItemId()
  switch id
   case android.R.id.home
    AUTO_SWITCH_OR_FINISH()
   case R.id.menu_npd_undo
    editorHelper.undo();
   case R.id.menu_npd_redo
    editorHelper.redo();
   case R.id.menu_npd_save
    save()
   case R.id.menu_npd_notsave
    dropEdition()
   case R.id.menu_npd_asimage
    asImage()
   case R.id.menu_npd_ashtml
    ashtml()
   case R.id.menu_npd_asmd
    asmd()
   case R.id.menu_npd_statistics
    statistics()
  end
  --  end)
end
--[[back.onClick=function()
  activity.finish()
end]]

--graph.Ripple(back,rippleColor)

import "android.content.res.ColorStateList"
--fab背景颜色
fab.setSupportBackgroundTintList(ColorStateList.valueOf(mainColor))
--fab图标颜色
fab.setColorFilter(titleColor)
--fab图标
fab.setImageResource(R.drawable.ic_check)
--fab波纹颜色
fab.setRippleColor(ColorStateList.valueOf(普通波纹))

pcall(function()
  if activity.getSharedData("TTFPath")&&File(activity.getSharedData("TTFPath")).isFile() then
    font=Typeface.createFromFile(File(activity.getSharedData("TTFPath")))
    Widgetcontent.setTypeface(font)
  end
end)

function dropEdition()
  if (_STATE._INITCONTENT) then
    Widgetcontent.setText(_STATE._INITCONTENT)
  end
end



fab.onClick=function()
  local nowPage=page.getCurrentItem()
  if nowPage==0 then
    page.setCurrentItem(nowPage+1)
   else page.setCurrentItem(nowPage-1)
  end
end

pweb=webView
pweb.getSettings().setDisplayZoomControls(false); --隐藏自带的右下角缩放控件
--pweb.getSettings().setSupportZoom(true); --支持网页me缩放
pweb.getSettings().setDomStorageEnabled(true); --dom储存数据
pweb.getSettings().setDatabaseEnabled(true); --数据库
pweb.getSettings().setAppCacheEnabled(true); --启用缓存
pweb.getSettings().setAllowFileAccess(true);--允许访问文件
pweb.getSettings().setLoadsImagesAutomatically(true);--图片自动加载
--pweb.getSettings().setSaveFormData(true); --保存表单数据，就是输入框的内容，但并不是全部输入框都会储存
pweb.getSettings().setAllowContentAccess(true); --允许访问内容
pweb.getSettings().setJavaScriptEnabled(true); --支持js脚本
--pweb.getSettings().setUseWideViewPort(true) --图片自适应
--pweb.getSettings().setAcceptThirdPartyCookies(true) --接受第三方cookie
pweb.getSettings().setOffscreenPreRaster(true) --设置预绘制
pweb.getSettings().setRenderPriority(HIGH)--设置高渲染率
pweb.setLayerType(View.LAYER_TYPE_HARDWARE,nil);--硬件加速
--pweb.getSettings().setPluginsEnabled(true)--支持插件
pweb.getChildAt(0).getLayoutParams().height=DensityUtil.dp2px(this,4)
-- 封包前loadfile100行
-- 封包前loadfile100行
-- 封包前loadfile100行
-- 封包前loadfile100行
-- 封包前loadfile100行



function refreshSymbolBar(state)
  if state then
    loadedSymbolBar=true
    local ps=require("BarFunction")
    for index,content in ipairs(ps) do
      ps_bar.addView(newPsButton(content))
    end
    ps=nil
    if activity.getSharedData("FuncBarMargin") then
      --左上右下
      bottomAppBar.getChildAt(0).setPadding(math.dp2int(8),0,math.dp2int(8),math.dp2int(28))
    end

    bottomAppBar.setVisibility(View.VISIBLE)
  end
end
function newPsButton(icary)
  return loadlayout({
    AppCompatImageView;
    onClick=icary.func;
    ImageResource=icary.icon,
    colorFilter=textColor,

    layout_height="fill";
    --padding="8dp";
    paddingLeft="8dp";
    paddingRight="8dp";
    --padding="16dp";
    focusable=true;
    background=graph.Ripple(nil,淡色强调波纹),
  })
end


function ashtml()
  if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) then
    content=string.gsub(Widgetcontent.getText().toString(),"\n", "\\n")
    content=string.gsub(content,"\"", "\\\"")
    content=string.gsub(content,"'", "\\'")
    parser.evaluateJavascript("javascript:MarkText(\"" ..content.."\");", ValueCallback({
      onReceiveValue=function(html)
        html=UnicodeUtil.decode(html)
        html= loadstring("return "..html)() or ""
        HtmlContent=[[<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>]]..Widgettitle.getText().toString()..[[ - DiaryTodo</title>
</head>
<body>
<h1 id="filetitle">]]..Widgettitle.getText().toString()..[[</h1>
]]..html..[[</body>
</html>]]
        output=path.envdir.."/documents/DiaryTodo/html/"..Widgettitle.getText().toString().."_"..tostring(os.date("%Y%m%d-%H%M%S"))..".html"
        if pcall(function()file.writeFile(output,HtmlContent)end) then
          MyToast.showSnackBar(activity.getString(R.string.toast_ashtmlsuc)..output)
          -- subed("markdownX",path.envdir.."/documents/DiaryTodo/html/")
          sharing(output)
         else
          MyToast.showSnackBar(activity.getString(R.string.toast_ashtmltry))
        end
      end
    }));
   else
    MyToast.showSnackBar(activity.getString(R.string.toast_ashtmlfail))
  end
end

function asImage()
  MarkText(Widgetcontent.text)
  task(500,function()
    output=Widgettitle.getText().toString().."_"..tostring(os.date("%Y%m%d-%H%M%S"))..".png"
    print(output)
    MyBitmap.saveAsPng(ScreenshotHelper.shotWebView(webView),output)
    if pcall(function()MyBitmap.saveAsPng(ScreenshotHelper.shotWebView(webView),output)end) then
      MyToast.showSnackBar(activity.getString(R.string.toast_ashtmlsuc)..path.envdir.."/Pictures/DiaryTodo/"..output)
      sharing(path.envdir.."/Pictures/DiaryTodo/"..output)
     else
      MyToast.showSnackBar(activity.getString(R.string.toast_ashtmltry))

    end
  end)
end

function asmd()
  output=path.envdir.."/documents/DiaryTodo/markdown/"..Widgettitle.getText().toString().."_"..tostring(os.date("%Y%m%d-%H%M%S"))..".md"
  file.writeFile(output,Widgetcontent.getText().toString())
  if pcall(function()file.writeFile(output,Widgetcontent.getText().toString())end) then
    MyToast.showSnackBar(activity.getString(R.string.toast_ashtmlsuc)..output)
    sharing(output)
   else
    MyToast.showSnackBar(activity.getString(R.string.toast_ashtmltry))
  end
end

function MarkText(text)
  Thread(Runnable({run=function()
      import "android.webkit.ValueCallback"
      content=string.gsub(text,"\n", "\\n")
      content=string.gsub(content,"\"", "\\\"")
      content=string.gsub(content,"'", "\\'")
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) then --版本太低尽早放弃吧
        parser.evaluateJavascript("javascript:MarkText(\"" ..content .."\");",ValueCallback({
          onReceiveValue=function(html)
            html=UnicodeUtil.decode(html)
            html= loadstring("return "..html)() or "";
            --print(html)
            html=[[<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="file:///android_asset/html/css/katex.min.css">
<link rel="stylesheet" type="text/css" href="file:///android_asset/html/github-markdown.css">
<link rel="stylesheet" type="text/css" href="file:///android_asset/html/public/highlight/styles/github.min.css">
</head>
<body>]]..html..[[</body>
</html>]]
            if details.path then
              abspath = "file://"..File(details.path).getParent().."/"
            end
            webView.loadDataWithBaseURL(abspath,html,"text/html", "UTF-8", nil)
            --print("file://"..File(details.path).getParent())

          end
        }))
      end
    end})).run()
end
function statistics()
  MyToast.showSnackBar(tostring(editorHelper.getCurrentCount()))
end

function sharing(path)
  import "android.webkit.MimeTypeMap"
  import "android.content.Intent"
  import "android.net.Uri"
  import "java.io.File"
  FileName=tostring(File(path).Name)
  ExtensionName=FileName:match("%.(.+)")
  Mime=MimeTypeMap.getSingleton().getMimeTypeFromExtension(ExtensionName)
  print(ExtensionName,Mine)
  intent = Intent()
  intent.setAction(Intent.ACTION_SEND)
  intent.setType(Mime)
  local file = File(path)
  --uri = Uri.fromFile(file)
  intent.putExtra(Intent.EXTRA_STREAM,uri)
  intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
  activity.startActivity(Intent.createChooser(intent, "分享到:"))
end

--首次启动

if (!activity.getSharedData("EditorGuide")) then
  AlertDialog.Builder(this)
  .setTitle(AdapLan("开始！","Let's Start!"))
  .setMessage(AdapLan("在此，您可以使用Markdown语法进行编辑，点击右下角悬浮球可以切换编辑/预览模式。所有的更改将会在检测到按键活动（包括后置指纹传感器）和退出时自动保存。点击菜单中的撤销编辑选择可以恢复初始状态。开始享用吧~","Here, you can use Markdown syntax to edit, and click the floating ball in the lower right corner to switch the edit/preview mode. All changes will be automatically saved when key activity is detected (including the rear-mounted fingerprint sensor) and on exit. Click Undo Edit selection in the menu to restore the original state. Enjoy~"))
  .setPositiveButton(AdapLan("确定","Okey"),{onClick=function(v) activity.setSharedData("EditorGuide",true)end})
  .show()

end

function onActivityResult(requestCode,resultCode,data)
  local editText = Widgetcontent
  local start = editText.getSelectionStart();
  local End = editText.getSelectionEnd();
  if (requestCode == 2) then
    -- 从相册返回的数据
    --Log.e(this.getClass().getName(), "Result:" + data.toString());
    if (data != nil) then
      -- 得到图片的全路径
      uri = data.getData();
      linkDisplayText = "Image";

      content = "![" .. linkDisplayText .. "]" .. "(file://" .. UriUtils.UriToImporteds(this,uri) .. ")";
      if (start == End) then
        editText.getText().insert(start, content);
       else
        editText.getText().replace(start, End, content);
      end

    end
  end

end