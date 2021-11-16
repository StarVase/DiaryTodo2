require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
require "StarVase"(this,{enableTheme=true})
import "widget.NoScrollPageView"
import "android.animation.LayoutTransition"
import "com.youbenzi.md2.util.*"
--import"com.StarVase.MyWebView.MyWebView"
import "org.markdown4j.Markdown4jProcessor"
import "android.webkit.WebView"
import "android.support.v4.widget.*"
layout=importFile("notepad","layout")
import "java.io.*"
import "ren.qinc.edit.*"
import "com.youbenzi.mdtool.tool.MDTool"
importFile("notepad","css")

--沉浸状态栏
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(0xffffffff);
if tonumber(Build.VERSION.SDK) >= 23 then
  activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
end
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(mainColor);


--import "muk"
--删掉“--”注释符号以使用中文函数

activity.setContentView(loadlayout(layout))
mEditText = (Widgetcontent);
mPerformEdit = PerformEdit(mEditText);


back.onClick=function()
  activity.finish()
end

graph.Ripple(back,rippleColor)


typein,titlein,path,PATH,content,enc,check=...

if titlein then
  Widgettitle.Text=titlein
end

if typein=="diary" then
  cannotSetTitle=true
  if enc==true then
    Widgetcontent.text="文档"..titlein.."要求您输入密码"
    输入对话框("解密","秘钥",nil,"解密","退出",function() onEditDialogCallback(edit.Text) 关闭对话框(an) return edit.Text end,function() 关闭对话框(an) this.finish() return nil end ,nil,'numberPassword')

    function onEditDialogCallback(edit)
      mPerformEdit.clearHistory()
      pcall(function()
        strch=minicrypto.decrypt(check,edit)
      end)
      if strch =="Diary-enced" then
        passkey="pass"
       else
        passkey="dispasd"
      end
      if check==nil or check=="" then--老版本
        xpcall(function()
          if edit == activity.getSharedData("diaryRC4PSK") then
            str=minicrypto.decrypt(content,edit)
            Widgetcontent.text=str
            key=true
           else
            Widgetcontent.text="秘钥错误"
            key=false
          end
          mPerformEdit.clearHistory()
        end,function()
          Widgetcontent.text="秘钥错误"
          key=false
          mPerformEdit.clearHistory()
        end)
       else--新版本
        xpcall(function()
          if passkey=="pass" then
            str=minicrypto.decrypt(content,edit)
            Widgetcontent.text=str
            key=true
            mPerformEdit.clearHistory()
           else
            Widgetcontent.text="秘钥错误"
            key=false
            mPerformEdit.clearHistory()
          end
        end,function()
          Widgetcontent.text="秘钥错误"
          key=false
          mPerformEdit.clearHistory()
        end)
      end
    end
   else
    Widgetcontent.text=content
  end
end

if typein=="bulb" then
  cannotSetTitle=false
  Widgetcontent.text=content
end

if typein=="favorite" then
  cannotSetTitle=false
  Widgetcontent.text=content
end

if typein=="todo" then
  cannotSetTitle=false
  Widgetcontent.text=content
end

if cannotSetTitle then
  Widgettitle.setFocusable(false)
 else
  Widgettitle.setFocusable(true)
end
checko=check


function 连续撤销()
  if 连续1==true then
    task(10,function()
      mPerformEdit.undo();
      连续撤销()
    end)
  end
end

function 连续重做()
  if 连续2==true then
    task(10,function()
      mPerformEdit.redo();
      连续重做()
    end)
  end
end



if not content then
  Widgetcontent.text=io.open(path):read("*a")
end

mPerformEdit.clearHistory()
graph.Ripple(change,普通波纹)
graph.Ripple(back,普通波纹)
graph.Ripple(undo,普通波纹)
graph.Ripple(redo,普通波纹)
back.onClick=function()
  activity.finish()
end
undo.onClick=function()
  mPerformEdit.undo();
end
redo.onClick=function()
  mPerformEdit.redo();
end
undo.onLongClick=function()
  连续1=true
  连续撤销()
end
redo.onLongClick=function()
  连续2=true
  连续重做()
end
undo.onTouch=function(view,event,JDPUK)
  if event.action==1 then
    连续1=false
  end
end
redo.onTouch=function(view,event,JDPUK)
  if event.action==1 then
    连续2=false
  end
