function import(str)
  val1=luajava.bindClass(str)
  return val1
end

import "android.content.Intent"

if activity.getPackageName()~="com.StarVase.diaryTodo" then
  Uri=import "android.net.Uri"
  Intent=import "android.content.Intent"
  ComponentName=import "android.content.ComponentName"
  intent = Intent(Intent.ACTION_MAIN);
  intent.setComponent(ComponentName("com.StarVase.diaryTodo","com.StarVase.diaryTodo.app.IntentHandlerActivity"));
  intent.setData(Uri.parse(activity.getLuaDir().."/MainActivity.lua"));
  --intent.setData(Uri.parse(activity.getLuaDir().."/test.lua"));

  this.startActivity(intent)
  this.finish()
end


