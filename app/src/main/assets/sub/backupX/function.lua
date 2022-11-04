require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"

--import "muk"
--删掉“--”注释符号以使用中文函数



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



function getTable()
  local data={}
  import("java.io.File")
  import "com.StarVase.app.path"
  import "com.StarVase.utils.string"

  xpcall(function()
    fileTable=luajava.astable(File(tostring(path.backup)).listFiles())
  end,function() fileTable={} return {} end)

  if fileTable[1] then
    for i = 1,#fileTable do
      path=fileTable[i]
      name=File(tostring(path)).getName()

      if (file.getExtensionName(tostring(name))=="dbk") then
        table.insert(data,{
          file_name=name,
          title=name,
          path=tostring(path),
        })
      end
    end
  end
  data = BubbleSort(data)
  return data
end


function Refresh()
  adapter.clear()
  tab=getTable()
  sr.setRefreshing(false);
  loading.setVisibility(View.GONE)
  for i = 1,#tab do
    date=tab[i].title
    filename=tab[i].file_name
    adapter.add({title=date,path=tab[i].path})
  end


end



import "net.lingala.zip4j.ZipFile";
import "net.lingala.zip4j.exception.ZipException";
import "net.lingala.zip4j.model.FileHeader";
import "net.lingala.zip4j.model.ZipParameters";
import "net.lingala.zip4j.util.InternalZipConstants";


--[[  /**
     * 在必要的情况下创建压缩文件存放目录,比如指定的存放路径并没有被创建
     * @param destParam 指定的存放路径,有可能该路径并没有被创建
     */]]
function createDestDirectoryIfNecessary(destParam)
  destDir = null
  destParam=String(destParam)
  if (destParam.endsWith(File.separator)) then
    destDir = File(destParam);
   else
    destDir = File(destParam.substring(0, destParam.lastIndexOf(File.separator)));
  end
  if (!destDir.exists()) then
    destDir.mkdirs();
  end
end


--[[/**
* 构建压缩文件存放路径,如果不存在将会创建
* 传入的可能是文件名或者目录,也可能不传,此方法用以转换最终压缩文件的存放路径
* @param srcFile 源文件
* @param destParam 压缩目标路径
* @return 正确的压缩文件存放路径
*/]]
function buildDestinationZipFilePath(srcFile, destParam)
  destParam=String(destParam)
  if (destParam==nil || destParam=="") then
    if (srcFile.isDirectory()) then
      destParam = srcFile.getParent() .. File.separator .. srcFile.getName() .. ".zip";
     else
      fileName = srcFile.getName().substring(0, srcFile.getName().lastIndexOf("."));
      destParam = srcFile.getParent() .. File.separator .. fileName .. ".zip";
    end
   else
    createDestDirectoryIfNecessary(destParam); --// 在指定路径不存在的情况下将其创建出来
    if (destParam.endsWith(File.separator)) then
      fileName = "";
      if (srcFile.isDirectory()) then
        fileName = srcFile.getName();
       else
        fileName = srcFile.getName().substring(0, srcFile.getName().lastIndexOf("."));
      end
      destParam = destParam .. fileName .. ".zip";
    end
  end
  return destParam;
end




--[[
    /**
     * 使用给定密码压缩指定文件或文件夹到指定位置.
     * <p>
     * dest可传最终压缩文件存放的绝对路径,也可以传存放目录,也可以传null或者"".<br />
     * 如果传null或者""则将压缩文件存放在当前目录,即跟源文件同目录,压缩文件名取源文件名,以.zip为后缀;<br />
     * 如果以路径分隔符(File.separator)结尾,则视为目录,压缩文件名取源文件名,以.zip为后缀,否则视为文件名.
     * @param src 要压缩的文件或文件夹路径
     * @param dest 压缩文件存放路径
     * @param isCreateDir 是否在压缩文件里创建目录,仅在压缩文件为目录时有效.<br />
     * 如果为false,将直接压缩目录下文件到压缩文件.
     * @param passwd 压缩使用的密码
     * @return 最终的压缩文件存放的绝对路径,如果为null则说明压缩失败.
     */

]]
function zip(src, dest, isCreateDir, passwd)
  srcFile = File(src);
  dest = buildDestinationZipFilePath(srcFile, dest);
  parameters = ZipParameters();
  --parameters.setCompressionMethod(InternalZipConstants.COMP_DEFLATE); --// 压缩方式
  --parameters.setCompressionLevel(InternalZipConstants.DEFLATE_LEVEL_NORMAL); --// 压缩级别

  -- pcall(function()
  zipFile = ZipFile(dest);
  if (srcFile.isDirectory()) then
    --// 如果不创建目录的话,将直接把给定目录下的文件压缩到压缩文件,即没有目录结构
    if (!isCreateDir) then
      subFiles = srcFile.listFiles();
      --[[print(dump(luajava.astable(subFiles)))
      --temp = luajava.createArray("java.io.File",{})
      temp = import "java.util.ArrayList"();
      Collections.addAll(temp, subFiles);
      zipFile.addFiles(temp, parameters);]]
      subFiles=luajava.astable(subFiles)
      for i = 1, #subFiles do
        if (subFiles[i].isDirectory()) then
          zipFile.addFolder(subFiles[i], parameters);
         else
          zipFile.addFile(subFiles[i], parameters);
        end
      end
      return dest;
    end
    zipFile.addFolder(srcFile, parameters);
   else
    zipFile.addFile(srcFile, parameters);
  end
  return dest;
  --end)
  --return null;
end


function backupNow()
  zip(tostring(PathUtil.data),tostring(PathUtil.backup)..tostring(os.date("%Y%m%d_%H%M%S"))..".dbk", false, nil)
end

function restoreBak(fpath)

  zipFile = ZipFile(fpath)
  -- zipFile.setCharset("GBK")
  if (!zipFile.isValidZipFile()) then
    MyToast.showSnackBar(AdapLan("无效的备份文件","Invaild backup file."))
    return
  end
  --
  fileDir = File(PathUtil.data)
  if (fileDir.isDirectory()) then
    fileDir.mkdirs()
  end
  zipFile.extractAll(fileDir.toString())
end

function deleteBak(fpath)
  
  pcall(function() os.remove(fpath) end)
end
