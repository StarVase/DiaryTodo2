local ScreenFixUtil={}

local ScreenConfigDecoder={
  device=nil,
}
ScreenFixUtil.ScreenConfigDecoder=ScreenConfigDecoder
setmetatable(ScreenConfigDecoder,ScreenConfigDecoder)

--[[
{
  device={
    phone=function()
    pad=function()
    pc=function()
    }
  orientation={
    identical={LinearLayout...}
    different={LinearLayout...}
    }
  fillParent={View...}
  layoutManagers={LayoutManager...}
  singleViews={View...}
  }
]]
function ScreenConfigDecoder.__call(self,events)
  self=table.clone(self)
  self.events=events
  return self
end

local function setLayoutManagersSpanCount(layoutManagers,count)
  if layoutManagers then
    for index,content in ipairs(layoutManagers) do
      content.setSpanCount(count)
    end
  end
end

local function setLayoutsOrientation(lays,orientation)
  if lays then
    for index,content in ipairs(lays) do
      content.setOrientation(orientation)
    end
  end
end

local function setLayoutsSize(lays,height,width)
  if lays then
    for index,content in ipairs(lays) do
      local linearParams=content.getLayoutParams()
      linearParams.height=height
      linearParams.width=width
      content.setLayoutParams(linearParams)
    end
  end
end

function ScreenConfigDecoder.decodeConfiguration(self,config)
  local smallestScreenWidthDp=config.smallestScreenWidthDp
  local screenWidthDp=config.screenWidthDp

  local events=self.events
  local orientationLays=events.orientation
  local layoutManagers=events.layoutManagers
  local singleViews=events.singleViews
  local identicalLays,differentLays--同向，异向（屏幕方向）
  local device


  if orientationLays then
    identicalLays=orientationLays.identical
    differentLays=orientationLays.different
  end


  if smallestScreenWidthDp<theme.number.padDpi then--判断一下设备类型
    device="phone"
   elseif smallestScreenWidthDp<theme.number.pcDpi then
    device="pad"
   else
    device="pc"
  end

  if device~=self.device then--设备类型切换时
    self.device=device
    local deviceEvents=events.device
    if deviceEvents then
      local deviceEvent=deviceEvents[device]
      if deviceEvent then
        deviceEvent()
      end
    end
  end

  if config.orientation==Configuration.ORIENTATION_LANDSCAPE then--横屏时
    setLayoutsOrientation(identicalLays,LinearLayout.HORIZONTAL)
    setLayoutsOrientation(differentLays,LinearLayout.VERTICAL)
    setLayoutsSize(events.fillParent,-1,-2)
    if device=="phone" then
      setLayoutManagersSpanCount(layoutManagers,2)
     elseif device=="pad" then
      setLayoutManagersSpanCount(layoutManagers,4)
     elseif device=="pc" then
      setLayoutManagersSpanCount(layoutManagers,6)
    end
   else
    setLayoutsOrientation(identicalLays,LinearLayout.VERTICAL)
    setLayoutsOrientation(differentLays,LinearLayout.HORIZONTAL)
    setLayoutsSize(events.fillParent,-2,-1)
    if device=="phone" then
      setLayoutManagersSpanCount(layoutManagers,1)
     elseif device=="pad" then
      setLayoutManagersSpanCount(layoutManagers,2)
     elseif device=="pc" then
      setLayoutManagersSpanCount(layoutManagers,4)
    end
  end

  if singleViews then
    if screenWidthDp>596+32 then
      local maxWidth=math.dp2int(496)
      for index,content in ipairs(singleViews) do
        local linearParams=content.getLayoutParams()
        linearParams.width=maxWidth
        content.setLayoutParams(linearParams)
      end
     else
      for index,content in ipairs(singleViews) do
        local linearParams=content.getLayoutParams()
        linearParams.width=-1
        content.setLayoutParams(linearParams)
      end
    end
  end
  self.device=device
end

return ScreenFixUtil
