module(...,package.seeall)

function writeFile(路径,内容)
  import "java.io.File"
  f=File(tostring(File(tostring(路径)).getParentFile())).mkdirs()
  io.open(tostring(路径),"w"):write(tostring(内容)):close()
end

function readFile(路径)
  文件内容=io.open(路径):read("*a")
  return 文件内容
end

function zip(from,to,name)
  pcall(ZipUtil.zip(from,to,name))
end

function rename(old,new)
  import "java.io.File"--导入File类
  File(old).renameTo(File(new))
end

function delete(oldname,newname,type)
  import "java.io.File"--导入File类
  File(oldname).renameTo(File(newname))
  table.insert(dustbin,{oldname,newname,type})
end

function download(url,path,name)
  import "android.content.Context"
  import "android.net.Uri"

  downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
  url=Uri.parse(url);
  request=DownloadManager.Request(url);
  request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
  request.setDestinationInExternalPublicDir(path,name);
  request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
  downloadManager.enqueue(request);
end