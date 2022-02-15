require "import"
import "android.widget.*"
import "android.view.*"
require "StarVase"(this,{enableTheme=true})
import "UiHelper"
--activity.setTitle("LogCat")


--添加菜单
items={"All","Lua","Test","Tcc","Error","Warning","Info","Debug","Verbose","Clear"}
function onCreateOptionsMenu(menu)

  for k,v in ipairs(items) do
    m=menu.add(v)
    items[v]=m
  end
end


function onOptionsItemSelected(item)
  if func[item.getTitle()] then
    func[item.getTitle()]()
  end
  local id=item.getItemId()
  if id==android.R.id.home then
    activity.finish()
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
  activity.getSupportActionBar().setSubtitle("全部")
  task(readlog,"",show)
end
func.Lua=function()
  activity.getSupportActionBar().setSubtitle("Lua")
  task(readlog,"lua:* *:S",show)
end
func.Test=function()
  activity.getSupportActionBar().setSubtitle("测试")
  task(readlog,"test:* *:S",show)
end
func.Tcc=function()
  activity.getSupportActionBar().setSubtitle("Tcc")
  task(readlog,"tcc:* *:S",show)
end
func.Error=function()
  activity.getSupportActionBar().setSubtitle("错误")
  task(readlog,"*:E",show)
end
func.Warning=function()
  activity.getSupportActionBar().setSubtitle("警告")
  task(readlog,"*:W",show)
end
func.Info=function()
  activity.getSupportActionBar().setSubtitle("信息")
  task(readlog,"*:I",show)
end
func.Debug=function()
  activity.getSupportActionBar().setSubtitle("调试")
  task(readlog,"*:D",show)
end
func.Verbose=function()
  activity.getSupportActionBar().setSubtitle("Verbose")
  task(readlog,"*:V",show)
end
func.Clear=function()
  task(clearlog,show)
end

local r="%[ *%d+%-%d+ *%d+:%d+:%d+%.%d+ *%d+: *%d+ *%a/[^ ]+ *%]"

function show(s)
  dataset={}
  local l=1
  for i in s:gfind(r) do
    if l~=1 then
      text=(s:sub(l,i-1))
      table.insert(dataset,{content=text})
    end
    l=i
  end
  --print(s:sub(l))
  adapter=require"adapter"(dataset)
  recycler.setAdapter(adapter)
  adapter.notifyDataSetChanged()
end

func.All()

