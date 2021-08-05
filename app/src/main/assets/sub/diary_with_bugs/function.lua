require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"

--import "muk"
--删掉“--”注释符号以使用中文函数



data={}
function getTable()
  require "import"
  import "com.StarVase.utils.file"
  import "com.StarVase.utils.string"
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
        year='20'..string.sub(date,1,2)
        month=string.sub(date,4,5)
        day=string.sub(date,7,8)
        check=string.match(fileContent,'<check>(.-)</check>')
        if string.checkString(fileContent,'<enc=true>') then
          enc=true else enc=false
        end
        content=string.match(fileContent,'<content>>(.-)<</content>')
        table.insert(data,{
          file_name=name,
          date={year=year,month=month,day=day},
          path=tostring(path),
          enc=enc,
          content=content,
          check=check,
          PATH="/Android/data/"..activity.getPackageName().."/data/.diary/",})

      end
    end
  end


  function BubbleSort(arr)
    len=table.maxn(arr)
    for i=1,len do
      for j=i+1,len do
        if tostring(arr[i].date.year..arr[i].date.month..arr[i].date.day)<tostring(arr[j].date.year..arr[j].date.month..arr[j].date.day) then
          arr[i],arr[j]=arr[j],arr[i]
        end
      end
    end
    return arr
  end

  data = BubbleSort(data)
  return (data)
end


function oneKeyDecodeDiary(key)
  data=getTable()
  for one=1,#data do
    enc=data[one].enc
    if enc == true then
      path=data[one].path
      editcon=data[one].content
      title=data[one].date.year.."."..data[one].date.month.."."..data[one].date.day
      addcon=minicrypto.decrypt(editcon,key)
      --print(addcon)
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
  data=getTable()
  for one=1,#data do
    enc=data[one].enc
    if enc == false then
      path=data[one].path
      editcon=data[one].content
      title=data[one].date.year.."."..data[one].date.month.."."..data[one].date.day
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