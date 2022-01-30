function initSharedData(name,value)
  if activity.getSharedData(name) == nil then
    activity.setSharedData(name,value)
  end
end

require "com.StarVase.diaryTodo.CreateFileUtil"
Thread(Runnable{
  run=function()
    CreateFileUtil.createDatabase()
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
initSharedData("DiaryPassword",4313)
activity.setSharedData("EncryptDiary",false)

if !activity.getSharedData("DocumentConverted")
  require "models.DocumentConverter".convert()
end