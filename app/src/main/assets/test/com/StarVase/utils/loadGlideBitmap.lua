require "import"
import "com.bumptech.glide.Glide"

return function(path,view)
  if not path:find("^https*://") and not path:find("%.%a%a%a%a?$") then
    path=path..".png"
  end
  if path:find("^https*://") or path:find("^/") then
    Glide.with(context).load(path).into(view)
   else
    Glide.with(context).load(string.format("%s/%s",luajava.luadir,path)).into(view)
  end
end
