require "import"
require "StarVase"(this,{})
import "com.bumptech.glide.Glide"
--import "androidx.swiperefreshlayout.widget.SwipeRefreshLayout"
--import "androidx.coordinatorlayout.widget.CoordinatorLayout"

--import "androidx.coordinatorlayout.widget.CoordinatorLayout"
--import "androidx.swiperefreshlayout.widget.SwipeRefreshLayout"
import "UIHelper"


list.onItemLongClick=function(id,v,zero,one)
  id=data[one].id

  pop=PopupMenu(activity,v)
  menu=pop.Menu
  menu.add("删除").onMenuItemClick=function()
    task(100,function()

      import "com.google.android.material.bottomsheet.BottomSheetDialog"

      local dann=import("layout.delete_dialog")

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
        delete(id)
        dl.dismiss()
      end
      cancel.onClick=lambda -> dl.dismiss()
    end)
  end
  pop.show()
  return true
end



list.onItemClick=function(id,v,zero,one)
  id=data[one].id
  sql="select * from diary WHERE id=?"

  raw(sql,{tostring(id)})
  if cursor.moveToFirst() then
    title = cursor.getString(1);--获取第二列的值
    isEmp = cursor.getInt(6);
    key = cursor.getString(7);
  end
  subed("notepad","diaryX",title,{
    id=id,
    isEmp=isEmp,
    key=key
  })

end


onResume= lambda -> Refresh()


--没注释，不解释不抱怨
function fab.onClick()
  task(1,function()
    import "android.icu.util.Calendar"
    calendar = Calendar.getInstance();
    year = calendar.get(Calendar.YEAR);
    month = calendar.get(Calendar.MONTH)+1;
    day = calendar.get(Calendar.DAY_OF_MONTH);

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
    enccheckbox.setText(AdapLan("启用加密","Enable encryption"))
    if activity.getSharedData("EncryptDiary") then
      enccheckbox.checked=true
     else enccheckbox.enabled=false
    end
    date.setText(tostring(year).."/"..tostring(month).."/"..tostring(day))
    okey.onClick=function()
      if edit.getText() then
        CreateFileUtil.diary({
          title=edit.getText(),
          
          content="",
          isLocked=enccheckbox.checked,
          passkey=activity.getSharedData("DiaryPassword"),
          date={year=year,month=month,day=day},
        })
        MyToast.showSnackBar("Done")
      end
      dl.dismiss()
      Refresh()
    end
    cancel.onClick=lambda -> dl.dismiss()
    --新建对话框(bt,nr,text,qd,qx,qdnr,qxnr,gb)
  end)
end

import "android.app.DatePickerDialog"