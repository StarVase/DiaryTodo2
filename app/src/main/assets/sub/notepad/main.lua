require "import"
require "StarVase"(this,{enableTheme=true})
TimingUtil.setName("Notepad")
import "com.google.android.material.floatingactionbutton.FloatingActionButton"
import "android.animation.LayoutTransition"
import "android.webkit.*"
import "java.io.*"

import "androidx.appcompat.widget.AppCompatEditText"
import "layout"

doctype,title,details=...

if !doctype then
  activity.finish()
end

pcall(lambda -> activity.setSwipeBackEnable(false))

import "UIHelper"
import "fileSave"
import "fileLoader"


if title then
  Widgettitle.Text=title
end
if cannotSetTitle then
  Widgettitle.setFocusable(false)
 else
  Widgettitle.setFocusable(true)
end
if not content then
  --Widgetcontent.text=io.open(path):read("*a")
end
mPerformEdit.clearHistory()

arg=0
function AUTO_SWITCH_OR_FINISH()
  save()
  if page.getCurrentItem()~=0 then
    page.showPage(0)
   else
    if arg+2 > tonumber(os.time()) then
      if doctype == "todoDetail" then
        activity.result({tostring(Widgettitle.Text),tostring(Widgetcontent.text)})
       else
        activity.finish()
      end
     else
      MyToast.showSnackBar(activity.getString(R.string.toast_saveexit))

      arg=tonumber(os.time())
    end
  end
end


function onPause()
  save()
  if doctype == "todoDetail" then
    activity.result({tostring(Widgettitle.Text),tostring(Widgetcontent.text)})
  end
end



Widgetcontent.addTextChangedListener{
  onTextChanged=lambda(text) -> MarkText(text.toString())
}



function onKeyUp(code,event)
  save()
  if string.find(tostring(event),"KEYCODE_BACK") then
    AUTO_SWITCH_OR_FINISH()
    return true
  end
end
webView.setWebViewClient({
  shouldOverrideUrlLoading=(lambda(view,url) -> autoDark()),
  onPageFinished=(lambda(view,url) -> autoDark()),
  onPageStarted=lambda(view,url,favicon) -> autoDark()
})
page.setOnPageChangeListener(PageView.OnPageChangeListener{
  --页面状态改变监听
  onPageScrolled=(lambda(a,b,c) -> task(1,function()
    end)),
  onPageSelected=lambda(v) -> MarkText(Widgetcontent.text)
})
function onKeyShortcut(keyCode, event)
  local filteredMetaState = event.getMetaState() & ~KeyEvent.META_CTRL_MASK;
  if (KeyEvent.metaStateHasNoModifiers(filteredMetaState)) then
    switch(keyCode)
     case
      KeyEvent.KEYCODE_P
      --预览
      page.showPage(1)
      return true;
     case
      KeyEvent.KEYCODE_S
      save();
      return true;
     case
      KeyEvent.KEYCODE_E
      --编辑
      page.showPage(0)
      return true;
     case
      KeyEvent.KEYCODE_R
      mPerformEdit.redo();
      return true;
     case
      KeyEvent.KEYCODE_Z
      mPerformEdit.undo();
      return true;
     case
      KeyEvent.KEYCODE_M
      MarkText(Widgetcontent.text)
    end
  end
  return false;
end

function autoDark()
  if AppTheme.isDarkTheme() then
    import "previewerDarkMode"
  end
end

webView.onLongClick=function(view)
  local hitTestResult=webView.getHitTestResult()
  local hitType=hitTestResult.getType()
  local hitExtra=hitTestResult.getExtra()
  if hitType==WebView.HitTestResult.IMAGE_TYPE or hitType== WebView.HitTestResult.SRC_IMAGE_ANCHOR_TYPE then
    activity.newActivity("photopresenter/main",{hitExtra})
  end
end
webView.setWebViewClient(LuaWebView.LuaWebViewClient({
  shouldOverrideUrlLoading=function(view,url)
    return true;
  end
}))
