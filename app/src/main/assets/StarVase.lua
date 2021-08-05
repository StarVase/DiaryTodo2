require "import"

R=luajava.bindClass(activity.getPackageName()..".R")

import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.util.Log"

import "com.StarVase.app.activity"
import "com.StarVase.utils.ai"
import "com.StarVase.utils.string"
import "com.StarVase.utils.math"
import "com.StarVase.utils.animation"
import "com.StarVase.utils.file"
import "com.StarVase.muk"
import "com.StarVase.utils.graph"
import "com.StarVase.app.MyTheme"
import "com.StarVase.utils.MyChineseCalendar"
import "com.StarVase.utils.MyNewYear"
import "com.StarVase.view.MyDialog"
import "com.StarVase.view.StyleWidget"
import "com.StarVase.view.NoScrollPageView"
import "com.StarVase.app.diary"
import "com.StarVase.app.backup"
import "com.StarVase.utils.loadGlideBitmap"
import "com.StarVase.utils.notice"
import "com.StarVase.app.path"
import "com.StarVase.app"
import "com.StarVase.utils.widget"
import "com.StarVase.utils.MyBitmap"
import "com.StarVase.utils.MyTextStyle"
import "com.StarVase.view.MyToast"
import "com.StarVase.utils.language"
import "com.StarVase.utils.MyToolbarStyle"
import "com.StarVase.yiyan"
import "com.StarVase.library.view.*"
import "com.StarVase.utils.NetErrorStr"
import "com.StarVase.utils.ScreenFixUtil"

import "com.StarVase.diaryTodo.CreateFileUtil"
import "com.StarVase.diaryTodo.Copyright"
--import "com.StarVase.MyCamera"
pcall(function()import "com.StarVase.app.MyActivity"end)

activity.setLuaExtDir(path.app)

import "android.database.sqlite.*"
--打开数据库(没有自动创建)
--db = SQLiteDatabase.openOrCreateDatabase(path.app .. "data.db",MODE_PRIVATE, nil);

function println(内容)
  内容=tostring(内容)
  Toast.makeText(activity,"日记与待办:"..内容,Toast.LENGTH_SHORT).show()
end

function importFile(this,file)
  return import("sub/"..this.."/"..file)
end

function writelog()
end


function TrueAndFalseColor(text,word)
  if text then
    return MyTextStyle.TextColor(word,0,utf8.len(word),0xFFF44336)
   else
    return word
  end
end

function highLight(word)
  return MyTextStyle.TextColor(word,0,utf8.len(word),0xFFF44336)
end


if isNightMode(this) then
  AppTheme.setBySystem(6)
 else
  AppTheme.setByUser(activity.getSharedData("LastUserTheme"))
end


activity.setTheme(themea or 0)


import "com.StarVase.utils.MyAnimationUtil"
upArrow = this.getDrawable(R.drawable.abc_ic_ab_back_material);
if(upArrow != nil) then
  upArrow.setColorFilter(titleColor, PorterDuff.Mode.SRC_ATOP);
  if(activity.getSupportActionBar() != nil) then
    activity.getSupportActionBar().setHomeAsUpIndicator(upArrow);
  end
end