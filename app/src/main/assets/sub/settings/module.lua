import "android.os.Environment"
import "android.graphics.Typeface"


--打印字符
function Toast(str)
  local toast = luajava.bindClass("android.widget.Toast")
  toast.makeText(activity, tostring(str),toast.LENGTH_SHORT).show()
end


--字符常量
statusBarColor="#00796B";
colorPrimary="#009688";
colorAccent="#4DB6AC";
APP_PACKAGENAME=activity.getPackageName()
Bold=Typeface.defaultFromStyle(Typeface.BOLD)
APP_CACHEPATH=tostring(activity.getExternalCacheDir())
SDCARD_PATH=tostring(Environment.getExternalStorageDirectory())
APP_VERSIONCODE=activity.getPackageManager().getPackageInfo(APP_PACKAGENAME, 0).versionCode
APP_VERSIONNAME=activity.getPackageManager().getPackageInfo(APP_PACKAGENAME, 0).versionName





--自动主题
function switchtheme(pattern,layout)--主题模式(不填则自动)、布局表(aly文件路径或表)
  local h=tonumber(os.date("%H"))
  if Build.VERSION.SDK_INT >= 21 then
    if pattern == "白天" then
      this.setTheme(android.R.style.Theme_Material_Light_DarkActionBar)
      this.ActionBar.setBackgroundDrawable(ColorDrawable(Color.parseColor(colorPrimary)))
      this.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(Color.parseColor(statusBarColor))
    elseif pattern == "夜间" then
      this.setTheme(android.R.style.Theme_Material)
    else
      if h<=6 or h>=22 then
        this.setTheme(android.R.style.Theme_Material)
      else
        this.setTheme(android.R.style.Theme_Material_Light_DarkActionBar)
        this.ActionBar.setBackgroundDrawable(ColorDrawable(Color.parseColor(colorPrimary)))
        this.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(Color.parseColor(statusBarColor))
      end
      this.ActionBar.setElevation(6)
    end
  else
    if pattern == "白天" then
      this.setTheme(android.R.style.Theme_Holo_Light_DarkActionBar)
      this.ActionBar.setBackgroundDrawable(ColorDrawable(Color.parseColor(colorPrimary)))
    elseif pattern == "夜间" then
      this.setTheme(android.R.style.Theme_Holo)
    else
      if h<=6 or h>=22 then
        this.setTheme(android.R.style.Theme_Holo)
      else
        this.setTheme(android.R.style.Theme_Holo_Light_DarkActionBar)
        this.ActionBar.setBackgroundDrawable(ColorDrawable(Color.parseColor(colorPrimary)))
      end
    end
  end
  if layout~=nil then
    this.setContentView(loadlayout(layout))
  end
end