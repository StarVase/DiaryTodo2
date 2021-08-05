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
  print(oldname,newname,type)
  File(oldname).renameTo(File(newname))
  table.insert(dustbin,{oldname,newname,type})
end

