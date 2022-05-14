require "StarVase"(this,{enableTheme=true})
import "UiHelper"



--ChooseFile()


seekbar.progress=sp2progress(activity.getSharedData("FontSize") or 16)+1

path=activity.getSharedData("TTFPath")
if path then
  font=Typeface.createFromFile(File(path))
  demo.setTypeface(font)
  labelTtf.text="From TrueTypeface File:"..tostring(path)
end

pcall(function()
  if activity.getSharedData("TTFPath")&&File(activity.getSharedData("TTFPath")).isFile() then
    font=Typeface.createFromFile(File(activity.getSharedData("TTFPath")))
    Widgetcontent.setTypeface(font)
  end
end)



selectttf.onClick=function()
  if Build.VERSION.SDK_INT >= 30 then
    if Environment.isExternalStorageManager() then
      ChooseFile()
     else
      MyToast("权限错误")
      import "android.content.Intent"
      import "android.provider.Settings"
      intent = Intent(Settings.ACTION_MANAGE_ALL_FILES_ACCESS_PERMISSION)
      this.startActivity(intent)
    end
   else
    ChooseFile()
  end
end

resetButton.onClick=function()
  activity.setSharedData("FontSize",16)
  activity.setSharedData("TTFPath",nil)

  seekbar.progress=sp2progress(16)+1

  path=activity.getSharedData("TTFPath")
  if path then
    font=Typeface.createFromFile(File(path))
    demo.setTypeface(font)
    labelTtf.text="From TrueTypeface File:"..tostring(path)
  end
end

