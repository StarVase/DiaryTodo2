require "import"
import "StarVase"
import "UiHelper"


function onOptionsItemSelected(item)
  local id=item.getItemId()
  if id==android.R.id.home then
    activity.finish()
  end
end

import "java.lang.String"
import "androidx.recyclerview.widget.StaggeredGridLayoutManager"
import "com.google.android.material.tabs.TabLayout$OnTabSelectedListener"
import "com.StarVase.library.adapter.MyLuaAdapter"
data={}
adp=MyLuaAdapter(activity,data,expItem)
listView.setAdapter(adp)

nowPath=Environment.getExternalStorageDirectory().toString()
filetag.setPath(nowPath)

import "java.io.File"
local datas={}--空data适配器的data
local fileList

function listFile(nowPath)
  fileList=File(nowPath).listFiles()--获取文件列表
  if fileList then
    fileList=luajava.astable(fileList)--转换为LuaTable
   else
    fileList={}
  end
  table.sort(fileList,function(a,b)
    return string.upper(a.getName())<string.upper(b.getName())
  end)

  return fileList
end


function refresh(path)
  fileList=listFile(path)
  nowPath=path
  adp.clear()
  dir={}
  file={}
  --添加数据
  for key,value in ipairs(fileList) do
    if value.isDirectory() then
      local name=value.getName()
      table.insert(dir,{n=name,p=value})
     elseif value.isFile() then
      local name=value.getName()
      table.insert(file,{n=name,p=value})
    end
  end
  if #luajava.astable(String(path).split("/")) > 4 then
    adp.add({text=".../",path=File(path).getParentFile(),type="back"})
    filetag.setVisibility(View.VISIBLE)
   elseif #luajava.astable(String(path).split("/")) < 4 then
    adp.add({text="回到内置存储目录",path=Environment.getExternalStorageDirectory(),type="dir"})
    filetag.setVisibility(View.GONE)
   else
    filetag.setVisibility(View.GONE)
  end
  for k,v in ipairs(dir) do
    adp.add({text=v.n.."/",path=v.p,type="dir"})
  end
  for k,v in ipairs(file) do
    adp.add({text=v.n,path=v.p,type="file"})
  end
end

refresh((nowPath))




filetag.addOnTabSelectedListener(OnTabSelectedListener{
  onTabSelected=function(tab)
    task(1,function()
      path=filetag.getPath()
      refresh((path))
      
    end)
  end
})


listView.onItemClick=function(l,v,p,i)
  if (data[i].type == "file")
    path=data[i].path.toString()
    print((path))
    filetag.setPath(path)
   elseif (data[i].type == "dir" or "back") then
    path=data[i].path.toString()
    refresh((path))
    filetag.setPath(path)
  end
  return true
end
