require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.content.Intent"

--import "muk"
--删掉“--”注释符号以使用中文函数

if activity.getPackageName()~="com.StarVase.diaryTodo" then
  import "android.net.Uri"
  import "android.content.Intent"
  import "android.content.ComponentName"
  import "java.io.File"
  intent = Intent(Intent.ACTION_MAIN);
  intent.setComponent(ComponentName("com.StarVase.diaryTodo","com.StarVase.diaryTodo.app.BaseActivity"));
  intent.setData(Uri.parse(File(activity.getLuaDir()).getParent().."/assets/MainActivity.lua"));
  this.startActivity(intent)
  this.finish()
 else
  --this.startActivity(Intent(this,luajava.bindClass("com.StarVase.diaryTodo.app.MainActivity")));
end