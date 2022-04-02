xpcall(function()R=luajava.bindClass(activity.getPackageName()..".R")end,
function()R={style={}}end)

AppTheme={}
function AppTheme.getid()
  local theme=activity.getSharedData("theme")
  if theme then
    return theme
   else
    activity.setSharedData("theme",1)
    return 1
  end

end
function AppTheme.setBySystem(id)
  activity.setSharedData("theme",tonumber(id))
end
function AppTheme.setByUser(id)
  activity.setSharedData("theme",tonumber(id))
  activity.setSharedData("LastUserTheme",tonumber(id))
end

tablechild=require "app.ThemeTable"[AppTheme.getid()]


function AppTheme.isDarkTheme()
  if tablechild.type=="Night" then
    return true
   else
    return false
  end
end

local function getNormalRipple()
  if AppTheme.isDarkTheme() then
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
subTextColor=textColor-0x77000000
导航栏颜色=tablechild.导航栏颜色
themea=tablechild.themea
淡色强调波纹=graph.修改颜色强度(0x2A,icon)
普通波纹=getNormalRipple()


function isNightMode(context)
  xpcall(function()result = context.getResources().getConfiguration().uiMode==33 end,
  function()result = false end)
  return result
end

function initToolbar(string)
  if activity.getSupportActionBar() then
    activity.getSupportActionBar().show()
    import "android.graphics.drawable.ColorDrawable"
    activity.getSupportActionBar().setBackgroundDrawable(ColorDrawable(mainColor))
    import "android.text.SpannableString"
    import "android.text.style.ForegroundColorSpan"
    import "android.text.Spannable"
    sp=SpannableString(string)
    sp.setSpan(ForegroundColorSpan(titleColor),0,#sp,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
    activity.getSupportActionBar().setTitle(sp)
  end
end

if not 导航栏颜色 then
  导航栏颜色=mainColor
end

function isDarkColor(color)
  import "android.graphics.Color"

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




function 沉浸状态栏()
  sdk=Build.VERSION.SDK_INT
  if sdk >= 23 then
    pcall(function()
      window=activity.getWindow()
      DecorView=window.getDecorView()
      pack_name=this.getPackageName()
      DecorView.setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN|View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR)
      --  window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
      window.setStatusBarColor(Color.TRANSPARENT)


    end)
   elseif sdk>= 21 then
    pcall(function()
      activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
    end)
  end
end


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
end

--task(1,function()
setNavigationBar()
--end)
