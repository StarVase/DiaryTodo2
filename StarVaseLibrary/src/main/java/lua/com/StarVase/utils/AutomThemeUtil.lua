require "import"
import "android.widget.*"
import "android.view.*"
xpcall(function()R=luajava.bindClass(activity.getPackageName()..".R")end,
function()R={style={}}end)

local function build(str)
  if Build.VERSION.SDK_INT==26 then
    loadstring("theme=R.style.m"..str)
   else
    loadstring("theme=R.style."..str)
  end
  return theme
end

return build