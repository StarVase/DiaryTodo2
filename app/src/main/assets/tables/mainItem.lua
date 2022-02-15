R=luajava.bindClass(activity.getPackageName()..".R")

AutoCheckPromission=function(func)
  if Build.VERSION.SDK_INT >= 30 then
    if Environment.isExternalStorageManager() then
      func()
     else
      MyToast("权限错误")
      import "android.content.Intent"
      import "android.provider.Settings"
      intent = Intent(Settings.ACTION_MANAGE_ALL_FILES_ACCESS_PERMISSION)
      this.startActivity(intent)
    end
   else
    func()
  end
end

return {
  {
    ["text"]=activity.getString(R.string.func_diary),
    ["img"]=R.drawable.ic_diary,
    ["onClick"]=function() sub('diaryX',nil,os.clock()) end,
  },
  {
    ["text"]=activity.getString(R.string.func_todo),
    ["img"]=R.drawable.ic_check,
    ["onClick"]=function() sub('todoX',nil,os.clock()) end,
  },
  --[[  {
    ["text"]=AdapLan( "任务","Task"),
    ["img"]=R.drawable.ic_task,
    ["onClick"]=function() sub('tasks',nil,os.clock()) end,
  },]]
  {
    ["text"]=activity.getString(R.string.func_inspiration),
    ["img"]=R.drawable.ic_lightbulb_outline,
    ["onClick"]=function() sub('inspirationX',nil,os.clock()) end,
  },
  {
    ["text"]=activity.getString(R.string.func_markdown),
    ["img"]=R.drawable.ic_language_markdown_outline,
    ["onClick"]=lambda->AutoCheckPromission(function() sub('markdownX',nil,os.clock()) end)
  },
  {
    ["text"]=activity.getString(R.string.func_one_article),
    ["img"]=R.drawable.ic_article,
    ["onClick"]=function() sub('oneArticle',nil,os.clock()) end,
  },
  {
    ["text"]=activity.getString(R.string.func_collection),
    ["img"]=R.drawable.ic_star,
    ["onClick"]=function() sub('collectionX',nil,os.clock()) end,
  },
  --[[{
    ["text"]=activity.getString(R.string.func_logcat),
    ["img"]=R.drawable.ic_android_debug_bridge,
    ["onClick"]=function() sub('logcat',nil,os.clock()) end,
  },]]

}