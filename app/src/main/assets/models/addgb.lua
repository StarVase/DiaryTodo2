function addDiary()
  task(1,function()
    import "android.icu.util.Calendar"
    calendar = Calendar.getInstance();
    year = calendar.get(Calendar.YEAR);
    month = calendar.get(Calendar.MONTH)+1;
    day = calendar.get(Calendar.DAY_OF_MONTH);

    import "com.google.android.material.bottomsheet.BottomSheetDialog"

    local dann=import "sub.diaryX.layout.add_dialog"

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
          isLocked=enccheckbox.checked,
          passkey=activity.getSharedData("DiaryPassword"),
          date={year=year,month=month,day=day},
        })
        MyToast.showSnackBar("Done")
      end
      dl.dismiss()
      --Refresh()
    end
    cancel.onClick=lambda -> dl.dismiss()
    --新建对话框(bt,nr,text,qd,qx,qdnr,qxnr,gb)
  end)
end

function addBulb()
  task(1,function()

    import "com.google.android.material.bottomsheet.BottomSheetDialog"

    local dann=import "sub.inspirationX.layout.add_dialog"

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
        CreateFileUtil.inspiration({
          title=edit.getText(),
          timestamp=os.time()
        })
        MyToast.showSnackBar("Done")
      end
      dl.dismiss()
      --Refresh()
    end
    cancel.onClick=lambda -> dl.dismiss()
    --新建对话框(bt,nr,text,qd,qx,qdnr,qxnr,gb)
  end)
end


function addtodo()
  task(1,function()

    import "com.google.android.material.bottomsheet.BottomSheetDialog"

    local dann=import "sub.todoX.layout.add_dialog"

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
      --Refresh()
    end
    cancel.onClick=lambda -> dl.dismiss()
  end)
end

function addFav()
  task(1,function()

    import "com.google.android.material.bottomsheet.BottomSheetDialog"

    local dann=import "sub.collectionX.layout.add_dialog"

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
        CreateFileUtil.collection({
          title=edit.getText(),
          timestamp=os.time()
        })
        MyToast.showSnackBar("Done")
      end
      dl.dismiss()
      --Refresh()
    end
    cancel.onClick=lambda -> dl.dismiss()
    --新建对话框(bt,nr,text,qd,qx,qdnr,qxnr,gb)
  end)
end