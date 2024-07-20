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

PrivacyState=activity.getSharedData("PrivacyState20240720")
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

--[[
/**
* 更新隐私合规状态,需要在初始化地图之前完成
* @param  context: 上下文 
* @param  isContains: 隐私权政策是否包含高德开平隐私权政策  true是包含 
* @param  isShow: 隐私权政策是否弹窗展示告知用户 true是展示 
* @since  8.1.0 
*/
public static void updatePrivacyShow(Context context, boolean isContains, boolean isShow) ;
Java
/**
 * 更新同意隐私状态,需要在初始化地图之前完成
 * @param context: 上下文
 * @param isAgree: 隐私权政策是否取得用户同意  true是用户同意
 * @since 8.1.0
 */
public static void updatePrivacyAgree(Context context, boolean isAgree) ;
]]

