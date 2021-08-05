--沉浸状态栏
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(0xffffffff);
if tonumber(Build.VERSION.SDK) >= 23 then
  activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
end
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(mainColor);


activity.setContentView(loadlayout(layout))

editTitle=loadlayout({
  RelativeLayout;
  layout_width="fill";
  paddingBottom="4dp";
  layout_height="56dp";
  paddingTop="4dp";
  backgroundColor=mainColor,
  gravity="left";
  {
    AppCompatEditText;
    layout_width="fill";
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
  {
    LinearLayout,
    layout_height="fill",
    layout_width="wrap",
    orientation="horizontal",
    layout_alignParentRight=true,
    {
      ImageButton;
      layout_width="30dp";
      style="?android:attr/buttonBarButtonStyle";
      padding="0dp";
      id="undo";
      layout_marginLeft="10dp";
      paddingRight="2dp";
      layout_marginRight="12dp";
      layout_height="fill";
      src=lp..'/images/last.png';
      background="#00000000";
      colorFilter=titleColor;
    };
    {
      ImageButton;
      layout_width="30dp";
      style="?android:attr/buttonBarButtonStyle";
      padding="0dp";
      id="redo";
      layout_marginLeft="10dp";
      paddingRight="2dp";
      layout_marginRight="12dp";
      layout_height="fill";
      src=lp..'/images/next.png';
      background="#00000000";
      colorFilter=titleColor;
    };

  },
})
activity.getSupportActionBar().setTitle(nil)
activity.getSupportActionBar().setDisplayShowCustomEnabled(true)
activity.getSupportActionBar().setCustomView(editTitle)
activity.getSupportActionBar().setDisplayHomeAsUpEnabled(true)
--activity.getSupportActionBar().getNavigationIcon().setColorFilter((0xff7cbcff),PorterDuff.Mode.SRC_IN);
--activity.getSupportActionBar().setHomeAsUpIndicator(getNavigationIcon().setColorFilter((0xff7cbcff),PorterDuff.Mode.SRC_IN))
mEditText = (Widgetcontent);
mPerformEdit = PerformEdit(mEditText);


m = {
  { MenuItem,
    title = "撤销",
    id = "undo",
    icon = "/images/last.png ", },
  { MenuItem,
    title = "重做",
    id = "redo",
    icon = "/images/next.png", },
  { MenuItem,
    title = "保存",
    id = "save",
    icon = "ic_content_save.png", },
  { SubMenu,
    title = "文件...",
    { MenuItem,
      title = "保存",
      id = "file_save", },
  },
  { SubMenu,
    title = "导出...",
    { MenuItem,
      title = "As Markdown(.md)",
      id = "output_asmd", },
  },
}
optmenu = {}
function onCreateOptionsMenu(menu)
  loadmenu(menu, m, optmenu, 3)
end





function onOptionsItemSelected(item)
  local id=item.getItemId()
  if id==android.R.id.home then
    AUTO_SWITCH_OR_FINISH()
  end
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
--fab图标bitmap
fab.setImageBitmap(loadbitmap("drawable/file-swap-outline.png"))
--fab波纹颜色
fab.setRippleColor(ColorStateList.valueOf(普通波纹))



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



graph.Ripple(undo,普通波纹)
graph.Ripple(redo,普通波纹)

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
fab.onClick=function()
  local nowPage=page.getCurrentItem()
  if nowPage==0 then
    page.showPage(nowPage+1)
   else page.showPage(nowPage-1)
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
pweb.loadUrl("file:///"..activity.getLuaDir().."/html/index.html")
pweb.removeView(pweb.getChildAt(0))
