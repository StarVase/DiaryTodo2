recvdir=...
require "import"
require "StarVase"(this,{enableTheme=true})
TimingUtil.setName("Document")
import "UiHelper"

function onOptionsItemSelected(item)
  local id=item.getItemId()
  if id==android.R.id.home then
    activity.finish()
  end
end


crtpath=basepath

fab.onClick=function()
  task(1,function()

    import "com.google.android.material.bottomsheet.BottomSheetDialog"

    local dann=import "layout.add_dialog"

    dl=BottomSheetDialog(activity)
    dl.setContentView(loadlayout(dann))
    an=dl.show()
    bottom = dl.findViewById(R.id.design_bottom_sheet);
    if (bottom != nil) then
      bottom
      .setBackgroundResource(android.R.color.transparent)
      .setPadding(math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(32))
    end
    pathD.setText(crtpath)
    okey.onClick=function()
      if tostring(titleD.getText())=="" then
        titleD.setError("Null")
       elseif tostring(pathD.getText())=="" then
        pathD.setError("Null")
       else
        --print(file.getExtensionName(tostring(titleD.getText())))
        if file.getExtensionName(tostring(titleD.getText()))=="md" or file.getExtensionName(tostring(titleD.getText()))=="mdx" then

          Thread(Runnable({run=function()
              newpath=tostring(pathD.getText()).."/"..tostring(titleD.getText())
              file.writeFile(newpath,tostring(""))
            end})).run()
         else

          Thread(Runnable({run=function()
              newpath=tostring(pathD.getText()).."/"..tostring(titleD.getText())..".mdx"
              file.writeFile(newpath,tostring(""))
            end})).run()
        end
        MyToast.showSnackBar("Done")

        dl.dismiss()
        refresh(crtpath)
      end
    end
    cancel.onClick=lambda -> dl.dismiss()
    --新建对话框(bt,nr,text,qd,qx,qdnr,qxnr,gb)
  end)
end




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
