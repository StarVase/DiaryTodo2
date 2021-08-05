require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"

--import "muk"
--删掉“--”注释符号以使用中文函数




function getTable()
  data={}
  import("java.io.File")
  import "com.StarVase.app.path"
  
  import "com.StarVase.utils.string"
  xpcall(function()
    fileTable=((luajava.astable(File(tostring(path.backup)).listFiles())))
  end,function() fileTable={} end)
  if fileTable[1] then
    for i = 1,#fileTable do
      path=fileTable[i]
      name=File(tostring(path)).getName()
      if string.checkString(tostring(name),".dbk") then
        table.insert(data,{
          file_name=name,
          title=name,
          path=tostring(path),
        })
      end
    end
  end
  -- print(dump(data))
  return data
end