require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"

--import "muk"
--删掉“--”注释符号以使用中文函数

require "import"
--import "mods.imports"
import "android.graphics.drawable.GradientDrawable"
require "import"
import "android.content.pm.PackageManager"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.graphics.drawable.ColorDrawable"
import "android.view.*"

import "android.animation.*"

import "android.net.*"

import "android.text.*"

import "android.content.*"

import "android.graphics.*"

import "android.renderscript.*"

import "java.lang.Math"

import "java.security.*"

import "java.io.*"

import "java.util.*"

import "java.net.URL"

import "android.content.res.ColorStateList"

import "android.net.Uri"

import "android.util.Base64"


import "androidx.*"

import "android.webkit.WebSettings"

import "android.provider.Settings"

import "android.Manifest"

import "android.animation.Animator"

--import 'activities.theme'

function svd(url,path,name)
  import "android.content.Context"
  import "android.net.Uri"

  downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
  url=Uri.parse(url);
  request=DownloadManager.Request(url);
  request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
  request.setDestinationInExternalPublicDir(path,name);
  request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
  downloadManager.enqueue(request);
end







状态栏高度=activity.getResources().getDimensionPixelSize(luajava.bindClass("com.android.internal.R$dimen")().status_bar_height)
型号 = Build.MODEL
SDK版本 = tonumber(Build.VERSION.SDK)
安卓版本 = Build.VERSION.RELEASE
ROM类型 = string.upper(Build.MANUFACTURER)
内部存储路径=Environment.getExternalStorageDirectory().toString().."/"

应用版本名=activity.getPackageManager().getPackageInfo(activity.getPackageName(), PackageManager.GET_ACTIVITIES).versionName;
应用版本=activity.getPackageManager().getPackageInfo(activity.getPackageName(), PackageManager.GET_ACTIVITIES).versionCode;

function 状态栏颜色(n)
  window=activity.getWindow()
  window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
  window.setStatusBarColor(n)
  if n==0x3f000000 then
    if SDK版本>=23 then
      window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR)
      window.setStatusBarColor(0xffffffff)
    end
  end
end

function dp2px(dpValue)
  local scale = activity.getResources().getDisplayMetrics().scaledDensity
  return dpValue * scale + 0.5
end

function px2dp(pxValue)
  local scale = activity.getResources().getDisplayMetrics().scaledDensity
  return pxValue / scale + 0.5
end

function px2sp(pxValue)
  local scale = activity.getResources().getDisplayMetrics().scaledDensity;
  return pxValue / scale + 0.5
end

function sp2px(spValue)
  local scale = activity.getResources().getDisplayMetrics().scaledDensity
  return spValue * scale + 0.5
end

function 写入文件(路径,内容)
  xpcall(function()
    f=File(tostring(File(tostring(路径)).getParentFile())).mkdirs()
    io.open(tostring(路径),"w"):write(tostring(内容)):close()
  end,function()
    提示("写入文件 "..路径.." 失败")
  end)
end

function 读取文件(路径)
  if 文件是否存在(路径) then
    rtn=io.open(路径):read("*a")
   else
    rtn=""
  end
  return rtn
end

function 复制文件(from,to)
  xpcall(function()
    LuaUtil.copyDir(from,to)
  end,function()
    提示("复制文件 从 "..from.." 到 "..to.." 失败")
  end)
end

function 创建文件夹(file)
  xpcall(function()
    File(file).mkdir()
  end,function()
    提示("创建文件夹 "..file.." 失败")
  end)
end

function 创建文件(file)
  xpcall(function()
    File(file).createNewFile()
  end,function()
    提示("创建文件 "..file.." 失败")
  end)
end

function 创建多级文件夹(file)
  xpcall(function()
    File(file).mkdirs()
  end,function()
    提示("创建文件夹 "..file.." 失败")
  end)
end

function 文件是否存在(file)
  return File(file).exists()
end

function 删除文件(file)
  xpcall(function()
    LuaUtil.rmDir(File(file))
  end,function()
    提示("删除文件(夹) "..file.." 失败")
  end)
end

function 文件修改时间(path)
  f = File(path);
  time = f.lastModified()
  return time
end

function 内置存储(t)
  return Environment.getExternalStorageDirectory().toString().."/"..t
end

function 压缩(from,to,name)
  ZipUtil.zip(from,to,name)
end

function 主题(str)
  --str="夜"
  全局主题值=str
  if 全局主题值=="Day" then
    primaryc="#448aff"
    secondaryc="#fdd835"
    textc="#212121"
    stextc="#424242"
    backgroundc="#ffffffff"
    barbackgroundc="#efffffff"
    cardbackc="#ffffffff"
    viewshaderc="#00000000"
    grayc="#ECEDF1"
    状态栏颜色(0x3f000000)
    _window = activity.getWindow();
    --_window.setBackgroundDrawable(ColorDrawable(0x0));
    _wlp = _window.getAttributes();
    _wlp.gravity = Gravity.BOTTOM;
    _wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
    _wlp.height = WindowManager.LayoutParams.MATCH_PARENT;--WRAP_CONTENT
    _window.setAttributes(_wlp);
    activity.setTheme(android.R.style.Theme_DeviceDefault_Light_NoActionBar)
   elseif 全局主题值=="Night" then
    primaryc="#ff3368c0"
    secondaryc="#ffbfa328"
    textc="#808080"
    stextc="#666666"
    backgroundc="#ff191919"
    barbackgroundc="#ef191919"
    cardbackc="#ff212121"
    viewshaderc="#80000000"
    grayc="#212121"
    状态栏颜色(0xff191919)
    _window = activity.getWindow();
    --_window.setBackgroundDrawable(ColorDrawable(0xff191919));
    _wlp = _window.getAttributes();
    _wlp.gravity = Gravity.BOTTOM;
    _wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
    _wlp.height = WindowManager.LayoutParams.MATCH_PARENT;--WRAP_CONTENT
    _window.setAttributes(_wlp);
    activity.setTheme(android.R.style.Theme_DeviceDefault_NoActionBar)
  end
end

if this.getSharedData("Theme") then
  --print(this.getSharedData("Theme"))
  主题(this.getSharedData("Theme"))
 else
  this.setSharedData("Theme","Day")
  return true
end

pcall(function()activity.getActionBar().hide()end)

function 沉浸状态栏()
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
end

function activity背景颜色(color)
  _window = activity.getWindow();
  _window.setBackgroundDrawable(ColorDrawable(color));
  _wlp = _window.getAttributes();
  _wlp.gravity = Gravity.BOTTOM;
  _wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
  _wlp.height = WindowManager.LayoutParams.MATCH_PARENT;--WRAP_CONTENT
  _window.setAttributes(_wlp);
end

function 转0x(j)
  if #j==7 then
    jj=j:match("#(.+)")
    jjj=tonumber("0xff"..jj)
   else
    jj=j:match("#(.+)")
    jjj=tonumber("0x"..jj)
  end
  return jjj
end

