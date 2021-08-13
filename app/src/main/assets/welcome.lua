require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.content.Intent"
import "com.StarVase.utils.language"
--先行导入以减少主应用负担
import "initSharedData"
R=luajava.bindClass(activity.getPackageName()..".R")
import "shortCut"
import "android.content.pm.PackageManager"
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

permission={"android.permission.READ_EXTERNAL_STORAGE","android.permission.READ_EXTERNAL_STORAGE"}
applyPermissions(permission)

--print(activity.getPackageName())
if activity.getPackageName()~="com.StarVase.diaryTodo" then
  import "android.net.Uri"
  import "android.content.Intent"
  import "android.content.ComponentName"
  intent = Intent(Intent.ACTION_MAIN);
  intent.setComponent(ComponentName("com.StarVase.diaryTodo","com.StarVase.diaryTodo.app.BaseActivity"));
  intent.setData(Uri.parse(this.getLuaDir().."/main.lua"));
  this.startActivity(intent)
  this.finish()
 else


  pcall(function() import "StarVase" end)

  init={
    SwipeBack=false
  }
  import "com.StarVase.app.MyActivity"
  MyActivity.initActivity(init)
  activity.setTheme(R.style.welcome)
  function onCreate()
    pcall(function()activity.setContentView(R.layout.welcome)end)
  end

  import "com.StarVase.app.MyTheme"
  --activity.startService()
  --activity.stopService()
  import "android.text.SpannableString"
  import "android.text.style.ForegroundColorSpan"
  import "android.text.Spannable"
  spTitle = SpannableString("Welcome")
  spTitle.setSpan(ForegroundColorSpan(titleColor),0,#spTitle,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
  activity.getSupportActionBar().setTitle(spTitle)
  activity.getSupportActionBar().setDisplayShowCustomEnabled(true)
  activity.getSupportActionBar().setCustomView(editTitle)
  activity.getSupportActionBar().setDisplayHomeAsUpEnabled(true)




  task(1000,function()
    this.startActivity(Intent(this,luajava.bindClass("com.StarVase.diaryTodo.app.MainActivity")));

    this.finish()
  end)

end
