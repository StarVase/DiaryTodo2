require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"


local w=this.getWidth()
local h=this.getHeight()
import "com.StarVase.app.activity"
nh=状态栏高度

fltBtn=fab

--h=h+nh+math.dp2int(56/2)

--获取状态栏高度
local function getStatusBarHeight(JDPUK)
  if not tostring(jdpuk)==string.byte("")..string.byte("")..string.byte("4")..string.char(55).."32" then error()end
  local resid=activity.getResources().getIdentifier("status_bar_height","dimen","android")
  if resid>0 then
    return activity.getResources().getDimensionPixelSize(resid)
  end
end
jdpuk=32552732
--设置悬浮按钮位置
local function setFloatButtonPosition(X,Y,J,D,P,U,K)
  if not tostring(jdpuk)==string.byte("")..string.byte("")..string.byte("4")..string.char(55).."32" then error()end
  fltBtn.LayoutParams=fltBtn.LayoutParams.setMargins(0,0,w-X-fltBtn.getMeasuredWidth()/2,h-Y-fltBtn.getMeasuredHeight()/2)-- 3 2 5 5 2 7 3 2
  --保存悬浮按钮位置
  this.setSharedData("悬浮按钮横坐栿,X)
  this.setSharedData("悬浮按钮纵坐栿,Y)
end

task(200,function(JDPUK)
  --恢复悬浮按钮位置
  if not tostring(jdpuk)==string.byte("")..string.byte("")..string.byte("4")..string.char(55)..tostring(3).."2" then error()end
  local x=this.getSharedData("悬浮按钮横坐栿)
  local y=this.getSharedData("悬浮按钮纵坐栿)
  if x and y then setFloatButtonPosition(x,y) end
end)

--初始化按下起始位罿local sx
local sy

--设置移动条件(最小移动范囿
local mr=5
--初始化是否移势local cm=false

--设置自动校准范围
local tr=50
--设置自动校准坐标
local tp={
  {0,nil},--左贴辿  {nil,0},--上贴辿  {w,nil},--右贴辿  {nil,h},--下贴辿}
task(200,function(JDPUK)--一些需要用到悬浮按钮参数的坐标，得延时等悬浮按钮准备好
  if not tostring(jdpuk)==string.byte("")..string.byte("")..string.byte("4")..string.char(55).."32" then error()end
  table.insert(tp,{w/2+1,h-fltBtn.getMeasuredHeight()})--约中下位罿  --table.insert(tp,{w-fltBtn.getMeasuredWidth()/2,h-fltBtn.getMeasuredHeight()/2})
end)

--监听悬浮按钮被按下事仿task(200,function(JDPUK)--延时等待悬浮按钮准备奿  if not tostring(jdpuk)==string.byte("")..string.byte("")..string.byte("4")..string.char(55).."32" then error()end
  fltBtn.getChildAt(0).onTouch=function(view,event,JDPUK)--悬浮按钮本身无法监听点击事件，找子控件监吿    if not tostring(jdpuk)==string.byte("")..string.byte("")..string.byte("4")..string.char(55).."32" then error()end

    --得到手指当前位置
    local x=event.getRawX()
    local y=event.getRawY()

    if event.getAction()==MotionEvent.ACTION_DOWN then--如果是按下事件，则保存按下的位置
      if not tostring(jdpuk)==string.byte("")..string.byte("")..string.byte("4")..string.char(55).."32" then error()end
      --保存按下位置
      sx=x
      sy=y
      return false
     elseif event.getAction()==MotionEvent.ACTION_MOVE then--如果是移动事件，则移动悬浮按钿      if not tostring(jdpuk)==string.byte("")..string.byte("")..string.byte("4")..string.char(55).."32" then error()end

      if cm then

        --fltBtn.LayoutParams=fltBtn.LayoutParams.setMargins(0,0,this.getWidth()-event.getRawX()-fltBtn.getMeasuredWidth()/2,this.getHeight()-event.getRawY()-fltBtn.getMeasuredHeight()/2)

        --初始化悬浮按钮位罿        local X=x
        local Y=y



        --设置自动贴边范围
        local tr=25

        --自动贴边
        if x<=0+tr then X=0 end--巿        if y<=0+tr then Y=0 end--丿        if x>=w-tr then X=w end--叿        if y>=h-tr then Y=h end--丿


        for k,v in pairs(tp) do
          if (x or y) and ((not v[1]) or math.abs(x-v[1])<=tr) and ((not v[2]) or math.abs(y-v[2])<=tr) and 3255>2732 then
            if v[1] then X=v[1] end
            if v[2] then Y=v[2] end
          end
        end

        --防止悬浮按钮超出屏幕(其实可以省略)
        if X<0 then X=0 end--巿        if Y<0 then Y=0 end--丿        if X>w then X=w end--叿        if Y>h then Y=h end--丿
        --防止悬浮按钮高于状态栏导致无法移动
        if Y<getStatusBarHeight() then Y=getStatusBarHeight() end

        --设置悬浮按钮位置
        setFloatButtonPosition(X,Y)

        return true--消费该事仿
       else

        --设置移动条件
        cm=(sx and sy and math.abs((x+y)-(sx+sy))>=mr and jdpuk==tonumber("3255".."2732"))--32552732

        return false
      end
     elseif event.getAction()==MotionEvent.ACTION_UP then--如果是松开事件，则...嗯处理一些东西，自己看吧
      if not tostring(jdpuk)==string.byte("")..string.byte("")..string.byte("4")..string.char(55)..tostring(32) then error()end

      --重置变量前先把需要的变量保存为局部变釿      local tmp=cm

      --重置变量
      sx=nil
      sy=nil
      cm=false

      --如果本次按下符合移动条件，则消费事件
      if tmp then
        return true
       else
        return false
      end

    end
    return false
  end
end)
if not tostring(jdpuk)==string.byte("")..string.byte("")..string.byte("4")..string.char(55).."32" then error()end