function 提示(t)
  local tsbj={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    gravity="center";
    --background="#ffffffff";
    --padding="8dp";
    --paddingTop="64dp";
    {
      CardView;
      layout_width="-1";
      layout_height="-2";
      Elevation="0";
      layout_margin="8dp";
      radius="4dp";
      background="#ef424242";
      {
        LinearLayout;
        layout_width=activity.getWidth()-16;
        layout_height="-1";
        {
          TextView;
          layout_width="-1";
          layout_height="-1";
          textSize="14sp";
          paddingRight="16dp";
          paddingLeft="16dp";
          paddingTop="12dp";
          Typeface=Typeface.createFromFile(File(activity.getLuaDir().."/res/fonts/product.ttf"));
          paddingBottom="12dp";
          gravity="center";
          Text=t;
          textColor="#ffffffff";
        };
      };
    };
  };
  Toast.makeText(activity,t,Toast.LENGTH_LONG).setGravity(Gravity.BOTTOM|Gravity.CENTER, 0, 0).setView(loadlayout(tsbj)).show()
end--

SnackerBar={shouldDismiss=true}

function Snakebar(fill)
  local w=activity.width

  local layout={
    LinearLayout,
    Gravity="bottom",
    paddingTop=activity.getResources().getDimensionPixelSize(luajava.bindClass("com.android.internal.R$dimen")().status_bar_height);
    {
      CardView,
      layout_height=-2,
      layout_width=-1,
      CardElevation="0",
      CardBackgroundColor="#FF202124",
      Radius="4dp",
      layout_margin="16dp";
      {
        LinearLayout,
        layout_height=-2,
        layout_width=-1,
        gravity="left|center",
        padding="16dp";
        --paddingTop="12dp";
        --paddingBottom="12dp";
        {
          TextView,
          textColor=0xffffffff,
          textSize="14sp";
          layout_height=-2,
          layout_width=-2,
          text=fill;
          Typeface=字体("fonts/product")
        },
      }
    }
  }

  local function addView(view)
    local mLayoutParams=ViewGroup.LayoutParams
    (-1,-1)
    activity.Window.DecorView.addView(view,mLayoutParams)
  end

  local function removeView(view)
    activity.Window.DecorView.removeView(view)
  end

  function indefiniteDismiss(snackerBar)
    task(3000,function()
      if snackerBar.shouldDismiss==true then
        snackerBar:dismiss()
       else
        indefiniteDismiss(snackerBar)
      end
    end)
  end

  function SnackerBar:dismiss()
    local view=self.view
    view.animate().translationY(300)
    .setDuration(400)
    .setInterpolator(AccelerateDecelerateInterpolator())
    .setListener(Animator.AnimatorListener{
      onAnimationEnd=function()
        removeView(view)
      end
    }).start()
  end

  SnackerBar.__index=SnackerBar

  function SnackerBar.build()
    local mSnackerBar={}
    setmetatable(mSnackerBar,SnackerBar)
    mSnackerBar.view=loadlayout(layout)
    mSnackerBar.bckView=mSnackerBar.view
    .getChildAt(0)
    mSnackerBar.textView=mSnackerBar.bckView
    .getChildAt(0)
    local function animate(v,tx,dura)
      ValueAnimator().ofFloat({v.translationX,tx}).setDuration(dura)
      .addUpdateListener( ValueAnimator.AnimatorUpdateListener
      {
        onAnimationUpdate=function( p1)
          local f=p1.animatedValue
          v.translationX=f
          v.alpha=1-math.abs(v.translationX)/w
        end
      }).addListener(ValueAnimator.AnimatorListener{
        onAnimationEnd=function()
          if math.abs(tx)>=w then
            removeView(mSnackerBar.view)
          end
        end
      }).start()
    end
    local frx,p,v,fx=0,0,0,0
    mSnackerBar.bckView.setOnTouchListener(View.OnTouchListener{
      onTouch=function(view,event)
        if event.Action==event.ACTION_DOWN then
          mSnackerBar.shouldDismiss=false
          frx=event.x-dp2px(8)
          fx=event.x-dp2px(8)
         elseif event.Action==event.ACTION_MOVE then
          if math.abs(event.rawX-dp2px(8)-frx)>=2 then
            v=math.abs((frx-event.rawX-dp2px(8))/(os.clock()-p)/1000)
          end
          p=os.clock()
          frx=event.rawX-dp2px(8)
          view.translationX=frx-fx
          view.alpha=1-math.abs(view.translationX)/w
         elseif event.Action==event.ACTION_UP then
          mSnackerBar.shouldDismiss=true
          local tx=view.translationX
          if tx>=w/5 then
            animate(view,w,(w-tx)/v)
           elseif tx>0 and tx<w/5 then
            animate(view,0,tx/v)
           elseif tx<=-w/5 then
            animate(view,-w,(w+tx)/v)
           else
            animate(view,0,-tx/v)
          end
          fx=0
        end
        return true
      end
    })
    return mSnackerBar
  end

  function SnackerBar:show()
    local view=self.view
    addView(view)
    view.translationY=300
    view.animate().translationY(0)
    .setInterpolator(AccelerateDecelerateInterpolator())
    .setDuration(400).start()
    indefiniteDismiss(self)
  end

  SnackerBar.build():show()
end

function 随机数(最小值,最大值)
  return math.random(最小值,最大值)
end

function 设置视图(t)
  activity.setContentView(loadlayout(t))
end

function 信息判断(code)
  if code/200==1 then
    return true
   else
    return false
  end
end

function 静态渐变(a,b,id,fx)
  if fx=="竖" then
    fx=GradientDrawable.Orientation.TOP_BOTTOM
  end
  if fx=="横" then
    fx=GradientDrawable.Orientation.LEFT_RIGHT
  end
  drawable = GradientDrawable(fx,{
    a,--右色
    b,--左色
  });
  id.setBackgroundDrawable(drawable)
end

ripple = activity.obtainStyledAttributes({android.R.attr.selectableItemBackgroundBorderless}).getResourceId(0,0)
ripples = activity.obtainStyledAttributes({android.R.attr.selectableItemBackground}).getResourceId(0,0)

function 波纹(id,lx)
  xpcall(function()
    for index,content in pairs(id) do
      if lx=="圆白" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{0x3fffffff})))
      end
      if lx=="方白" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3fffffff})))
      end
      if lx=="圆黑" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{0x3f000000})))
      end
      if lx=="方黑" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3f000000})))
      end
      if lx=="圆主题" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{0x3f448aff})))
      end
      if lx=="方主题" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3f448aff})))
      end
      if lx=="圆自适应" then
        if 全局主题值=="Day" then
          content.setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{0x3f000000})))
         else
          content.setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{0x3fffffff})))
        end
      end
      if lx=="方自适应" then
        if 全局主题值=="Day" then
          content.backgroundDrawable=(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3f000000})))
         else
          content.setBackgroundDrawable(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3fffffff})))
        end
      end
    end
  end,function(e)end)
end

function 控件可见(a)
  a.setVisibility(View.VISIBLE)
end

function 控件不可见(a)
  a.setVisibility(View.INVISIBLE)
end

function 控件隐藏(a)
  a.setVisibility(View.GONE)
end

