--require "import"

function import(str)
  val1=luajava.bindClass(str)
  return val1
end
--[[import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"]]
import "android.content.Intent"

--import "muk"
--删掉“--”注释符号以使用中文函数

if activity.getPackageName()~="com.StarVase.diaryTodo" then
  Uri=import "android.net.Uri"
  Intent=import "android.content.Intent"
  ComponentName=import "android.content.ComponentName"
  intent = Intent(Intent.ACTION_MAIN);
  intent.setComponent(ComponentName("com.StarVase.diaryTodo","com.StarVase.diaryTodo.app.BaseActivity"));
  intent.setData(Uri.parse(activity.getLuaDir().."/MainActivity.lua"));
  this.startActivity(intent)
  this.finish()
 else
  --this.startActivity(Intent(this,luajava.bindClass("com.StarVase.diaryTodo.app.MainActivity")));
end