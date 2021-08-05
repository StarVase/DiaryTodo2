require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"

--import "muk"
--删掉“--”注释符号以使用中文函数
import "androidx.recyclerview.widget.RecyclerView"
import "androidx.appcompat.widget.LinearLayoutCompat"
import "com.StarVase.diaryTodo.view.FileTagView"
import "com.google.android.material.tabs.TabLayout"
import "android.animation.LayoutTransition"



layout={
  LinearLayoutCompat,
  layout_height="fill";
  layout_width="fill";
  orientation="vertical";
  layoutTransition=LayoutTransition().enableTransitionType(LayoutTransition.CHANGING);
  {
    FileTagView,
    layoutTransition=LayoutTransition().enableTransitionType(LayoutTransition.CHANGING);
    --layout_gravity="center",
    id="filetag",
    layout_width="fill";
    tabMode=TabLayout.MODE_SCROLLABLE;
    --layout_margin="8dp";
    layout_height="48dp";
    selectedTabIndicatorHeight=0;
    --visibility=View.GONE;
    inlineLabel=true;
    paddingLeft="16dp";
    paddingRight="16dp";
    clipToPadding=false;
    --tabIconTint=ColorStateList({{}},{theme.color.textColorSecondary});
    layoutTransition=LayoutTransition().enableTransitionType(LayoutTransition.CHANGING);
    --minimumWidth=0;
  },
  {
    ListView,
    layoutTransition=LayoutTransition().enableTransitionType(LayoutTransition.CHANGING);
    id="listView",
    layout_height="fill";
    layout_width="fill";
  }
}


item={
  LinearLayout,
  orientation="vertical",
  layout_width="fill",
  {
    TextView,
    id="text",
    textColor=0xff000000,
    layout_margin="15dp",
    layout_width="fill"
  },
}

activity.setContentView(loadlayout(layout))



import "java.lang.String"
import "androidx.recyclerview.widget.StaggeredGridLayoutManager"
import "com.google.android.material.tabs.TabLayout$OnTabSelectedListener"
import "com.StarVase.library.adapter.MyLuaAdapter"
data={}
adp=MyLuaAdapter(activity,data,item)
listView.setAdapter(adp)

nowPath=Environment.getExternalStorageDirectory().toString()
filetag.setPath(nowPath)
--filetag.setPath("")






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

--print(安卓版本,设备型号,SDK版本,CPU架构,硬件类型)