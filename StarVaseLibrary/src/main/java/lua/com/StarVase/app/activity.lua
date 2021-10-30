require "import"
import "android.content.Intent"
import "android.net.Uri"
import "android.provider.*"
import "com.StarVase.diaryTodo.app.LuaAdapter"
import "android.graphics.drawable.BitmapDrawable"
import "android.graphics.Color"
import "android.support.v7.widget.*"
import "android.graphics.*"
import "android.renderscript.*"
import "android.graphics.drawable.*"
import "android.support.v4.widget.*"
import "com.google.android.material.card.*"
--print(MaterialCardView)
--import "muk"
--删掉“--”注释符号以使用中文函数

屏幕宽度=activity.getWidth()
屏幕高度=activity.getHeight()
lp=activity.getLuaDir()

activity.getWindow().setNavigationBarColor(0xFF000000)

local resid=activity.getResources().getIdentifier("status_bar_height","dimen","android")

if resid>0 then
  状态栏高度 = activity.getResources().getDimensionPixelSize(resid)
 else
  状态栏高度 = w*0.07
end


function sub(name,...)
  activity.newActivity('sub/'..name..'/main',{...})
end

function subed(name,...)
  activity.newActivity(activity.getSharedData("BaseLuaPath").."/sub/"..name.."/main.lua",{...})
end

function AutoSetToolTip(view,text)
  if tonumber(Build.VERSION.SDK) >= 26 then
    view.setTooltipText(text)
  end
end

function getNavigationBarHeight()
  resources = activity.getResources();
  resourceId = resources.getIdentifier("navigation_bar_height","dimen", "android");
  height = resources.getDimensionPixelSize(resourceId);
  return height;
end











