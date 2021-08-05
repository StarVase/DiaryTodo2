--[[cjson=import "cjson"
title="biaoti"
path="/Android/data/"..activity.getPackageName().."/data/.todo/"
name=".todo-"..title..os.time()
testtable={['highLight']=false,['title']=title,["data"]={},['type']="StarVaseTODO",["ts"]=os.time(),["path"]=path..name}
json=cjson.encode(testtable)
con=json
--file.writeFile(Environment.getExternalStorageDirectory().toString()..path..name,con)
]]
import 'cjson'
function getTable()
  require "import"
  import "com.StarVase.utils.file"
  import "com.StarVase.utils.string"
  import("java.io.File")
  path="/Android/data/"..activity.getPackageName().."/data/.todo/"
  xpcall(function()
    fileTable=((luajava.astable(File(Environment.getExternalStorageDirectory().toString()..path).listFiles())))
  end,function()
    fileTable={}
  end)



  data={}
  for i = 1,#fileTable do
    path=fileTable[i]
    name=File(tostring(path)).getName()
    if string.checkString(tostring(name),".todo-") then
      fileContent=file.readFile(tostring(path))
      if pcall(function() fc=cjson.decode(fileContent) end) then
        if fc.type=="StarVaseTODO" then
          table.insert(data,{
            path=fc.path,
            title=fc.title,
            istrue=fc.istrue,
            highLight=fc.highLight,
            ts=fc.ts,
          })

        end
      end
    end
  end

  function BubbleSort(arr)
    len=table.maxn(arr)
    for i=1,len do
      for j=i+1,len do
        if arr[i].ts<arr[j].ts then
          arr[i],arr[j]=arr[j],arr[i]
        end
      end
    end
    return arr
  end

  data = BubbleSort(data)

  return data
end