require "import"
import "StarVase"
import "UIHelper"



list.onItemLongClick=function(id,v,zero,one)
  --print(dump(data))
  id=data[one].id

  pop=PopupMenu(activity,v)
  menu=pop.Menu
  menu.add("删除").onMenuItemClick=function()
    delete(id)
  end
  pop.show()
  return true
end
import "java.lang.String"

function fab.onClick()
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

    okey.onClick=function()
      if edit.getText() then
        CreateFileUtil.todo({
          title=tostring(edit.getText()),
          timestamp=tostring(os.time()),
          isHighlight="false",
          highlightColor=0
        })
        MyToast.showSnackBar("Done")
      end
      dl.dismiss()
      Refresh()
    end
    cancel.onClick=lambda -> dl.dismiss()
  end)
end




list.onItemClick=lambda(id,v,zero,one)=>
do
id=data[one].id
sql="select * from inspiration WHERE id=?"

raw(sql,{tostring(id)})
if cursor.moveToFirst() then
  title = cursor.getString(1);--获取第二列的值

end
sub("notepad","inspirationX",title,{
  id=id,
})

end

onResume = lambda -> Refresh()