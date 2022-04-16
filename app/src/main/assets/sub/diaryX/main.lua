require "import"
require "StarVase"(this,{enableTheme=true})
TimingUtil.setName("Diary")
import "com.bumptech.glide.Glide"
import "UIHelper"
sr.setRefreshing(true);
loading.setVisibility(View.VISIBLE)


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
  if isEmp then

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
    locationInfo=activity.getSharedData("lastLocationInfo")
    if (locationInfo) then
      locationInfo=require("cjson").decode(locationInfo)
   
      locationText="> __创建于：__  \n"..locationInfo.address.."  \n_(自动保存的位置信息)_"
      else locationText=""
    end
    import "android.text.format.Time"
    time=Time().setToNow()
    year=time.year
    month=time.month+1
    day=time.monthDay

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
    datedia.setText(tostring(year).."/"..tostring(month).."/"..tostring(day))

    datedia.onClick=function()
      task(100,function()

        import "com.google.android.material.bottomsheet.BottomSheetDialog"
        tag={}
        local dann=import("layout.date_dialog")

        dl1=BottomSheetDialog(activity)
        dl1.setContentView(loadlayout(dann,tag))
        an=dl1.show()
        bottom = dl1.findViewById(R.id.design_bottom_sheet);
        if (bottom != nil) then
          bottom
          .setBackgroundResource(android.R.color.transparent)
          .setPadding(math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(32))
        end

        tag.okey.onClick=function()
          year=tag.dp.getYear()
          month=tag.dp.getMonth()+1
          day=tag.dp.getDayOfMonth()
          datedia.setText(tostring(year).."/"..tostring(month).."/"..tostring(day))

          dl1.dismiss()
        end
        tag.cancel.onClick=lambda -> dl1.dismiss()
      end)
    end


    okey.onClick=function()
      local calendar = Calendar.getInstance()
      calendar.set(year,month-1,day)
      if edit.getText() then
        CreateFileUtil.diary({
          title=edit.getText(),

          content="# "..TimeUtil.getShortDate(this,calendar).."  \n"..locationText,
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

fab.onLongClick=function()
  clickToUnlock()
  return true
end