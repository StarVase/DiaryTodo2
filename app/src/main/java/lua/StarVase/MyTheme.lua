xpcall(function()R=luajava.bindClass(activity.getPackageName()..".R")end,
function()R={style={}}end)

AppTheme={}
function AppTheme.getid()
  if not tonumber(activity.getSharedData("theme")) then
    activity.setSharedData("theme",1)
    return activity.getSharedData("theme")
   else return activity.getSharedData("theme")
  end

end

function AppTheme.set(id)
  activity.setSharedData("theme",tonumber(id))
end

AppTheme.table={
  {
    name="默认白",
    forceColor=0xff448aff, --蓝色
    forceTextColor=0xfffffffff,
    mainColor=0xffffffff, --蓝色
    icon=0xff2196f3,
    titleColor=0xff448aff, --白色
    textColor=0xff000000, --黑色
    lightForceColor=0xffe3f2fd, --浅白色
    BGC=0Xffffffff, --白色
    itemBGC=0xfffdfdfd, --浅白色
    rippleColor=0xffe3f2fd, --浅白色
    themea=R.style.White,
    导航栏颜色=0xff000000,
    type="Day",
    --1
  },
  {
    name="天空蓝",
    forceColor=0xff448aff, --蓝色
    forceTextColor=0xfffffffff,
    mainColor=0xff2196f3, --蓝色
    icon=0xff2196f3,
    titleColor=0xffffffff, --白色
    textColor=0xff000000, --黑色
    lightForceColor=0xffe3f2fd, --浅白色
    BGC=0Xffffffff, --白色
    itemBGC=0xfffdfdfd, --浅白色
    rippleColor=0xFFDADADA, --浅白色
    themea=R.style.Blue,
    type="Day",
    --2
  },
  {
    name="新年红",
    forceColor=0xFFC60B26, --蓝色
    forceTextColor=0xFFECC03F,
    mainColor=0xFFC60B26, --蓝色
    icon=0xFFECC03F,
    titleColor=0xffffffff, --白色
    textColor=0xffffffff, --黑色
    lightForceColor=0xFFC60B26, --浅白色
    BGC=0xFFC60B26, --白色
    itemBGC=0xFFC60B26, --浅白色
    rippleColor=0xFFC60B26, --浅白色
    themea=R.style.NewYearRed,
    type="Night",
    --3
  },
  {
    name="荣耀绿",
    forceColor=0xff00acc2, --蓝色
    forceTextColor=0xfffffffff,
    mainColor=0xff00acc2, --蓝色
    icon=0xff00acc2,
    titleColor=0xffffffff, --白色
    textColor=0xff000000, --黑色
    lightForceColor=0xffe3f2fd, --浅白色
    BGC=0Xffffffff, --白色
    itemBGC=0xfffdfdfd, --浅白色
    rippleColor=0xFFDADADA, --浅白色
    themea=R.style.HonorGreen,
    type="Day",
    --4
  },
  {
    name="夜空黑",
    forceColor=0xff448aff, --蓝色
    forceTextColor=0xfffffffff,
    mainColor=0xff0000000, --蓝色
    icon=0xff2196f3,
    titleColor=0xffffffff, --白色
    textColor=0xff000000, --黑色
    lightForceColor=0xffe3f2fd, --浅白色
    BGC=0Xffffffff, --白色
    itemBGC=0xfffdfdfd, --浅白色
    rippleColor=0xFFDADADA, --浅白色
    themea=R.style.White,
    type="Day",
    --5
  },
  {
    name="纯黑",
    forceColor=0xff448aff, --蓝色
    forceTextColor=0xfffffffff,
    mainColor=0xff000000, --蓝色
    icon=0xff2196f3,
    titleColor=0xffffffff, --白色
    textColor=0xffffffff, --黑色
    lightForceColor=0xffe3f2fd, --浅白色
    BGC=0Xff000000, --白色
    itemBGC=0xff0b0b0b, --浅白色
    rippleColor=0x00000000, --浅白色
    themea=R.style.mNight2,
    type="Night",
    --6
  },
}


--[[

]]











tablechild=AppTheme.table[AppTheme.getid()]
local function getNormalRipple()
  if tablechild.type=="Night" then
    return 0x44FFFFFF
   else
    return 0x44000000
  end