function 对话框按钮颜色(dialog,button,WidgetColor)
  if button==1 then
    dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(WidgetColor)
   elseif button==2 then
    dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(WidgetColor)
   elseif button==3 then
    dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(WidgetColor)
  end
end

function 关闭对话框(an)
  an.dismiss()
end

function 控件圆角(view,radiu,InsideColor)
  drawable = GradientDrawable()
  drawable.setShape(GradientDrawable.RECTANGLE)
  drawable.setColor(InsideColor)
  drawable.setCornerRadii({radiu,radiu,radiu,radiu,radiu,radiu,radiu,radiu});
  view.setBackgroundDrawable(drawable)
end

function 双按钮对话框(bt,nr,qd,qx,qdnr,qxnr,gb)
  if mode=="Dark" then

    bwz=0x3fffffff
   elseif mode=="Auto" then

   else
    bwz=0x3f000000
  end

  local gd2 = GradientDrawable()
  gd2.setColor(转0x(backgroundc))--填充
  local radius=dp2px(16)
  gd2.setCornerRadii({radius,radius,radius,radius,0,0,0,0})--圆角
  gd2.setShape(0)--形状，0矩形，1圆形，2线，3环形

  if dialog==nil then
    dialog='0xff444400'
  end
  local dann={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    {
      LinearLayout;
      orientation="vertical";
      layout_width="-1";
      layout_height="-2";
      Elevation="4dp";
      BackgroundDrawable=gd2;
      --background=dialog,
      id="ztbj";
      {
        TextView;
        layout_width="-1";
        layout_height="-2";
        textSize="20sp";
        layout_marginTop="24dp";
        layout_marginLeft="24dp";
        layout_marginRight="24dp";
        Text=bt;
        Typeface=字体("fonts/product-Bold");
        textColor=forceColor;
      };
      {
        ScrollView;
        layout_width="-1";
        layout_height="-1";
        {
          TextView;
          layout_width="-1";
          layout_height="-2";
          textSize="14sp";
          layout_marginTop="8dp";
          layout_marginLeft="24dp";
          layout_marginRight="24dp";
          layout_marginBottom="8dp";
          Typeface=字体("fonts/product");
          Text=nr;
          textColor=textc;
          textIsSelectable=true
        };
      };
      {
        LinearLayout;
        orientation="horizontal";
        layout_width="-1";
        layout_height="-2";
        gravity="right|center";
        {
          CardView;
          layout_width="-2";
          layout_height="-2";
          radius="2dp";
          background="#00000000";
          layout_marginTop="8dp";
          layout_marginLeft="8dp";
          layout_marginBottom="24dp";
          Elevation="0";
          onClick=qxnr;
          {
            TextView;
            layout_width="-1";
            layout_height="-2";
            textSize="16sp";
            Typeface=字体("fonts/product-Bold");
            paddingRight="16dp";
            paddingLeft="16dp";
            paddingTop="8dp";
            paddingBottom="8dp";
            Text=qx;
            textColor=stextc;
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
        {
          CardView;
          layout_width="-2";
          layout_height="-2";
          radius="4dp";
          backgroundColor=forceColor;
          layout_marginTop="8dp";
          layout_marginLeft="8dp";
          layout_marginRight="24dp";
          layout_marginBottom="24dp";
          Elevation="1dp";
          onClick=qdnr;
          {
            TextView;
            layout_width="-1";
            layout_height="-2";
            textSize="16sp";
            paddingRight="16dp";
            paddingLeft="16dp";
            Typeface=字体("fonts/product-Bold");
            paddingTop="8dp";
            paddingBottom="8dp";
            Text=qd;
            textColor=0xffffffff;
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
      };
    };
  };

  dl=AlertDialog.Builder(activity)
  dl.setView(loadlayout(dann))
  if gb==0 then
    dl.setCancelable(false)
  end
  an=dl.show()
  window = an.getWindow();
  window.setBackgroundDrawable(ColorDrawable(0x00ffffff));
  wlp = window.getAttributes();
  wlp.gravity = Gravity.BOTTOM;
  wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
  wlp.height = WindowManager.LayoutParams.WRAP_CONTENT;
  window.setAttributes(wlp);
end

function 单按钮对话框(bt,nr,qd,qdnr,gb)
  if 全局主题值=="日" then
    bwz=0x3f000000
   else
    bwz=0x3fffffff
  end

  local gd2 = GradientDrawable()
  gd2.setColor(转0x(backgroundc))--填充
  local radius=dp2px(16)
  gd2.setCornerRadii({radius,radius,radius,radius,0,0,0,0})--圆角
  gd2.setShape(0)--形状，0矩形，1圆形，2线，3环形
  local dann={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    {
      LinearLayout;
      orientation="vertical";
      layout_width="-1";
      layout_height="-2";
      Elevation="4dp";
      BackgroundDrawable=gd2;
      id="ztbj";
      {
        TextView;
        layout_width="-1";
        layout_height="-2";
        textSize="20sp";
        layout_marginTop="24dp";
        layout_marginLeft="24dp";
        layout_marginRight="24dp";
        Typeface=Typeface.createFromFile(File(activity.getLuaDir().."/res/fonts/product.ttf"));
        Text=bt;
        textColor=forceColor;
      };
      {
        RelativeLayout;
        layout_width="-1";
        layout_height="-1";
        {
          ScrollView;
          layout_width="-1";
          layout_height="-1";
          layout_marginBottom=dp2px(24+8+16+8)+sp2px(16);
          {
            TextView;
            layout_width="-1";
            layout_height="-2";
            textSize="14sp";
            layout_marginTop="8dp";
            layout_marginLeft="24dp";
            layout_marginRight="24dp";
            layout_marginBottom="8dp";
            Typeface=Typeface.createFromFile(File(activity.getLuaDir().."/res/fonts/product.ttf"));
            Text=nr;
            textColor=textc;
            textIsSelectable=true
          };
        };
        {
          LinearLayout;
          layout_width="-1";
          layout_height="-1";
          gravity="bottom|center";
          {
            LinearLayout;
            orientation="horizontal";
            layout_width="-1";
            layout_height="-2";
            gravity="right|center";
            background=barbackgroundc;
            {
              CardView;--24+8
              layout_width="-2";
              layout_height="-2";
              radius="4dp";
              backgroundColor=forceColor;
              layout_marginTop="8dp";
              layout_marginLeft="8dp";
              layout_marginRight="24dp";
              layout_marginBottom="24dp";
              Elevation="1dp";
              onClick=qdnr;
              {
                TextView;--16+8
                layout_width="-1";
                layout_height="-2";
                textSize="16sp";
                paddingRight="16dp";
                paddingLeft="16dp";
                Typeface=Typeface.createFromFile(File(activity.getLuaDir().."/res/fonts/product.ttf"));
                paddingTop="8dp";
                paddingBottom="8dp";
                Text=qd;
                textColor=0xffffffff;
                BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
              };
            };
          };
        };
      };
    };
  };

  dl=AlertDialog.Builder(activity)
  dl.setView(loadlayout(dann))
  if gb==0 then
    dl.setCancelable(false)
  end
  an=dl.show()
  window = an.getWindow();
  window.setBackgroundDrawable(ColorDrawable(0x00ffffff));
  wlp = window.getAttributes();
  wlp.gravity = Gravity.BOTTOM;
  wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
  wlp.height = WindowManager.LayoutParams.WRAP_CONTENT;
  window.setAttributes(wlp);
end

function 解压缩(压缩路径,解压缩路径)
  xpcall(function()
    ZipUtil.unzip(压缩路径,解压缩路径)
  end,function()
    提示("解压文件 "..压缩路径.." 失败")
  end)
end

function 压缩(原路径,压缩路径,名称)
  xpcall(function()
    LuaUtil.zip(原路径,压缩路径,名称)
  end,function()
    提示("压缩文件 "..原路径.." 至 "..压缩路径.."/"..名称.." 失败")
  end)
end

function 重命名文件(旧,新)
  xpcall(function()
    File(旧).renameTo(File(新))
  end,function()
    提示("重命名文件 "..旧.." 失败")
  end)
end

function 移动文件(旧,新)
  xpcall(function()
    File(旧).renameTo(File(新))
  end,function()
    提示("移动文件 "..旧.." 至 "..新.." 失败")
  end)
end

function 跳转页面(ym,cs)
  if cs then
    activity.newActivity(ym,cs)
   else
    activity.newActivity(ym)
  end
end

function 渐变跳转页面(ym,cs)
  if cs then
    activity.newActivity(ym,android.R.anim.fade_in,android.R.anim.fade_out,cs)
   else
    activity.newActivity(ym,android.R.anim.fade_in,android.R.anim.fade_out)
  end
end

function 检测键盘()
  imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE)
  isOpen=imm.isActive()
  return isOpen==true or false
end

function 隐藏键盘()
  activity.getSystemService(INPUT_METHOD_SERVICE).hideSoftInputFromWindow(WidgetSearchActivity.this.getCurrentFocus().getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS)
end

function 显示键盘(id)
  activity.getSystemService(INPUT_METHOD_SERVICE).showSoftInput(id, 0)
end

function 关闭页面()
  activity.finish()
end

function 复制文本(文本)
  activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(文本)
end

function QQ群(h)
  url="mqqapi://card/show_pslcard?src_type=internal&version=1&uin="..h.."&card_type=group&source=qrcode"
  activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
end

function QQ(h)
  url="mqqapi://card/show_pslcard?src_type=internal&source=sharecard&version=1&uin="..h
  activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
end

function 全屏()
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
end

function 退出全屏()
  activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
end

function 图标(n)
  return "res/twotone_"..n.."_black_24dp.png"
end

function changBmpSize(bitmap,degrees)
  width = bitmap.getWidth()
  height = bitmap.getHeight()
  --获取想要缩放的matrix
  matrix = Matrix()
  matrix.postScale(degrees,degrees)
  --获取新的bitmap
  bitmap=Bitmap.createBitmap(bitmap,0,0,width,height,matrix,true)
  return bitmap
end


function 高斯模糊(id,tp,radius1,radius2)

  import "android.net.Uri"

  if Build.VERSION.SDK_INT >= 23 then

    function blur( context, bitmap, blurRadius)
      renderScript = RenderScript.create(context);
      blurScript = ScriptIntrinsicBlur.create(renderScript, Element.U8_4(renderScript));
      inAllocation = Allocation.createFromBitmap(renderScript, bitmap);
      outputBitmap = bitmap;
      outAllocation = Allocation.createTyped(renderScript, inAllocation.getType());
      blurScript.setRadius(blurRadius);
      blurScript.setInput(inAllocation);
      blurScript.forEach(outAllocation);
      outAllocation.copyTo(outputBitmap);
      inAllocation.destroy();
      outAllocation.destroy();
      renderScript.destroy();
      blurScript.destroy();
      return outputBitmap;
    end
    bitmap=tp
    function blurAndZoom(context,bitmap,blurRadius,scale)
      return zoomBitmap(blur(context,zoomBitmap(bitmap, 1 / scale), blurRadius), scale);
    end

    function zoomBitmap(bitmap,scale)
      w = bitmap.getWidth();
      h = bitmap.getHeight();
      matrix = Matrix();
      matrix.postScale(scale, scale);
      bitmap = Bitmap.createBitmap(bitmap, 0, 0, w, h, matrix, true);
      return bitmap;
    end


    xpcall(function()加深后的图片=blurAndZoom(activity,bitmap,radius1,radius2)end,
    function()加深后的图片=bitmap end)

    if id then
      id.setImageBitmap(加深后的图片)
     else
      return 加深后的图片
    end
   else
    return tp


  end

end

function 获取应用信息(archiveFilePath)
  pm = activity.getPackageManager()
  info = pm.getPackageInfo(archiveFilePath, PackageManager.GET_ACTIVITIES);
  if info ~= nil then
    appInfo = info.applicationInfo;
    appName = tostring(pm.getApplicationLabel(appInfo))
    packageName = appInfo.packageName; --安装包名称
    version=info.versionName; --版本信息
    icon = pm.getApplicationIcon(appInfo);--图标
  end
  return packageName,version,icon
end

function 编辑框颜色(eid,color)

  eid.getBackground().setColorFilter(PorterDuffColorFilter(color,PorterDuff.Mode.SRC_ATOP))
end

function 下载文件(链接,文件名)
  downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
  url=Uri.parse(链接);
  request=DownloadManager.Request(url);
  request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
  request.setDestinationInExternalPublicDir(内置存储("Download",文件名));
  request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
  downloadManager.enqueue(request);
  提示("正在下载，下载到："..内置存储("Download/"..文件名).."\n请查看通知栏以查看下载进度。")
end

function 获取文件MIME(name)
  ExtensionName=tostring(name):match("%.(.+)")
  Mime=MimeTypeMap.getSingleton().getMimeTypeFromExtension(ExtensionName)
  return tostring(Mime)
end

function xdc(url,path)
  require "import"
  import "java.net.URL"
  local ur =URL(url)
  import "java.io.File"
  file=File(path);
  local con = ur.openConnection();
  local co = con.getContentLength();
  local is = con.getInputStream();
  local bs = byte[1024]
  local len,read=0,0
  import "java.io.FileOutputStream"
  local wj= FileOutputStream(path);
  len = is.read(bs)
  while len~=-1 do
    wj.write(bs, 0, len);
    read=read+len
    pcall(call,"ding",read,co)
    len = is.read(bs)
  end
  wj.close();
  is.close();
  pcall(call,"dstop",co)
end
function appDownload(url,path)
  thread(xdc,url,path)
end
function 下载文件对话框(title,url,path,ex)
  local path=内置存储("Download/"..path)
  appDownload(url,path)
  local gd2 = GradientDrawable()
  gd2.setColor(转0x(backgroundc))--填充
  local radius=dp2px(16)
  gd2.setCornerRadii({radius,radius,radius,radius,0,0,0,0})--圆角
  gd2.setShape(0)--形状，0矩形，1圆形，2线，3环形
  local 布局={
    LinearLayout,
    id="appdownbg",
    layout_width="fill",
    layout_height="fill",
    orientation="vertical",
    BackgroundDrawable=gd2;
    {
      TextView,
      id="appdownsong",
      text=title,
      --  typeface=Typeface.DEFAULT_BOLD,
      layout_marginTop="24dp",
      layout_marginLeft="24dp",
      layout_marginRight="24dp",
      layout_marginBottom="8dp",
      textColor=primaryc,
      textSize="20sp",
    },
    {
      TextView,
      id="appdowninfo",
      text="已下载：0MB/0MB\n下载状态：准备下载",
      --id="显示信息",
      --  typeface=Typeface.MONOSPACE,
      layout_marginRight="24dp",
      layout_marginLeft="24dp",
      layout_marginBottom="8dp",
      textSize="14sp",
      textColor=textc;
    },
    {
      ProgressBar,
      id="进度条",
      style="?android:attr/progressBarStyleHorizontal",
      layout_width="fill",
      progress=0,
      max=100;
      layout_marginRight="24dp",
      layout_marginLeft="24dp",
      layout_marginBottom="24dp",
    },
  }
  local dldown=AlertDialog.Builder(activity)
  dldown.setView(loadlayout(布局))
  进度条.IndeterminateDrawable.setColorFilter(PorterDuffColorFilter(转0x(primaryc),PorterDuff.Mode.SRC_ATOP))
  dldown.setCancelable(false)
  local ao=dldown.show()
  window = ao.getWindow();
  window.setBackgroundDrawable(ColorDrawable(0x00ffffff));
  wlp = window.getAttributes();
  wlp.gravity = Gravity.BOTTOM;
  wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
  wlp.height = WindowManager.LayoutParams.WRAP_CONTENT;
  window.setAttributes(wlp);

  function ding(a,b)--已下载，总长度(byte)
    appdowninfo.Text=string.format("%0.2f",a/1024/1024).."MB/"..string.format("%0.2f",b/1024/1024).."MB".."\n下载状态：正在下载"
    进度条.progress=(a/b*100)
  end

  function dstop(c)--总长度
    --[[if path:find(".bin") then
      lpath=path
      path=path:gsub(".bin",".apk")
      重命名文件(lpath,path)
    end]]
    关闭对话框(ao)

    if url:find("step")~=nil then
      提示("导入中…稍等哦(^^♪")
      解压缩(path,ex)
      删除文件(path)
      提示("导入完成ʕ•ٹ•ʔ")
     else
      提示("下载完成，大小"..string.format("%0.2f",c/1024/1024).."MB，储存在："..path)
      if path:find(".apk$")~=nil then
        双按钮对话框("安装APP",[===[您下载了安装包文件，要现在安装吗？]===],"立即安装","取消",function()关闭对话框(an)安装apk(path)end,function()关闭对话框(an)end)
      end
    end
  end

end

function 申请权限(权限)
  ActivityCompat.requestPermissions(this,权限,1)
end
--申请权限({Manifest.permission.WRITE_EXTERNAL_STORAGE})--不可用

function 判断悬浮窗权限()
  if (Build.VERSION.SDK_INT >= 23 and not Settings.canDrawOverlays(this)) then
    return false
   elseif Build.VERSION.SDK_INT < 23 then
    return ""
   else
    return true
  end
end

function 获取悬浮窗权限()
  intent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
  intent.setData(Uri.parse("package:" .. activity.getPackageName()));
  activity.startActivityForResult(intent, 100);
end

--[[if Settings.canDrawOverlays(this)==false then

  intent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
  intent.setData(Uri.parse("package:" .. activity.getPackageName()));
  this.startActivity(intent);

  双按钮对话框("烦人但是必不可少的权限(； ･`д･´)","MUKSK的正常运行需要以下权限：\n悬浮窗权限（显示步骤教程）\n存储权限（保存数据）","开启权限","退出",function()
    获取权限()
    权限=1
  end,function()
    关闭对话框(an)
    关闭页面()
  end,0)

end]]

function 安装apk(安装包路径)
  import "android.content.Intent"
  import "android.net.Uri"
  intent = Intent(Intent.ACTION_VIEW)
  intent.setDataAndType(Uri.parse("file:///"..安装包路径), "application/vnd.android.package-archive")
  intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
  activity.startActivity(intent)
end

function 浏览器打开(pageurl)
  import "android.content.Intent"
  import "android.net.Uri"
  viewIntent = Intent("android.intent.action.VIEW",Uri.parse(pageurl))
  activity.startActivity(viewIntent)
end

function 设置图片(preview,url)
  preview.setImageBitmap(loadbitmap(url))
end

function 字体(t)
  return Typeface.createFromFile(File(activity.getLuaDir().."/res/"..t..".ttf"))
end

function 开关颜色(id,color,color2)
  id.ThumbDrawable.setColorFilter(PorterDuffColorFilter(转0x(color),PorterDuff.Mode.SRC_ATOP))
  id.TrackDrawable.setColorFilter(PorterDuffColorFilter(转0x(color2),PorterDuff.Mode.SRC_ATOP))
end

function 检查更新()
  Http.get(官网("update"),nil,"utf8",nil,function(code,content,cookie,header)
    if 信息判断(code)==true then
      local content=content:match([[<code>(.-)</code>]])
      --local content=string.gsub(content,"<br>","\n")
      --local 公告t=content:gmatch"公告{(.-)}"
      local 最新版本=content:match([[最新版本：(.-)#.]])
      local 最新版本名=content:match([[最新版本名：(.-)#.]])
      local 更新时间=content:match([[更新时间：(.-)#.]])
      local 更新内容=content:match([[更新内容：(.-)#.]])
      local 下载地址=content:match([[下载地址：(.-)#.]])
      if tonumber(最新版本)>应用版本 then
        双按钮对话框("检测到新版本: "..最新版本名,"更新时间："..更新时间.."\n更新内容：\n"..更新内容,"立即更新","取消",function()
          关闭对话框(an)
          下载文件(下载地址,"update.apk")
        end,function()
          关闭对话框(an)
        end)
       else
        提示("已经是最新版本了哦…(^O^)v")
      end
     else
      if code==-1 then
        提示("没有网络，内容不能抵达QAQ…(-1)")
       else
        提示("航线出故障了，内容不能顺利抵达QAQ…("..code..")")
      end
    end
    return true
  end)
end
--[[
function 微信扫一扫()
  intent = activity.getPackageManager().getLaunchIntentForPackage("com.tencent.mm");
  intent.putExtra("LauncherUI.From.Scaner.Shortcut", true);
  activity.startActivity(intent);
end]]

function 微信扫一扫()
  import "android.content.Intent"
  import "android.content.ComponentName"
  intent = Intent();
  intent.setComponent( ComponentName("com.tencent.mm", "com.tencent.mm.ui.LauncherUI"));
  intent.putExtra("LauncherUI.From.Scaner.Shortcut", true);
  intent.setFlags(335544320);
  intent.setAction("android.intent.action.VIEW");
  activity.startActivity(intent);
end

function 支付宝扫一扫()
  import "android.net.Uri"
  import "android.content.Intent"
  uri = Uri.parse("alipayqr://platformapi/startapp?saId=10000007");
  intent = Intent(Intent.ACTION_VIEW, uri);
  activity.startActivity(intent);
end

function 支付宝捐赠()
  --https://qr.alipay.com/fkx06301lzsvnw6bnfkfqe5
  xpcall(function()
    local url = "alipayqr://platformapi/startapp?saId=10000007&clientVersion=3.7.0.0718&qrcode=https://qr.alipay.com/fkx06301lzsvnw6bnfkfqe5"
    activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)));
  end,
  function()
    local url = "https://qr.alipay.com/fkx06301lzsvnw6bnfkfqe5";
    activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)));
  end)
end

function 颜色字体(t,c)
  local sp = SpannableString(t)
  sp.setSpan(ForegroundColorSpan(转0x(c)),0,#sp,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
  return sp
end

function 翻译(str,sth)
  retstr=str
  import "com.kn.rhino.*"
  import "java.net.URLEncoder"

  res=Js.runFunction(activity,[[function token(a) {
    var k = "";
    var b = 406644;
    var b1 = 3293161072;

    var jd = ".";
    var sb = "+-a^+6";
    var Zb = "+-3^+b+-f";

    for (var e = [], f = 0, g = 0; g < a.length; g++) {
        var m = a.charCodeAt(g);
        128 > m ? e[f++] = m: (2048 > m ? e[f++] = m >> 6 | 192 : (55296 == (m & 64512) && g + 1 < a.length && 56320 == (a.charCodeAt(g + 1) & 64512) ? (m = 65536 + ((m & 1023) << 10) + (a.charCodeAt(++g) & 1023), e[f++] = m >> 18 | 240, e[f++] = m >> 12 & 63 | 128) : e[f++] = m >> 12 | 224, e[f++] = m >> 6 & 63 | 128), e[f++] = m & 63 | 128)
    }
    a = b;
    for (f = 0; f < e.length; f++) a += e[f],
    a = RL(a, sb);
    a = RL(a, Zb);
    a ^= b1 || 0;
    0 > a && (a = (a & 2147483647) + 2147483648);
    a %= 1E6;
    return a.toString() + jd + (a ^ b)
};

function RL(a, b) {
    var t = "a";
    var Yb = "+";
    for (var c = 0; c < b.length - 2; c += 3) {
        var d = b.charAt(c + 2),
        d = d >= t ? d.charCodeAt(0) - 87 : Number(d),
        d = b.charAt(c + 1) == Yb ? a >>> d: a << d;
        a = b.charAt(c) == Yb ? a + d & 4294967295 : a ^ d ;
    }
    return a
};]],"token",{str})
  url="https://translate.google.cn/translate_a/single?"
  datastr=""
  data={"client=webapp",
    "sl=auto",
    "tl=zh-CN",
    "hl=zh-CN",
    "dt=at",
    "dt=bd",
    "dt=ex",
    "dt=ld",
    "dt=md",
    "dt=qca",
    "dt=rw",
    "dt=rm",
    "dt=ss",
    "dt=t",
    "ie=UTF-8",
    "oe=UTF-8",
    "source=btn",
    "ssel=0",
    "tsel=0",
    "kc=0",
    "tk="..res,
    "q="..URLEncoder.encode(str)}
  datastr=table.concat(data,"&")
  Http.get(url..datastr,{["User-Agent"]="Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_0 like Mac OS X; en-us) AppleWebKit/532.9 (KHTML, like Gecko) Version/4.0.5 Mobile/8A293 Safari/6531.22.7"},function(code,content)
    rettior=content
    sth()
  end)
end

function MD5(str)

  local HexTable = {"0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"}
  local A = 0x67452301
  local B = 0xefcdab89
  local C = 0x98badcfe
  local D = 0x10325476

  local S11 = 7
  local S12 = 12
  local S13 = 17
  local S14 = 22
  local S21 = 5
  local S22 = 9
  local S23 = 14
  local S24 = 20
  local S31 = 4
  local S32 = 11
  local S33 = 16
  local S34 = 23
  local S41 = 6
  local S42 = 10
  local S43 = 15
  local S44 = 21

  local function F(x,y,z)
    return (x & y) | ((~x) & z)
  end
  local function G(x,y,z)
    return (x & z) | (y & (~z))
  end
  local function H(x,y,z)
    return x ~ y ~ z
  end
  local function I(x,y,z)
    return y ~ (x | (~z))
  end
  local function FF(a,b,c,d,x,s,ac)
    a = a + F(b,c,d) + x + ac
    a = (((a & 0xffffffff) << s) | ((a & 0xffffffff) >> 32 - s)) + b
    return a & 0xffffffff
  end
  local function GG(a,b,c,d,x,s,ac)
    a = a + G(b,c,d) + x + ac
    a = (((a & 0xffffffff) << s) | ((a & 0xffffffff) >> 32 - s)) + b
    return a & 0xffffffff
  end
  local function HH(a,b,c,d,x,s,ac)
    a = a + H(b,c,d) + x + ac
    a = (((a & 0xffffffff) << s) | ((a & 0xffffffff) >> 32 - s)) + b
    return a & 0xffffffff
  end
  local function II(a,b,c,d,x,s,ac)
    a = a + I(b,c,d) + x + ac
    a = (((a & 0xffffffff) << s) | ((a & 0xffffffff) >> 32 - s)) + b
    return a & 0xffffffff
  end



  local function MD5StringFill(s)
    local len = s:len()
    local mod512 = len * 8 % 512
    --需要填充的字节数
    local fillSize = (448 - mod512) // 8
    if mod512 > 448 then
      fillSize = (960 - mod512) // 8
    end

    local rTab = {}

    --记录当前byte在4个字节的偏移
    local byteIndex = 1
    for i = 1,len do
      local index = (i - 1) // 4 + 1
      rTab[index] = rTab[index] or 0
      rTab[index] = rTab[index] | (s:byte(i) << (byteIndex - 1) * 8)
      byteIndex = byteIndex + 1
      if byteIndex == 5 then
        byteIndex = 1
      end
    end
    --先将最后一个字节组成4字节一组
    --表示0x80是否已插入
    local b0x80 = false
    local tLen = #rTab
    if byteIndex ~= 1 then
      rTab[tLen] = rTab[tLen] | 0x80 << (byteIndex - 1) * 8
      b0x80 = true
    end

    --将余下的字节补齐
    for i = 1,fillSize // 4 do
      if not b0x80 and i == 1 then
        rTab[tLen + i] = 0x80
       else
        rTab[tLen + i] = 0x0
      end
    end

    --后面加原始数据bit长度
    local bitLen = math.floor(len * 8)
    tLen = #rTab
    rTab[tLen + 1] = bitLen & 0xffffffff
    rTab[tLen + 2] = bitLen >> 32

    return rTab
  end

  --	Func:	计算MD5
  --	Param:	string
  --	Return:	string
  ---------------------------------------------

  function string.md5(s)
    --填充
    local fillTab = MD5StringFill(s)
    local result = {A,B,C,D}

    for i = 1,#fillTab // 16 do
      local a = result[1]
      local b = result[2]
      local c = result[3]
      local d = result[4]
      local offset = (i - 1) * 16 + 1
      --第一轮
      a = FF(a, b, c, d, fillTab[offset + 0], S11, 0xd76aa478)
      d = FF(d, a, b, c, fillTab[offset + 1], S12, 0xe8c7b756)
      c = FF(c, d, a, b, fillTab[offset + 2], S13, 0x242070db)
      b = FF(b, c, d, a, fillTab[offset + 3], S14, 0xc1bdceee)
      a = FF(a, b, c, d, fillTab[offset + 4], S11, 0xf57c0faf)
      d = FF(d, a, b, c, fillTab[offset + 5], S12, 0x4787c62a)
      c = FF(c, d, a, b, fillTab[offset + 6], S13, 0xa8304613)
      b = FF(b, c, d, a, fillTab[offset + 7], S14, 0xfd469501)
      a = FF(a, b, c, d, fillTab[offset + 8], S11, 0x698098d8)
      d = FF(d, a, b, c, fillTab[offset + 9], S12, 0x8b44f7af)
      c = FF(c, d, a, b, fillTab[offset + 10], S13, 0xffff5bb1)
      b = FF(b, c, d, a, fillTab[offset + 11], S14, 0x895cd7be)
      a = FF(a, b, c, d, fillTab[offset + 12], S11, 0x6b901122)
      d = FF(d, a, b, c, fillTab[offset + 13], S12, 0xfd987193)
      c = FF(c, d, a, b, fillTab[offset + 14], S13, 0xa679438e)
      b = FF(b, c, d, a, fillTab[offset + 15], S14, 0x49b40821)

      --第二轮
      a = GG(a, b, c, d, fillTab[offset + 1], S21, 0xf61e2562)
      d = GG(d, a, b, c, fillTab[offset + 6], S22, 0xc040b340)
      c = GG(c, d, a, b, fillTab[offset + 11], S23, 0x265e5a51)
      b = GG(b, c, d, a, fillTab[offset + 0], S24, 0xe9b6c7aa)
      a = GG(a, b, c, d, fillTab[offset + 5], S21, 0xd62f105d)
      d = GG(d, a, b, c, fillTab[offset + 10], S22, 0x2441453)
      c = GG(c, d, a, b, fillTab[offset + 15], S23, 0xd8a1e681)
      b = GG(b, c, d, a, fillTab[offset + 4], S24, 0xe7d3fbc8)
      a = GG(a, b, c, d, fillTab[offset + 9], S21, 0x21e1cde6)
      d = GG(d, a, b, c, fillTab[offset + 14], S22, 0xc33707d6)
      c = GG(c, d, a, b, fillTab[offset + 3], S23, 0xf4d50d87)
      b = GG(b, c, d, a, fillTab[offset + 8], S24, 0x455a14ed)
      a = GG(a, b, c, d, fillTab[offset + 13], S21, 0xa9e3e905)
      d = GG(d, a, b, c, fillTab[offset + 2], S22, 0xfcefa3f8)
      c = GG(c, d, a, b, fillTab[offset + 7], S23, 0x676f02d9)
      b = GG(b, c, d, a, fillTab[offset + 12], S24, 0x8d2a4c8a)

      --第三轮
      a = HH(a, b, c, d, fillTab[offset + 5], S31, 0xfffa3942)
      d = HH(d, a, b, c, fillTab[offset + 8], S32, 0x8771f681)
      c = HH(c, d, a, b, fillTab[offset + 11], S33, 0x6d9d6122)
      b = HH(b, c, d, a, fillTab[offset + 14], S34, 0xfde5380c)
      a = HH(a, b, c, d, fillTab[offset + 1], S31, 0xa4beea44)
      d = HH(d, a, b, c, fillTab[offset + 4], S32, 0x4bdecfa9)
      c = HH(c, d, a, b, fillTab[offset + 7], S33, 0xf6bb4b60)
      b = HH(b, c, d, a, fillTab[offset + 10], S34, 0xbebfbc70)
      a = HH(a, b, c, d, fillTab[offset + 13], S31, 0x289b7ec6)
      d = HH(d, a, b, c, fillTab[offset + 0], S32, 0xeaa127fa)
      c = HH(c, d, a, b, fillTab[offset + 3], S33, 0xd4ef3085)
      b = HH(b, c, d, a, fillTab[offset + 6], S34, 0x4881d05)
      a = HH(a, b, c, d, fillTab[offset + 9], S31, 0xd9d4d039)
      d = HH(d, a, b, c, fillTab[offset + 12], S32, 0xe6db99e5)
      c = HH(c, d, a, b, fillTab[offset + 15], S33, 0x1fa27cf8)
      b = HH(b, c, d, a, fillTab[offset + 2], S34, 0xc4ac5665)

      --第四轮
      a = II(a, b, c, d, fillTab[offset + 0], S41, 0xf4292244)
      d = II(d, a, b, c, fillTab[offset + 7], S42, 0x432aff97)
      c = II(c, d, a, b, fillTab[offset + 14], S43, 0xab9423a7)
      b = II(b, c, d, a, fillTab[offset + 5], S44, 0xfc93a039)
      a = II(a, b, c, d, fillTab[offset + 12], S41, 0x655b59c3)
      d = II(d, a, b, c, fillTab[offset + 3], S42, 0x8f0ccc92)
      c = II(c, d, a, b, fillTab[offset + 10], S43, 0xffeff47d)
      b = II(b, c, d, a, fillTab[offset + 1], S44, 0x85845dd1)
      a = II(a, b, c, d, fillTab[offset + 8], S41, 0x6fa87e4f)
      d = II(d, a, b, c, fillTab[offset + 15], S42, 0xfe2ce6e0)
      c = II(c, d, a, b, fillTab[offset + 6], S43, 0xa3014314)
      b = II(b, c, d, a, fillTab[offset + 13], S44, 0x4e0811a1)
      a = II(a, b, c, d, fillTab[offset + 4], S41, 0xf7537e82)
      d = II(d, a, b, c, fillTab[offset + 11], S42, 0xbd3af235)
      c = II(c, d, a, b, fillTab[offset + 2], S43, 0x2ad7d2bb)
      b = II(b, c, d, a, fillTab[offset + 9], S44, 0xeb86d391)

      --加入到之前计算的结果当中
      result[1] = result[1] + a
      result[2] = result[2] + b
      result[3] = result[3] + c
      result[4] = result[4] + d
      result[1] = result[1] & 0xffffffff
      result[2] = result[2] & 0xffffffff
      result[3] = result[3] & 0xffffffff
      result[4] = result[4] & 0xffffffff
    end

    --将Hash值转换成十六进制的字符串
    local retStr = ""
    for i = 1,4 do
      for _ = 1,4 do
        local temp = result[i] & 0x0F
        local str = HexTable[temp + 1]
        result[i] = result[i] >> 4
        temp = result[i] & 0x0F
        retStr = retStr .. HexTable[temp + 1] .. str
        result[i] = result[i] >> 4
      end
    end

    return retStr
  end

  return string.md5(str)

end



function 输入对话框(bt,nr,text,qd,qx,qdnr,qxnr,gb,type)
  if mode=="Dark" then

    bwz=0x3fffffff
   elseif mode=="Auto" then

   else
    bwz=0x3f000000
  end

  local gd2 = GradientDrawable()
  gd2.setColor(转0x(backgroundc))--填充
  local radius=dp2px(16)
  gd2.setCornerRadii({radius,radius,radius,radius,0,0,0,0})--圆角
  gd2.setShape(0)--形状，0矩形，1圆形，2线，3环形

  if dialog==nil then
    dialog='0xff444400'
  end
  local dann={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    {
      LinearLayout;
      orientation="vertical";
      layout_width="-1";
      layout_height="-2";
      Elevation="4dp";
      BackgroundDrawable=gd2;
      --background=dialog,
      id="ztbj";
      {
        TextView;
        layout_width="-1";
        layout_height="-2";
        textSize="20sp";
        layout_marginTop="24dp";
        layout_marginLeft="24dp";
        layout_marginRight="24dp";
        Text=bt;
        Typeface=字体("fonts/product-Bold");
        textColor=forceColor;
      };
      {
        CardView,
        layout_height="42dp",
        layout_width="fill",
        layout_marginTop="8dp";
        layout_marginLeft="24dp";
        layout_marginRight="24dp";
        layout_marginBottom="8dp";
        radius="4dp";
        CardBackgroundColor=BGC,
        Elevation="0";
        -- layout_marginBottom=dp2px(24+8+16+8)+sp2px(16);
        {
          EditText,
          id='edit',
          hint=nr,
          textColor=textColor,
          textSize="14dp",
          InputType=type,
          backgroundColor=0,
          Typeface=字体("fonts/product");
          layout_height="42dp",
          layout_width="fill",
          Text=text,
        },
      },
      {
        LinearLayout;
        orientation="horizontal";
        layout_width="-1";
        layout_height="-2";
        gravity="right|center";
        {
          CardView;
          layout_width="-2";
          layout_height="-2";
          radius="2dp";
          background="#00000000";
          layout_marginTop="8dp";
          layout_marginLeft="8dp";
          layout_marginBottom="24dp";
          Elevation="0";
          onClick=qxnr;
          {
            TextView;
            layout_width="-1";
            layout_height="-2";
            textSize="16sp";
            Typeface=字体("fonts/product-Bold");
            paddingRight="16dp";
            paddingLeft="16dp";
            paddingTop="8dp";
            paddingBottom="8dp";
            Text=qx;
            textColor=stextc;
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
        {
          CardView;
          layout_width="-2";
          layout_height="-2";
          radius="4dp";
          backgroundColor=forceColor;
          layout_marginTop="8dp";
          layout_marginLeft="8dp";
          layout_marginRight="24dp";
          layout_marginBottom="24dp";
          Elevation="1dp";
          onClick=qdnr;
          {
            TextView;
            layout_width="-1";
            layout_height="-2";
            textSize="16sp";
            paddingRight="16dp";
            paddingLeft="16dp";
            Typeface=字体("fonts/product-Bold");
            paddingTop="8dp";
            paddingBottom="8dp";
            Text=qd;
            textColor=0xffffffff;
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
      };
    };
  };

  dl=AlertDialog.Builder(activity)
  dl.setView(loadlayout(dann))
  if gb==0 then
    dl.setCancelable(false)
  end
  an=dl.show()
  window = an.getWindow();
  window.setBackgroundDrawable(ColorDrawable(0x00ffffff));
  wlp = window.getAttributes();
  wlp.gravity = Gravity.BOTTOM;
  wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
  wlp.height = WindowManager.LayoutParams.WRAP_CONTENT;
  window.setAttributes(wlp);
end

function 新建对话框(bt,nr,text,qd,qx,qdnr,qxnr,gb,type)
  if mode=="Dark" then

    bwz=0x3fffffff
   elseif mode=="Auto" then

   else
    bwz=0x3f000000
  end

  local gd2 = GradientDrawable()
  gd2.setColor(转0x(backgroundc))--填充
  local radius=dp2px(16)
  gd2.setCornerRadii({radius,radius,radius,radius,radius,radius,radius,radius})--圆角
  gd2.setShape(0)--形状，0矩形，1圆形，2线，3环形

  if dialog==nil then
    dialog='0xff444400'
  end
  local dann={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    paddingBottom="28dp",
    padding="18dp",
    {
      LinearLayout;
      orientation="vertical";
      layout_width="-1";
      layout_height="-2";
      Elevation="1dp";
      BackgroundDrawable=gd2;
      --background=dialog,
      id="ztbj";
      {
        TextView;
        layout_width="-1";
        layout_height="-2";
        textSize="20sp";
        layout_marginTop="24dp";
        layout_marginLeft="24dp";
        layout_marginRight="24dp";
        Text=bt;
        Typeface=字体("fonts/product-Bold");
        textColor=forceColor;
      };
      {
        ListView,
        layout_width="fill",
        layout_marginTop="8dp";
        layout_marginLeft="24dp";
        layout_marginRight="24dp";
        layout_marginBottom="8dp";
        id="inslist",
        -- layout_marginBottom=dp2px(24+8+16+8)+sp2px(16);
      },
      {
        LinearLayout;
        orientation="horizontal";
        layout_width="-1";
        layout_height="-2";
        gravity="right|center";

        {
          CardView;
          layout_width="-2";
          layout_height="-2";
          radius="4dp";
          backgroundColor=forceColor;
          layout_marginTop="8dp";
          layout_marginLeft="8dp";
          layout_marginRight="24dp";
          layout_marginBottom="24dp";
          Elevation="1dp";
          onClick=qdnr;
          {
            TextView;
            layout_width="-1";
            layout_height="-2";
            textSize="16sp";
            paddingRight="16dp";
            paddingLeft="16dp";
            Typeface=字体("fonts/product-Bold");
            paddingTop="8dp";
            paddingBottom="8dp";
            Text=qx;
            textColor=forceTextColor;
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
      };
    };
  };

  dl=AlertDialog.Builder(activity)
  dl.setView(loadlayout(dann))
  if gb==0 then
    dl.setCancelable(false)
  end
  an=dl.show()
  window = an.getWindow();
  window.setBackgroundDrawable(ColorDrawable(0x00ffffff));
  wlp = window.getAttributes();
  wlp.gravity = Gravity.BOTTOM;
  wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
  wlp.height = WindowManager.LayoutParams.WRAP_CONTENT;
  window.setAttributes(wlp);

  itemins={
    TextView,
    id="instext",
    layout_height="42dp",
    layout_width="fill",
    Gravity="center|left",
    TextColor=textColor,
  }
  adp=LuaAdapter(activity,itemins)
  inslist.setAdapter(adp)
  import "tables.add"
  for i =1,#addtable do
    adp.add{instext=addtable[i]}
  end
  inslist.onItemClick=function(a,b,c,one)
    if gb then
      gb(one)
    end
  end
end