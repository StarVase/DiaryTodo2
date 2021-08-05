module(...,package.seeall)
function setHeight(view,from,to)
  version_sdk = Build.VERSION.SDK
  if tonumber(version_sdk)>=21 then
    ObjectAnimator.ofFloat(view,"Z",{from or view.getZ(),to or 8})
    .setDuration(200)
    .start()
  end
end

function AutoElevation(Toolbar,progress)
  if progress == 0 then
    MyToolbarStyle.setHeight(Toolbar,nil,0)
   else
    MyToolbarStyle.setHeight(Toolbar,nil,8)
  end
end

