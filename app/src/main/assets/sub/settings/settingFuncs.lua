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
     import "androidx.appcompat.app.AlertDialog"
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
      subed("backup")

     case "AutoBackup"
      if dataset[one].status["Checked"]==true then
        this.setSharedData(state,false)
        dataset[one].status["Checked"]=false
       else
        this.setSharedData(state,true)
        dataset[one].status["Checked"]=true
      end
      SwitchIn.checked=unBoolean(SwitchIn.checked)
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