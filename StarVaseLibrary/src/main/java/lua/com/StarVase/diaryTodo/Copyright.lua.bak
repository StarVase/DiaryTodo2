APKVersionInfoUtils=luajava.bindClass("com.StarVase.diaryTodo.util.APKVersionInfoUtils")
AppCompatTextViewCompat = luajava.bindClass("androidx.appcompat.widget.AppCompatTextView")
Author="StarVase"
AndroidVersion=Build.VERSION.RELEASE
DeviceModel=Build.MANUFACTURER.." "..Build.MODEL
SDKVersion=Build.VERSION.SDK
CPUArchitecture=Build.CPU_ABI
CPUArchitecture2=Build.CPU_ABI2
CPUModel=Build.HARDWARE
versionName=APKVersionInfoUtils.getVersionName(activity)
versionCode=APKVersionInfoUtils.getVersionCode(activity)

info=string.format("This version is for testing only.\nVersion:%s(%s)\nCPU Architecture:%s|%s(%s)\nSDK:%s"
  ,tostring(versionName)
  ,tostring(versionCode)
  ,tostring(CPUArchitecture)
  ,tostring(CPUArchitecture2)
  ,tostring(CPUModel)
  ,tostring(SDKVersion))
  
Log.i("deviceInfo",info)



if (string.find(versionName,"Preview") or string.find(versionName,"Dev") or string.find(versionName,"Test")) then
  debugModeEnable=true
end

if (debugModeEnable) then
  copyrightText=AppCompatTextView(activity)
  .setText(info)
  .setTextColor(textColor)
  .setGravity(Gravity.BOTTOM|Gravity.CENTER)
  --.setBackgroundColor(0xff000000)
  task(1,function()activity.getWindow().getDecorView().addView(copyrightText)end)
end