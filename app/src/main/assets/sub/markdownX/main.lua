require "import"
import "StarVase"
import "UiHelper"

function onOptionsItemSelected(item)
  local id=item.getItemId()
  if id==android.R.id.home then
    activity.finish()
  end
end


path=basepath



filetag.addOnTabSelectedListener(OnTabSelectedListener{
  onTabSelected=function(tab)
    task(1,function()
      path=filetag.getPath()
      task(10,lambda -> refresh(path))
    end)
  end
})


listView2.onItemClick=function(l,v,p,i)
  if (data2[i].type == "file")
    filepath=data2[i].path.toString()
    if (isSupportedFile(filepath)) then
      openFile(filepath)
     else
      MyToast.showSnackBar("暂不支持编辑此类型的文件")
    end
    task(10,lambda -> recent())
    --filetag.setPath(path)
   elseif (data2[i].type == "dir" or "back") then
    path=data2[i].path.toString()
    task(10,lambda -> refresh(path))
    filetag.setPath(path)
  end
  return true
end

onResume = lambda -> task(10,function() refresh(path) recent()end)