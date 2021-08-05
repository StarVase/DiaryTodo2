filePath=...
cjson=import"cjson"
--fileContent=file.readFile(tostring(filePath))
function getTable(filePath)
  require "import"
  import "com.StarVase.utils.file"
  import "com.StarVase.utils.string"
  cjson=import"cjson"
  
  
  function BubbleSorthere(arr)
    len=table.maxn(arr)
    for i=1,len do
      for j=i+1,len do
        if arr[i].timestamp<arr[j].timestamp then
          arr[i],arr[j]=arr[j],arr[i]
        end
      end
    end
    return arr
  end

  if filePath then
    fileContent=file.readFile(tostring(filePath))
    if pcall(function()
        json=cjson.decode(fileContent)

      end) then
      json.data=BubbleSorthere(json.data)
      return json
    end
  end


end





function save_as_json(arr,path)
  local cjson=import"cjson"
  content=cjson.encode(arr)
  file.writeFile(tostring(path),content)
end