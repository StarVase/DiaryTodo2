module(...,package.seeall)
function saveAsPng(bitmap,name)
  import "android.graphics.Bitmap"
  import "java.io.File"
  file.writeFile("/sdcard/Pictures/diaryTodo/"..name)
  local f=File("/sdcard/Pictures/diaryTodo/"..name)
  local path=BufferedOutputStream(FileOutputStream(f))
  bitmap.compress(Bitmap.CompressFormat.PNG,50,path)
end
