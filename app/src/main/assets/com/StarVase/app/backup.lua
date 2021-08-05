module(...,package.seeall)
import "com.StarVase.utils.file"
function backupnow()
  path=import "com.StarVase.app.path"
  ZipUtil.zip(tostring(path.data),tostring(path.backup))
  file.rename(path.backup.."data.zip",path.backup..tostring(os.date("%Y-%m-%d+%H:%M:%S"))..".dbk")
end

import "java.io.FileOutputStream"
import "java.util.zip.ZipFile"
import "java.io.File"


function unbackup(zippath)
  to=path.data
  ZipUtil.unzip(zippath,to)
end

function logzip(path,path2)
  import "values"
  ZipUtil.zip(tostring(path),tostring(path2))
  --file.rename(path.backup.."data.zip",path.backup..tostring(os.date("%Y-%m-%d+%H:%M:%S"))..".dbk")
end