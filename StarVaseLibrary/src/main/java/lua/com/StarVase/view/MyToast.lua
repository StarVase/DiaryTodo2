--module(...,package.seeall)
local MyToast={}
setmetatable(MyToast,MyToast)
import "com.google.android.material.snackbar.Snackbar"
local context=activity or service

function MyToast.showToast(text)
  Toast.makeText(context,text,Toast.LENGTH_SHORT).show()
end

function MyToast.showSnackBar(text,view)
  Snackbar.make(view or mainLay or context.getDecorView(),text,Snackbar.LENGTH_SHORT)
  --.setAnimationMode(Snackbar.ANIMATION_MODE_SLIDE)
  .show()
end

--根据是否有view或者mainLay来是否显示SnackBar
function MyToast.autoShowToast(text,view)
  local view=view or mainLay
  if view then
    MyToast.showSnackBar(text,view)
   else
    MyToast.showToast(text)
  end
end

--根据网络错误代码显示Toast或SnackBar
function MyToast.showNetErrorToast(code,view)
  MyToast.autoShowToast(NetErrorStr(code),view)
end

--复制文字然后显示Toast
function MyToast.copyText(text,view)
  _G.copyText(text)
  MyToast.autoShowToast(R.string.Jesse205_toast_copied,view)
end

--显示“xxx成功/失败”
function MyToast.pcallToToast(succeedStr,failedStr,succeed)
  if succeed then
    MyToast.showToast(succeedStr)
   else
    MyToast.showToast(failedStr)
  end
end
function MyToast.pcallToSnackbar(view,succeedStr,failedStr,succeed)
  local text
  if succeed then
    text=succeedStr
   else
    text=failedStr
  end
  MyToast.showSnackBar(view,text)
end

--调用 MyToast() 时
function MyToast.__call(self,text,view)
  MyToast.autoShowToast(text,view)
end

return MyToast