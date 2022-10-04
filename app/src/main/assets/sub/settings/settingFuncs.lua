function unBoolean(blin)
  if blin == true then
    return false
   elseif blin == false then
    return true
   else
    return blin
  end
end
onItemClick=function(one,SwitchIn)
  task(1,function()
    state=dataset[one].intent
    --print(state)
    switch state
     case "ChooseTheme"
      subed("theme")

     case "ResetFabPos"
      if pcall(function()
          this.setSharedData("悬浮按钮横坐标",nil)
          this.setSharedData("悬浮按钮纵坐标",nil)
        end) then
        MyToast.showSnackBar("重置成功")
       else
        MyToast.showSnackBar("重置失败")
      end

     case "FontStyle"
      activity.newActivity("fontstyle/main.lua")
      --MyToast.showSnackBar("Developing...")

     case "FuncBarMargin"
      if dataset[one].status["Checked"]==true then
        this.setSharedData(state,false)
        dataset[one].status["Checked"]=false
       else
        this.setSharedData(state,true)
        dataset[one].status["Checked"]=true
      end
      SwitchIn.checked=unBoolean(SwitchIn.checked)


     case "EncryptDiary"
      --activity.newActivity("models/setPassword.lua")
      --dataset[one].status["Checked"]=this.getSharedData(state)
      if !dataset[one].status["Checked"] then
        activity.newActivity("password/main.lua")
       else
        activity.newActivity("password/forget.lua")
      end

     case "EnableFingerprint"
      if dataset[one].status["Checked"]==true then
        this.setSharedData(state,false)
        dataset[one].status["Checked"]=false
        SwitchIn.checked=unBoolean(SwitchIn.checked)
       else
        AlertDialog.Builder(this)
        .setTitle(AdapLan("请注意！","Pay Attention!"))
        .setMessage(AdapLan("开启此选项意味着您可以通过使用在此设备上注册过的任意指纹对日记进行解密，可能面临着被其他人偷窥的风险，请权衡利弊！","Turning this option on means that you can decrypt the diary by using any fingerprint registered on this device, you may face the risk of being peeped by others, please weigh the pros and cons!"))
        .setPositiveButton(AdapLan("确定","Okey"),{onClick=function(v)
            task(100,function()
              if (!activity.getSharedData("EncryptDiary")) then
                MyToast.showSnackBar(AdapLan("您还未开启加密功能","You have not enabled encrypt yet"))
               else
                import "com.google.android.material.bottomsheet.BottomSheetDialog"

                local dann=import "layout.typepwd"

                local dl=BottomSheetDialog(activity)
                dl.setContentView(loadlayout(dann))
                dl.setCanceledOnTouchOutside(true)
                dl.setCancelable(true)
                dl.show()
                bottom = dl.findViewById(R.id.design_bottom_sheet);
                if (bottom != nil) then
                  bottom
                  .setBackgroundResource(android.R.color.transparent)
                  .setPadding(math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(32))
                end
                okey.onClick=function()
                  if (typepsk.getText().toString()==activity.getSharedData("DiaryPassword")) then
                    --clickToUnlock(typepsk.getText().toString(),id)
                    this.setSharedData(state,true)
                    dataset[one].status["Checked"]=true
                    SwitchIn.checked=unBoolean(SwitchIn.checked)
                    dl.dismiss()
                    else
                    MyToast.showSnackBar(AdapLan("密码错误","Incorrect password."))
                  end
                  
                end
                cancel.onClick=lambda -> dl.dismiss()
              end
            end)
          end})
        .setNegativeButton(AdapLan("取消","Cancel"),nil)
        .show()

      end
     case "BingImage"
      if dataset[one].status["Checked"]==true then
        this.setSharedData(state,false)
        dataset[one].status["Checked"]=false
       else
        this.setSharedData(state,true)
        dataset[one].status["Checked"]=true
      end
      SwitchIn.checked=unBoolean(SwitchIn.checked)

     case "WeatherTip"
      if dataset[one].status["Checked"]==true then
        this.setSharedData(state,false)
        dataset[one].status["Checked"]=false
       else
        this.setSharedData(state,true)
        dataset[one].status["Checked"]=true
      end
      SwitchIn.checked=unBoolean(SwitchIn.checked)

     case "GetFocused"
      if dataset[one].status["Checked"]==true then
        this.setSharedData(state,false)
        dataset[one].status["Checked"]=false
       else
        this.setSharedData(state,true)
        dataset[one].status["Checked"]=true
      end
      SwitchIn.checked=unBoolean(SwitchIn.checked)

     case "WeatherCity"
      activity.newActivity("selectcity/main.lua")

     case "YiyanEnabled"
      if dataset[one].status["Checked"]==true then
        this.setSharedData(state,false)
        dataset[one].status["Checked"]=false
       else
        this.setSharedData(state,true)
        dataset[one].status["Checked"]=true
      end
      SwitchIn.checked=unBoolean(SwitchIn.checked)

     case "YiyanType"
      local yiyan_type_chooser=AlertDialog.Builder(this)
      .setTitle("一言类型")
      .setSingleChoiceItems(yiyan.listYiyanType("name"),(yiyan.listYiyanType("id")[activity.getSharedData(state) or "undefined"]-1),{
        onClick=function(v,p)
          selectType=yiyan.listYiyanType("key")[p+1]
        end})
      .setPositiveButton("确定",{onClick=function()
          activity.setSharedData(state,selectType)
          dataset[one].message=yiyan.listYiyanType("name")[yiyan.listYiyanType("id")[activity.getSharedData(state) or "undefined"]]
          --adapter.submitList(dataset)
        end})
      .setNegativeButton("取消",nil)
      .show();

     case "RecoveryBackup"
      subed("backupX")

     case "AutoBackup"
      if dataset[one].status["Checked"]==true then
        this.setSharedData(state,false)
        dataset[one].status["Checked"]=false
       else
        this.setSharedData(state,true)
        dataset[one].status["Checked"]=true
      end
      SwitchIn.checked=unBoolean(SwitchIn.checked)

     case "LogCat"
      subed('logcat',nil,os.clock())

     case "AboutApp"
      subed("aboutX")

    end
    --recycler.refresh()
    -- dataset={}
    task(100,lambda->nil
    --adapter.notifyDataSetChanged()

    )

  end)
end