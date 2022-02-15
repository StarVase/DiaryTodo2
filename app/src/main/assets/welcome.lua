require "import"
require "StarVase"(this,{enableTheme=true,loadUnnecessaryLib=false})
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.net.Uri"
import "android.content.Intent"
import "android.content.ComponentName"
import "com.StarVase.utils.language"
import "com.StarVase.app.MyActivity"
--先行导入以减少主应用负担
import "initAppData"
R=luajava.bindClass(activity.getPackageName()..".R")
import "shortCut"

permission={"android.permission.READ_EXTERNAL_STORAGE","android.permission.READ_EXTERNAL_STORAGE"}
applyPermissions(permission)

if activity.getPackageName()!="com.StarVase.diaryTodo" then
  intent = Intent(Intent.ACTION_MAIN);
  intent.setComponent(ComponentName("com.StarVase.diaryTodo","com.StarVase.diaryTodo.app.BaseActivity"));
  intent.setData(Uri.parse(this.getLuaDir().."/main.lua"));
  this.startActivity(intent)
  this.finish()
end

MyActivity.initActivity({
  SwipeBack=false
})

function onCreate()
  pcall(function()activity.setContentView(R.layout.welcome)end)
  windowBGC(BGC)
end

spTitle = SpannableString("Welcome")
spTitle.setSpan(ForegroundColorSpan(titleColor),0,#spTitle,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
activity.getSupportActionBar().setTitle(spTitle)
activity.getSupportActionBar().setDisplayShowCustomEnabled(true)
activity.getSupportActionBar().setCustomView(editTitle)
activity.getSupportActionBar().setDisplayHomeAsUpEnabled(true)

PrivacyState=activity.getSharedData("PrivacyState")
if !PrivacyState then
  activity.newActivity("sub/privacy/main.lua")
  activity.finish()
 else
  task(800,function()
    this.startActivity(Intent(this,luajava.bindClass("com.StarVase.diaryTodo.app.MainActivity")));
    this.finish()
  end)
end

function windowBGC(color)
  import "android.graphics.drawable.ColorDrawable"
  import "android.view.WindowManager"
  _window = activity.getWindow();
  _window.setBackgroundDrawable(ColorDrawable(color));
  _wlp = _window.getAttributes();
  _wlp.gravity = Gravity.BOTTOM;
  _wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
  _wlp.height = WindowManager.LayoutParams.MATCH_PARENT;--WRAP_CONTENT
  _window.setAttributes(_wlp);
end