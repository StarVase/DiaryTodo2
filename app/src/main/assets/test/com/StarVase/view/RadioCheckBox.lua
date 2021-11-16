local R=luajava.bindClass("com.StarVase.library.R")
local LayoutInflater=luajava.bindClass("android.view.LayoutInflater")
local myWidget={
  _baseClass=luajava.bindClass("androidx.appcompat.widget.AppCompatCheckBox"),
  __call=function(self,context)
    local iInflater=LayoutInflater.from(context)
    return (iInflater.inflate(R.layout.abc_radiocheckbox,nil))
  end,
}
setmetatable(myWidget,myWidget)
_G.TextButton=myWidget

return myWidget