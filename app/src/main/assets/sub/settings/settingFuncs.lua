listView.onItemClick=function(id,v,zero,one)
  state=dataset[one].intent
  --print(state)
  switch state
   case "ChooseTheme"
    sub("theme")

   case "ResetFabPos"
    if pcall(function()
        this.setSharedData("悬浮按钮横坐标",nil)
        this.setSharedData("悬浮按钮纵坐标",nil)
      end) then
      MyToast.showSnackBar("重置成功")
     else
      MyToast.showSnackBar("重置失败")
    end

   case "FontSize"
    MyToast.showSnackBar("Developing...")
   case "EncryptDiary"

   case "PasswordPro"

   case "BingImage"
    if dataset[one].status["Checked"]==true then
      this.setSharedData(state,false)
      dataset[one].status["Checked"]=false
     else
      this.setSharedData(state,true)
      dataset[one].status["Checked"]=true
    end

   case "WeatherTip"
    if dataset[one].status["Checked"]==true then
      this.setSharedData(state,false)
      dataset[one].status["Checked"]=false
     else
      this.setSharedData(state,true)
      dataset[one].status["Checked"]=true
    end
   case "YiyanEnabled"
    if dataset[one].status["Checked"]==true then
      this.setSharedData(state,false)
      dataset[one].status["Checked"]=false
     else
      this.setSharedData(state,true)
      dataset[one].status["Checked"]=true
    end
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
        adp.notifyDataSetChanged()
      end})
    .setNegativeButton("取消",nil)
    .show();
   case "RecoveryBackup"
    sub("backup")

   case "AutoBackup"
    if dataset[one].status["Checked"]==true then
      this.setSharedData(state,false)
      dataset[one].status["Checked"]=false
     else
      this.setSharedData(state,true)
      dataset[one].status["Checked"]=true
    end

   case "AboutApp"
    sub("about")

  end
  adp.notifyDataSetChanged()--更新列表
end