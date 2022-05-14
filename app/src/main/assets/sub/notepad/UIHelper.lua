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

end

function onOptionsItemSelected(item)
  task(1,function()
    local id=item.getItemId()
    switch id
     case android.R.id.home
      AUTO_SWITCH_OR_FINISH()
     case R.id.menu_npd_undo
      mPerformEdit.undo();
     case R.id.menu_npd_redo
      mPerformEdit.redo();
     case R.id.menu_npd_save
      save()
     case R.id.menu_npd_asimage
      asImage()
     case R.id.menu_npd_ashtml
      ashtml()
     case R.id.menu_npd_asmd
      asmd()
    end
  end)
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




fab.onClick=function()
  local nowPage=page.getCurrentItem()
  if nowPage==0 then
    page.setCurrentItem(nowPage+1)
   else page.setCurrentItem(nowPage-1)
  end
end

pweb=webView
pweb.getSettings().setDisplayZoomControls(false); --隐藏自带的右下角缩放控件
pweb.getSettings().setSupportZoom(true); --支持网页me缩放
pweb.getSettings().setDomStorageEnabled(true); --dom储存数据
pweb.getSettings().setDatabaseEnabled(true); --数据库
pweb.getSettings().setAppCacheEnabled(true); --启用缓存
pweb.getSettings().setAllowFileAccess(true);--允许访问文件
pweb.getSettings().setLoadsImagesAutomatically(true);--图片自动加载
pweb.getSettings().setSaveFormData(true); --保存表单数据，就是输入框的内容，但并不是全部输入框都会储存
pweb.getSettings().setAllowContentAccess(true); --允许访问内容
pweb.getSettings().setJavaScriptEnabled(true); --支持js脚本
--pweb.getSettings().setUseWideViewPort(true) --图片自适应
pweb.getSettings().setAcceptThirdPartyCookies(true) --接受第三方cookie
pweb.getSettings().setOffscreenPreRaster(true) --设置预绘制
pweb.getSettings().setRenderPriority(HIGH)--设置高渲染率
pweb.setLayerType(View.LAYER_TYPE_HARDWARE,nil);--硬件加速
pweb.getSettings().setPluginsEnabled(true)--支持插件
pweb.getChildAt(0).getLayoutParams().height=DensityUtil.dp2px(this,4)

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
        if pcall(function()file.writeFile(path.envdir.."/documents/DiaryTodo/html/"..Widgettitle.getText().toString().."_"..tostring(os.date())..".html",HtmlContent)end) then
          MyToast.showSnackBar(activity.getString(R.string.toast_ashtmlsuc).."/sdcard/documents/DiaryTodo/html/"..Widgettitle.getText().toString().."_"..tostring(os.date())..".html")
          subed("markdownX",path.envdir.."/documents/DiaryTodo/html/")
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
    if pcall(function()MyBitmap.saveAsPng(ScreenshotHelper.shotWebView(webView),Widgettitle.getText().toString().."_"..tostring(os.date())..".png")end) then
      MyToast.showSnackBar(activity.getString(R.string.toast_ashtmlsuc).."/sdcard/Pictures/DiaryTodo/"..Widgettitle.getText().toString().."_"..tostring(os.date())..".png")
     else
      MyToast.showSnackBar(activity.getString(R.string.toast_ashtmltry))

    end
  end)
end

function asmd()
  if pcall(function()file.writeFile(path.envdir.."/documents/DiaryTodo/markdown/"..Widgettitle.getText().toString().."_"..tostring(os.date())..".md",Widgetcontent.getText().toString())end) then
    MyToast.showSnackBar(activity.getString(R.string.toast_ashtmlsuc).."/sdcard/documents/DiaryTodo/markdown/"..Widgettitle.getText().toString().."_"..tostring(os.date())..".md")
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
