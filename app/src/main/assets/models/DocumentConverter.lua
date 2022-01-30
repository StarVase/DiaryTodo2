module(...,package.seeall)

local function convertDiary()
  require "StarVase"(this,{enableTheme=false})

  function dateConverter(str)
    str=tostring(str)
    if (utf8.len(str) == 8) then
      return {
        year=tointeger("20"..string.sub(str,1,2)),
        month=tointeger(string.sub(str,4,5)),
        day=tointeger(string.sub(str,7,8))
      }
     elseif (utf8.len(str) == 8) then
      return{
        year=tointeger(string.sub(str,1,4)),
        month=tointeger(string.sub(str,6,7)),
        day=tointeger(string.sub(str,9,10))
      }
     else
      import "android.icu.util.Calendar"
      calendar = Calendar.getInstance();
      year = calendar.get(Calendar.YEAR);
      month = calendar.get(Calendar.MONTH)+1;
      day = calendar.get(Calendar.DAY_OF_MONTH);
      return{year=year,month=month,day=day}
    end
  end

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
    path0=fileTable[i]
    name=File(tostring(path0)).getName()
    if string.checkString(tostring(name),".diary-") then
      fileContent=file.readFile(tostring(path0))
      if string.checkString(fileContent,"<docType=StarVase_diary>") then
        date=string.match(fileContent,'<date>(.-)</date>')
        check=string.match(fileContent,'<check>(.-)</check>')
        if string.checkString(fileContent,'<enc=true>') then
          enc=true else enc=false
        end
        content=string.match(fileContent,'<content>>(.-)<</content>')
        table.insert(data,{
          file_name=name,
          date=date,
          path=tostring(path0),
          enc=enc,
          content=content,
          check=check,
          PATH="/Android/data/"..activity.getPackageName().."/data/.diary/",})
        CreateFileUtil.diary({
          title=date,
          content=content,
          date=dateConverter(date),
        })

        path0.delete()
      end
    end
  end
  return (data)
end
local function convertInspiration()
  require "StarVase"(this,{enableTheme=false})

  data={}
  require "import"
  import("java.io.File")
  import "com.StarVase.utils.file"
  import "com.StarVase.utils.string"
  path="/Android/data/"..activity.getPackageName().."/data/.bulb/"
  xpcall(function()
    fileTable=((luajava.astable(File(Environment.getExternalStorageDirectory().toString()..path).listFiles())))
  end,function() fileTable={} end)

  for i = 1,#fileTable do
    path0=fileTable[i]
    name=File(tostring(path0)).getName()
    if string.checkString(tostring(name),".bulb-") then
      fileContent=file.readFile(tostring(path0))
      title=string.match(fileContent,'<title>>(.-)<</title>')
      content=string.match(fileContent,'<content>>(.-)<</content>')
      ts=string.match(fileContent,'<ts>>(.-)<</ts>')
      table.insert(data,{
        file_name=name,
        title=title,
        path=tostring(path0),
        content=content,
        timestamp=ts,
        PATH="/Android/data/"..activity.getPackageName().."/data/.bulb/"
      })
      CreateFileUtil.inspiration({
        title=title,
        timestamp=ts,
        content=content
      })

      path0.delete()
    end
  end
  return data
end

local function convertCollection()
  require "StarVase"(this,{enableTheme=false})

  require "import"
  import "com.StarVase.utils.file"
  import "com.StarVase.utils.string"
  data={}
  import("java.io.File")
  path="/Android/data/"..activity.getPackageName().."/data/.favorite/"
  xpcall(function()
    fileTable=((luajava.astable(File(Environment.getExternalStorageDirectory().toString()..path).listFiles())))
  end,function() fileTable={} end)

  for i = 1,#fileTable do
    path0=fileTable[i]
    name=File(tostring(path0)).getName()
    if string.checkString(tostring(name),".favorite-") then
      fileContent=file.readFile(tostring(path0))
      title=string.match(fileContent,'<title>>(.-)<</title>')
      content=string.match(fileContent,'<content>>(.-)<</content>')
      ts=string.match(fileContent,'<ts>>(.-)<</ts>')

      table.insert(data,{
        file_name=name,
        title=title,
        timestamp=ts,
        path=tostring(path0),
        content=content,
        PATH="/Android/data/"..activity.getPackageName().."/data/.favorite/"
      })
      CreateFileUtil.collection({
        title=title,
        timestamp=ts,
        content=content
      })

      path0.delete()
    end
  end
  return data
end


local function convertTodo()
  require "StarVase"(this,{enableTheme=false})

  require "import"
  cjson=require "cjson"
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
    path0=fileTable[i]
    name=File(tostring(path0)).getName()
    if string.checkString(tostring(name),".todo-") then
      fileContent=file.readFile(tostring(path0))
      if pcall(function() fc=cjson.decode(fileContent) end) then

        if fc.type=="StarVaseTODO" then

          table.insert(data,{
            path=fc.path,
            title=fc.title,
            istrue=fc.istrue,
            highLight=fc.highLight,
            data=fc.data,
            ts=fc.ts,
          })
          CreateFileUtil.todo({
            title=fc.title,
            data=cjson.encode(fc.data),
            timestamp=fc.ts,
            isHighlight=fc.highLight,
            highlightColor=0
          })

          path0.delete()
        end
      end
    end
  end
  return data
end

function convert()
  if pcall(function()
      thread(convertDiary)
      thread(convertInspiration)
      thread(convertTodo)
      thread(convertCollection)
    end) then
    activity.setSharedData("DocumentConverted",true)
  end
end