System=luajava.bindClass("java.lang.System")
t1=System.currentTimeMillis()
R=luajava.bindClass(activity.getPackageName()..".R")
require "import"
import "android.app.*"
import "android.os.*"
import "android.view.*"
import "android.database.sqlite.*"
import "android.util.Log"
import "android.graphics.Bitmap"
import "android.graphics.Color"
import "android.graphics.Typeface"
import "android.graphics.drawable.GradientDrawable"
import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.text.Spannable"
import "androidx.coordinatorlayout.widget.CoordinatorLayout"
import "androidx.swiperefreshlayout.widget.SwipeRefreshLayout"
import "androidx.cardview.widget.CardView"
import "androidx.recyclerview.widget.RecyclerView"
import "androidx.recyclerview.widget.StaggeredGridLayoutManager"
import "android.animation.LayoutTransition"
import "android.net.Uri"
import "android.content.Intent"
import "android.content.Context"
import "android.content.res.Configuration"
import "android.content.res.ColorStateList"
import "android.content.pm.PackageManager"
import "com.google.android.material.tabs.TabLayout"
import "com.google.android.material.card.MaterialCardView"
import "com.google.android.material.button.MaterialButton"
import "com.google.android.material.snackbar.Snackbar"
import "com.google.android.material.textfield.TextInputEditText"
import "com.google.android.material.textfield.TextInputLayout"
import "java.io.File"
import "java.io.FileInputStream"
import "java.io.FileOutputStream"
import "com.StarVase.library.view.*"
import "com.StarVase.library.util.*"
import "com.StarVase.diaryTodo.app.*"
import "com.StarVase.diaryTodo.bean.*"
import "com.StarVase.diaryTodo.helper.*"
import "com.StarVase.diaryTodo.util.*"
import "com.StarVase.diaryTodo.view.*"
--优先导入类，然后导入库
import "com.StarVase.utils.TimingUtil"
import "com.StarVase.app.androidx"
import "com.StarVase.app.MyActivity"
import "com.StarVase.diaryTodo.CreateFileUtil"
import "com.StarVase.app"
import "com.StarVase.app.path"
activity.setLuaExtDir(path.app)



function loadlualibs()
  import "com.StarVase.view.MyDialog"
  import "com.StarVase.view.RadioCheckBox"
  import "com.StarVase.view.MaterialButton.TextButton"
  import "com.StarVase.view.MyToast"
  import "com.StarVase.view.NoScrollPageView"
  import "com.StarVase.utils.ai"
  import "com.StarVase.utils.string"
  import "com.StarVase.utils.math"
  import "com.StarVase.utils.animation"
  import "com.StarVase.utils.file"
  import "com.StarVase.utils.MyBitmap"
  import "com.StarVase.utils.MyTextStyle"
  import "com.StarVase.utils.language"
  import "com.StarVase.utils.MyToolbarStyle"
  import "com.StarVase.utils.loadGlideBitmap"
  import "com.StarVase.utils.notice"
  import "com.StarVase.utils.widget"
  import "com.StarVase.utils.NetErrorStr"
  import "com.StarVase.utils.ScreenFixUtil"
  import "com.StarVase.app.backup"
  import "com.StarVase.yiyan"
  import "com.StarVase.utils.MyChineseCalendar"
  --import "com.StarVase.utils.MyNewYear"
end

function loadTheme()
  import "com.StarVase.utils.graph"
  import "com.StarVase.app.MyTheme"
  activity.setTheme(themea or 0)
  import "com.StarVase.diaryTodo.Copyright"
  
  if isNightMode(this) then
    AppTheme.setBySystem(6)
   else
    AppTheme.setByUser(activity.getSharedData("LastUserTheme"))
  end

  import "com.StarVase.utils.MyAnimationUtil"
  upArrow = this.getDrawable(R.drawable.abc_ic_ab_back_material);
  if(upArrow != nil) then
    upArrow.setColorFilter(titleColor, PorterDuff.Mode.SRC_ATOP);
    if(activity.getSupportActionBar() != nil) then
      activity.getSupportActionBar().setHomeAsUpIndicator(upArrow);
    end
  end
end

function getStatuebarHeight()
  local resid=activity.getResources().getIdentifier("status_bar_height","dimen","android")
  local height
  if resid>0 then
    height = activity.getResources().getDimensionPixelSize(resid)
   else
    height = w*0.07
  end
  return height
end

function sub(name,...)
  activity.newActivity('sub/'..name..'/main',{...})
end

function subed(name,...)
  activity.newActivity(activity.getSharedData("BaseLuaPath").."/sub/"..name.."/main.lua",{...})
end

function importFile(this,file)
  return import("sub/"..this.."/"..file)
end

function AutoSetToolTip(view,text)
  if tonumber(Build.VERSION.SDK) >= 26 then
    view.setTooltipText(text)
  end
end

function getNavigationBarHeight()
  resources = activity.getResources();
  resourceId = resources.getIdentifier("navigation_bar_height","dimen", "android");
  height = resources.getDimensionPixelSize(resourceId);
  return height;
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

--print(System.currentTimeMillis()-t1)

permissionTable=luajava.astable(activity.getPackageManager().getPackageInfo(activity.getPackageName(),PackageManager.GET_PERMISSIONS).requestedPermissions)
function applyPermissions(permissions)
  local mAppPermissions = ArrayList()
  for index,content in ipairs(permissions) do
    mAppPermissions.add(content)
  end
  local size = mAppPermissions.size()
  local mArray = mAppPermissions.toArray(String[size])
  pcall(function()activity.requestPermissions(mArray,0)end)
end


function StarVase(context,init)
  if init.enableTheme != false && context then
    loadTheme()
  end
  if init.loadUnnecessaryLib != false then
    loadlualibs()
  end

end

return StarVase
