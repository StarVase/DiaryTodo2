basepath=String(Environment.getExternalStorageDirectory().toString().."/documents/markdownX/")


if recvdir then
  basepath=recvdir
  task(500,function()
    page.showPage(1)
  end)
end
--print(basepath)
File(basepath).mkdirs()

local datas={}--空data适配器的data
local fileList

function appliedToSwipeRefreshLayout(view)
  view.setProgressBackgroundColorSchemeColor(BGC)
  view.setColorSchemeColors(int{icon})
  return view
end

function listFile(nowPath)
  fileList=File(nowPath).listFiles()--获取文件列表
  if fileList then
    fileList=luajava.astable(fileList)--转换为LuaTable
   else
    fileList={}
  end
  table.sort(fileList,function(a,b)
    return string.upper(a.getName())<string.upper(b.getName())
  end)

  return fileList
end

function isSupportedFile(filename)
  extensionName=file.getExtensionName(tostring(filename))
  supportedExtensionName=[[
  |md|mdx|sh|txt|html|htm|lrc|log|
  ]]
  if (supportedExtensionName:find("|"..extensionName.."|"))then
    return true
   else
    return false
  end
end


function getFileInfo(file)
  import "com.StarVase.diaryTodo.util.FileSizeFormatter"
  size=FileSizeFormatter.format(tointeger(file.length()))
  lastModified=math.ts2t(file.lastModified()/1000)
  return size.."\t|\t"..lastModified
end
function listFile(strpath)
  pcall(function() fileList=luajava.astable(File(strpath).listFiles())end)--获取文件列表
  if (!fileList) then
    fileList={}
  end
  table.sort(fileList,function(a,b)
    return string.upper(a.getName())<string.upper(b.getName())
  end)

  return fileList
end

function openFile(filepath)
  sql="select * from markdown WHERE path=? ORDER BY id DESC"
  cursor=CreateFileUtil.raw(sql,{tostring(filepath)})
  if cursor.moveToFirst() then
    id=cursor.getInt(0)
    values = ContentValues();
    values.put("path",filepath);
    values.put("timestamp", tostring(os.time()));
    CreateFileUtil.getDatabase().update("markdown", values, "id=?", {tostring(id)});
   else
    CreateFileUtil.markdownToDb({path=filepath})
  end
  subed("notepad","markdownX",File(filepath).getName(),{
    path=filepath
  })
end

function refresh(argpath)
  sr2.setRefreshing(true);
  loading2.setVisibility(View.VISIBLE)
  nodata2.setVisibility(View.GONE)

  fileList=listFile(argpath)

  adp2.clear()
  dir={}
  files={}
  --添加数据
  for key,value in ipairs(fileList) do
    if value.isDirectory() then
      local name=value.getName()
      table.insert(dir,{n=name,p=value})
     elseif value.isFile() then
      local name=value.getName()
      table.insert(files,{n=name,p=value})
    end
  end
  if #luajava.astable(String(argpath).split("/")) > 4 then
    adp2.add({__type=3,text=".../",path=File(argpath).getParentFile(),type="back"})
    filetag.setVisibility(View.VISIBLE)
   elseif #luajava.astable(String(argpath).split("/")) < 4 then
    adp2.add({__type=4,text="---",path=Environment.getExternalStorageDirectory(),type="dir"})
    filetag.setVisibility(View.GONE)
   else
    filetag.setVisibility(View.GONE)
  end
  for k,v in ipairs(dir) do
    adp2.add({__type=1,text=v.n,path=v.p,type="dir"})
  end
  for k,v in ipairs(files) do
    adp2.add({__type=2,text=v.n,path=v.p,sub=getFileInfo(v.p),type="file"})
  end
  if #data2 == 0 then
    nodata2.setVisibility(View.VISIBLE)

  end
  loading2.setVisibility(View.GONE)
  sr2.setRefreshing(false);
  filetag.setPath(argpath)
end

function recent()
  nodata1.setVisibility(View.GONE)

  adp1.clear()
  sql="select * from markdown"
  --raw(sql,nil)
  if pcall(function() cursor=CreateFileUtil.raw(sql,nil)end) then
    while (cursor.moveToNext()) do

      id = cursor.getInt(0); --获取第一列的值,第一列的索引从0开始
      filepath = cursor.getString(1);--获取第二列的值
      adp1.add(
      {
        __type=2,
        text={
          Text=File(filepath).getName(),
        },
        sub={
          Text=filepath,
        },
        id=id,
      })
    end
    cursor.close()
    if #data1 == 0 then
      nodata1.setVisibility(View.VISIBLE)

    end
  end
  loading1.setVisibility(View.GONE)
  sr1.setRefreshing(false);
end


function delete(id)
  db.delete("markdown", "id=?", {tostring(id)});
  recent()
end

task(100,lambda->refresh(basepath))