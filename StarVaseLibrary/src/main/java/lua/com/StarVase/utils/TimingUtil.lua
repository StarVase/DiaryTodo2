import "java.io.File"--导入File类
local TimingUtil={}
setmetatable(TimingUtil,TimingUtil)
local savePath="/sdcard/Download/Timing_"..activity.getPackageName().."/"
local record={}
local name=nil

function TimingUtil.setName(newName)
  name=newName
  return TimingUtil
end

function TimingUtil.recordFunctionStart(name)
  local functionRecordList=record[name]
  if functionRecordList==nil then
    functionRecordList={}
    record[name]=functionRecordList
  end
  table.insert(functionRecordList,{startTime=System.currentTimeMillis()/1000})
  return TimingUtil
end

function TimingUtil.recordFunctionEnd(name)
  local functionRecordList=record[name]
  local index=#functionRecordList
  functionRecordList[index]=System.currentTimeMillis()/1000-functionRecordList[index].startTime
  return TimingUtil
end

function TimingUtil.saveRecords()
  if name then
    File(savePath).mkdirs()
    io.open(savePath..name..".lua","a"):write(dump(record)):close()
  end
  return TimingUtil
end
return TimingUtil
