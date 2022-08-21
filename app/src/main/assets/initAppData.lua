function initSharedData(name,value)
  if activity.getSharedData(name) == nil then
    activity.setSharedData(name,value)
  end
end


Thread(Runnable{
  run=function()
    local CreateFileUtil=require "com.StarVase.diaryTodo.CreateFileUtil"
    CreateFileUtil.createDatabase()
    if !activity.getSharedData("DocumentConverted")
      require "models.DocumentConverter".convert()
    end


  end
}).start()


initSharedData("BingImage",true)
initSharedData("WeatherTip",true)
initSharedData("AutoBackup",true)
initSharedData("EncryptDiary",false)
initSharedData("theme",1)
initSharedData("LastUserTheme",1)
initSharedData("导航栏使用暗色",false)
initSharedData("YiyanEnabled",true)
initSharedData("DiaryPassword",nil)
initSharedData("FontSize",16)
initSharedData("FuncBarMargin",false)
initSharedData("GetFocused",true)
initSharedData("EnableFingerprint",false)