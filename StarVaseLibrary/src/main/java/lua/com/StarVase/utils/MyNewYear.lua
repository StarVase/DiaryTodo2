module(...,package.seeall)


function isNewYearDay(ChineseCalendarString)
  if ChineseCalendarString == "正月 初一 " then
    return 0
   elseif ChineseCalendarString == "腊月 卅十 " then
    return -1
   else return false
  end
end
pcall(function()
  if isNewYearDay(MyChineseCalendar.getChineseLunar()) >= -1 then
    AppTheme.set(3)
  end
end)