end
change.onClick=function()
  local nowPage=page.getCurrentItem()
  if nowPage==0 then
    page.showPage(nowPage+1)
    else page.showPage(nowPage-1)
  end
end
function save_as_diary(title,path,content,editcon,enc,key)
  if enc==true and key==true then
    encstr="<enc=true>"
    addcon=minicrypto.encrypt(editcon,activity.getSharedData('diaryRC4PSK'))
    check=minicrypto.encrypt("Diary-enced",activity.getSharedData('diaryRC4PSK'))

   elseif enc==false then
    encstr="<enc=false>"
    addcon=editcon
    check="Diary-enced"
   else
    encstr="<enc=true>"
    addcon=content
    if not checko then
      check=""
     else check=check
    end
  end

  con=[[<docType=StarVase_diary>
]]..encstr..[[<date>]]..title..[[</date>
<content>>]]..addcon..[[<</content>
<check>]]..check..[[</check>
]]
  file.writeFile(path,con)

end


function save_as_bulb(title,path,editcon)
  addcon=editcon
  timestamp=os.time()
  if title=="" then
    tltle='无标题'
  end
  con=[[<title>>]]..title..[[<</title>
<content>>]]..addcon..[[<</content>
<ts>>]]..timestamp..[[<</ts>
]]

  file.writeFile(path,con)
end

function save_as_favorite(title,path,editcon)
  addcon=editcon
  timestamp=os.time()
  if title=="" then
    tltle='无标题'
  end
  con=[[<title>>]]..title..[[<</title>
<content>>]]..addcon..[[<</content>
<ts>>]]..timestamp..[[<</ts>
]]

  file.writeFile(path,con)
end

function save_as_todo(title,one,editcon)
  activity.result({one,title,editcon})
end




function save()
  if typein=='diary' then
    save_as_diary(titlein,path,content,Widgetcontent.text,enc,key)
  end
  if typein=='bulb' then
    save_as_bulb(Widgettitle.Text,path,Widgetcontent.text)
  end
  if typein=='favorite' then
    save_as_favorite(Widgettitle.Text,path,Widgetcontent.text)
  end
  if typein=='todo' then
    save_as_todo(Widgettitle.Text,path,Widgetcontent.text)
  end
end



function onOptionsItemSelected(item)
  onKeyDown(nil,"KEYCODE_BACK")
end



function onPause()
  save()
end




function onKeyDown(code,event)
  save()
  if string.find(tostring(event),"KEYCODE_BACK") then
    activity.finish()
  end
end


css=defaultcss

markdown=Widgetcontent.text
--html= MDUtil.markdown2Html(markdown)
--html= Markdown4jProcessor().process(markdown)
html=MDTool.markdown2Html(markdown);
html=[[
<html>
  <style type="text/css">
]]..css..[[
 </style>
 <script>]]..js..[[<script/>
  <body>
]]..html..[[
  </body>
</html>
]]
pweb=webview
--print(html)
refresh.setEnabled(false)
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
pweb.getSettings().setUseWideViewPort(false) --图片自适应
pweb.getSettings().setAcceptThirdPartyCookies(true) --接受第三方cookie
pweb.getSettings().setOffscreenPreRaster(true) --设置预绘制
pweb.getSettings().setRenderPriority(HIGH)--设置高渲染率
pweb.setLayerType(View.LAYER_TYPE_HARDWARE,nil);--硬件加速
pweb.getSettings().setPluginsEnabled(true)--支持插件
pweb.loadDataWithBaseURL(nil,html,"text/html","utf-8",nil);
pweb.removeView(pweb.getChildAt(0))

page.setOnPageChangeListener(PageView.OnPageChangeListener{
  --页面状态改变监听
  onPageScrolled=function(a,b,c)

  end,
  onPageSelected=function(v)
    --页面选中时（停止滚动时）

    pagenum=v
    if tonumber(v) == 1 then
      activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(BGC);
      css=defaultcss

      markdown=Widgetcontent.text
      --html= MDUtil.markdown2Html(markdown)
      html= Markdown4jProcessor().process(markdown)
      
      html=[[
<html>
  <style type="text/css">
]]..css..[[
 </style>
  <body>
]]..html..[[
  </body>
</html>
]]
      pweb.loadDataWithBaseURL(nil,html,"text/html","utf-8",nil);
     else
      activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(mainColor);

    end
  end
})
