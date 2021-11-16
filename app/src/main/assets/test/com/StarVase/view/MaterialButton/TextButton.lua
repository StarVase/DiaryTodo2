local R=luajava.bindClass("com.StarVase.library.R")
local LayoutInflater=luajava.bindClass("android.view.LayoutInflater")
local myWidget={
  _baseClass=luajava.bindClass("com.google.android.material.button.MaterialButton"),
  __call=function(self,context)
    local iInflater=LayoutInflater.from(context)
    return (iInflater.inflate(R.layout.abc_materialbutton_textbutton,nil))
  end,
}
setmetatable(myWidget,myWidget)
_G.TextButton=myWidget

return myWidget