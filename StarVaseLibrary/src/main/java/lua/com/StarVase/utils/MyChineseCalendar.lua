module(...,package.seeall)
require "import"
pcall(function()import "github.daisukiKaffuChino.LuaLunarCalender"end)

function getChineseLunar()
    local calendar = Calendar.getInstance()
    local year = calendar.get(Calendar.YEAR)
    local month = calendar.get(Calendar.MONTH)+1
    local day = calendar.get(Calendar.DATE)
    local lunarCalender = LuaLunarCalender()
    local lunarString = lunarCalender.getLunarString(year, month, day)
    local fesival = lunarCalender.getFestival(year, month, day)
  return lunarString
end
