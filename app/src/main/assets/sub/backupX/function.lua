require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"

--import "muk"
--删掉“--”注释符号以使用中文函数






function getTable()

  function BubbleSort(arr)
    len=table.maxn(arr)
    for i=1,len do
      for j=i+1,len do
        if arr[i].file_name<arr[j].file_name then
          arr[i],arr[j]=arr[j],arr[i]
        end
      end
    end
    return arr
  end

  data={}
  import("java.io.File")
  import "com.StarVase.app.path"

  import "com.StarVase.utils.string"
  xpcall(function()
    fileTable=((luajava.astable(File(tostring(path.backup)).listFiles())))
  end,function() fileTable={} end)
  --print(dump(fileTable))
  if fileTable[1] then
    for i = 1,#fileTable do
      path=fileTable[i]
      name=File(tostring(path)).getName()
      if string.checkString(tostring(name),".dbk") then
print(true)
        table.insert(data,{
          file_name=name,
          title=name,
          path=tostring(path),
        })
      end
    end
  end
  data = BubbleSort(data)
  -- print(dump(data))
  return data
end


function Refresh()
  task(getTable,nil,function(key)
    adapter.clear()
    tab=getTable()
    loading.setVisibility(View.GONE)
    for i = 1,#tab do
      date=tab[i].title
      filename=tab[i].file_name
      adapter.add({title=date})
    end
  end)
end