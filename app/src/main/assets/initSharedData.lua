function initSharedData(name,value)
  if activity.getSharedData(name) == nil then
    activity.setSharedData(name,value)
  end
end

initSharedData("BingImage",true)
initSharedData("WeatherTip",true)
initSharedData("AutoBackup",true)
initSharedData("日记加密",false)
initSharedData("theme",1)
initSharedData("LastUserTheme",1)
initSharedData("导航栏使用暗色",false)
initSharedData("YiyanEnabled",true)
