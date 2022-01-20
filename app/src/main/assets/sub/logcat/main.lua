require "import"
import "android.widget.*"
import "android.view.*"
require "StarVase"(this,{})
import "UiHelper"
activity.setContentView(loadlayout(require("layout")))
--activity.setTitle("LogCat")


--添加菜单
items={"All","Lua","Test","Tcc","Error","Warning","Info","Debug","Verbose","Clear"}
function onCreateOptionsMenu(menu)
--  me=menu.add("搜索").setShowAsAction(MenuItem.SHOW_AS_ACTION_ALWAYS)
 -- me.setActionView(edit)
  for k,v in ipairs(items) do
    m=menu.add(v)
    items[v]=m
  end
end


function onOptionsItemSelected(item)
  if func[item.getTitle()] then
    func[item.getTitle()]()
   
  end
end


function readlog(s)
  p=io.popen("logcat -d -v long "..s)
  local s=p:read("*a")
  p:close()
  s=s:gsub("%-+ beginning of[^\n]*\n","")
  if #s==0 then
    s="欲查看运行时日志，请运行App..."
  end
  return s
end

function clearlog()
  p=io.popen("logcat -c")
  local s=p:read("*a")
  p:close()
  return s
end


func={}
func.All=function()
  activity.setTitle("LogCat - All")
  task(readlog,"",show)
end
func.Lua=function()
  activity.setTitle("LogCat - Lua")
  task(readlog,"lua:* *:S",show)
end
func.Test=function()
  activity.setTitle("LogCat - Test")
  task(readlog,"test:* *:S",show)
end
func.Tcc=function()
  activity.setTitle("LogCat - Tcc")
  task(readlog,"tcc:* *:S",show)
end
func.Error=function()
  activity.setTitle("LogCat - Error")
  task(readlog,"*:E",show)
end
func.Warning=function()
  activity.setTitle("LogCat - Warning")
  task(readlog,"*:W",show)
end
func.Info=function()
  activity.setTitle("LogCat - Info")
  task(readlog,"*:I",show)
end
func.Debug=function()
  activity.setTitle("LogCat - Debug")
  task(readlog,"*:D",show)
end
func.Verbose=function()
  activity.setTitle("LogCat - Verbose")
  task(readlog,"*:V",show)
end
func.Clear=function()
  task(clearlog,show)
end

logview=AppCompatTextView(activity)
logview.TextIsSelectable=true
--scroll.addView(logview)
--scroll.addHeaderView(logview)
local r="%[ *%d+%-%d+ *%d+:%d+:%d+%.%d+ *%d+: *%d+ *%a/[^ ]+ *%]"

function show(s)
  -- logview.setText(s)
  --print(s)
  local a=LuaArrayAdapter(activity,{
    AppCompatTextView,
    textIsSelectable=true,
    TextColor=textColor,
    textSize="14sp",
    padding="8dp",
  })
  local l=1
  for i in s:gfind(r) do
    if l~=1 then
      a.add(s:sub(l,i-1))
    end
    l=i
  end
  a.add(s:sub(l))
  adapter=a
  scroll.Adapter=a
end

func.All()

import "android.content.*"
cm=activity.getSystemService(activity.CLIPBOARD_SERVICE)

function copy(str)
  local cd = ClipData.newPlainText("label",str)
  cm.setPrimaryClip(cd)
  Toast.makeText(activity,"已复制的剪切板",1000).show()
end