end
forceColor=tablechild.forceColor
mainColor=tablechild.mainColor
titleColor=tablechild.titleColor
textColor=tablechild.textColor
lightForceColor=tablechild.lightForceColor
BGC=tablechild.BGC
itemBGC=tablechild.itemBGC
rippleColor=tablechild.rippleColor
icon=tablechild.icon
forceTextColor=tablechild.forceTextColor
导航栏颜色=tablechild.导航栏颜色
themea=tablechild.themea
淡色强调波纹=graph.修改颜色强度(44,icon)
普通波纹=getNormalRipple()
主题(tablechild.type)

function isNightMode(context)
  xpcall(function()result = context.getResources().getConfiguration().uiMode==33 end,
  function()result = false end)
  return result
end

function initToolbar(string)
  activity.ActionBar.show()
  import "android.graphics.drawable.ColorDrawable"
  activity.ActionBar.setBackgroundDrawable(ColorDrawable(mainColor))
  import "android.text.SpannableString"
  import "android.text.style.ForegroundColorSpan"
  import "android.text.Spannable"
  sp=SpannableString(string)
  sp.setSpan(ForegroundColorSpan(titleColor),0,#sp,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
  activity.ActionBar.setTitle(sp)
end

if not 导航栏颜色 then
  导航栏颜色=mainColor
end
--activity.setTheme(themea)
function isDarkColor(color)
  import "android.graphics.Color"
  --local color=Integer.toHexString(color)
  return (0.299 * Color.red(color) + 0.587 * Color.green(color) + 0.114 * Color.blue(color)) <192
end

function setSystemUi(isBlack)
  if isBlack then
    return "|View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR"
   else
    return ""
  end
end
function 判断沉浸()
  if isDarkColor(mainColor) then
    return setSystemUi()
   else
    return setSystemUi(true)
  end
end


function setNavigationBar1()
  主题={}
  主题.导航栏沉浸={}
  function 主题.导航栏沉浸.开启()
    systemUIInfo="View.VISIBLE"
    主题.导航栏沉浸.状态=true
    if activity.getSharedData("导航栏使用暗色") == "true" then
      activity.getWindow().setNavigationBarColor(导航栏颜色)
      systemUIInfo="View.VISIBLE"
     else
      activity.getWindow().setNavigationBarColor(BGC)
      if (tonumber(Build.VERSION.SDK) >= 26) then
        systemUIInfo=systemUIInfo.."|View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR"--暗色导航栏
       else systemUIInfo="View.VISIBLE"
      end
    end
    pcall(function()
      loadstring([[
      activity
      .getWindow()
      .getDecorView()
      .setSystemUiVisibility(]]..systemUIInfo..[[|View
      .SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION]]..判断沉浸()..[[)]])()
    end)
  end

  主题.导航栏沉浸.开启()
end

function 沉浸状态栏()
  sdk=Build.VERSION.SDK_INT
  if sdk >= 23 then
    pcall(function()
      window=activity.getWindow()
      DecorView=window.getDecorView()
      pack_name=this.getPackageName()
      DecorView.setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN|View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR)
      window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
      window.setStatusBarColor(Color.TRANSPARENT)


    end)
   elseif sdk>= 21 then
    pcall(function()
      activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
    end)
  end
end
window=activity.getWindow()
window.setStatusBarColor(mainColor)


function setNavigationBar()
  systemUIInfo="View.VISIBLE"
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(mainColor);
  if tonumber(Build.VERSION.SDK) >= 23 then
    if not(isDarkColor(mainColor)) then
      systemUIInfo=systemUIInfo.."|View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR"--暗色状态栏
    end

    activity.getWindow().setNavigationBarColor(BGC)

    if (tonumber(Build.VERSION.SDK) >= 26) and not(isDarkColor(BGC)) then
      systemUIInfo=systemUIInfo.."|View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR"--暗色导航栏
    end
  end

  loadstring([[activity.getWindow().getDecorView().setSystemUiVisibility(]]..systemUIInfo..[[)]])()--设置SystemUI


  pcall(function()activity.getWindow().setNavigationBarDividerColor(0xff000000)end)

end
--沉浸状态栏()
setNavigationBar()

