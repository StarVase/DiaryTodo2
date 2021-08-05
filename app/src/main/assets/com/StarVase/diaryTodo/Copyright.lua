APKVersionInfoUtils=luajava.bindClass("com.StarVase.diaryTodo.util.APKVersionInfoUtils")
TextViewCompat = luajava.bindClass("androidx.core.widget.TextViewCompat")
Author="StarVase"
AndroidVersion=Build.VERSION.RELEASE
DeviceModel=Build.MANUFACTURER.." "..Build.MODEL
SDKVersion=Build.VERSION.SDK
CPUArchitecture=Build.CPU_ABI
CPUModel=Build.HARDWARE
versionName=APKVersionInfoUtils.getVersionName(activity)
versionCode=APKVersionInfoUtils.getVersionCode(activity)

info=string.format("Version:%s(%s)\nCPU Architecture:%s(%s)"
  ,tostring(versionName)
  ,tostring(versionCode)
  ,tostring(CPUArchitecture)
  ,tostring(CPUModel))
  
Log.i("deviceInfo",info)




if (string.find(versionName,"Preview") or string.find(versionName,"Dev") or string.find(versionName,"Test")) then
  debugModeEnable=true
end

if (debugModeEnable) then
  copyrightText=TextView(activity)
  .setText(info)
  .setTextColor(textColor)
  --.setBackgroundColor(0xff000000)
  task(1,function()activity.getWindow().getDecorView().addView(copyrightText)end)
end