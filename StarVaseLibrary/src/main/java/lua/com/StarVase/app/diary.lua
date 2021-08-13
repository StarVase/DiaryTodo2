
data={}
function getTable22()
  data={}
  import("java.io.File")
  path="/Android/data/"..activity.getPackageName().."/data/.diary/"
  xpcall(function()
    fileTable=((luajava.astable(File(Environment.getExternalStorageDirectory().toString()..path).listFiles())))
  end,function() fileTable={} end)

  for i = 1,#fileTable do
    path=fileTable[i]
    name=File(tostring(path)).getName()
    if string.checkString(tostring(name),".diary-") then
      fileContent=file.readFile(tostring(path))
      if string.checkString(fileContent,"<docType=StarVase_diary>") then
        date=string.match(fileContent,'<date>(.-)</date>')
        if string.checkString(fileContent,'<enc=true>') then
          enc=true else enc=false
        end
        content=string.match(fileContent,'<content>>(.-)<</content>')
        table.insert(data,{
          file_name=name,
          date=date,
          path=tostring(path),
          enc=enc,
          content=content,
          PATH="/Android/data/"..activity.getPackageName().."/data/.diary/",})

      end
    end
  end


  function BubbleSortnn(arr)
    len=table.maxn(arr)
    for i=1,len do
      for j=i+1,len do
        if arr[i].date<arr[j].date then
          arr[i],arr[j]=arr[j],arr[i]
        end
      end
    end
    return arr
  end

  data = BubbleSortnn(data)
  return data
end



function oneKeyDecodeDiary(key)
  data=getTable22()
  for one=1,#data do
    enc=data[one].enc
    if enc == true then
      path=data[one].path
      editcon=data[one].content
      title=data[one].date
      addcon=minicrypto.decrypt(editcon,key)
      encstr="<enc=false>"


      con=[[<docType=StarVase_diary>
]]..encstr..[[<date>]]..title..[[</date>
<content>>]]..addcon..[[<</content>
]]
      -- print(con)
      file.writeFile(path,con)
    end
  end

end


function oneKeyEncodeDiary(key)
  data=getTable22()
  for one=1,#data do
    enc=data[one].enc
    if enc == false then
      path=data[one].path
      editcon=data[one].content
      title=data[one].date
      addcon=minicrypto.encrypt(editcon,key)
      encstr="<enc=true>"


      con=[[<docType=StarVase_diary>
]]..encstr..[[<date>]]..title..[[</date>
<content>>]]..addcon..[[<</content>
]]
      -- print(con)
      file.writeFile(path,con)
    end
  end

end