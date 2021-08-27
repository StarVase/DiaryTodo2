require "import"
import "StarVase"
import "UiHelper"

function onOptionsItemSelected(item)
  local id=item.getItemId()
  if id==android.R.id.home then
    activity.finish()
  end
end


crtpath=basepath



filetag.addOnTabSelectedListener(OnTabSelectedListener{
  onTabSelected=function(tab)
    task(1,function()
      crtpath=filetag.getPath()
      task(10,lambda -> refresh(crtpath))
    end)
  end
})


listView2.onItemClick=function(l,v,p,i)
  if (data2[i].type == "file")
    filepath=data2[i].path.toString()
    if (isSupportedFile(filepath)) then
      task(10,lambda -> openFile(filepath))
     else
      MyToast.showSnackBar("暂不支持编辑此类型的文件")
    end
    task(10,lambda -> recent())
    --filetag.setPath(path)
   elseif (data2[i].type == "dir" or "back") then
    crtpath=data2[i].path.toString()
    task(10,lambda -> refresh(crtpath))
    filetag.setPath(crtpath)
  end
  return true
end

listView1.onItemClick=function(l,v,p,i)
  if (data1[i].sub.Text&&File(data1[i].sub.Text).isFile())
    task(10,lambda -> openFile(data1[i].sub.Text))
  end
end

onResume = lambda -> task(10,function() refresh(crtpath) recent()end)