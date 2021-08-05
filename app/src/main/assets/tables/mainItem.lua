R=luajava.bindClass(activity.getPackageName()..".R")
return {
  {
    ["text"]=activity.getString(R.string.func_diary),
    ["img"]=R.drawable.ic_diary,
    ["onClick"]=function() sub('diaryX',os.clock()) end,
  },
  {
    ["text"]=activity.getString(R.string.func_todo),
    ["img"]=R.drawable.ic_check,
    ["onClick"]=function() sub('TODO') end,
  },
--[[  {
    ["text"]=AdapLan( "任务","Task"),
    ["img"]=R.drawable.ic_task,
    ["onClick"]=function() sub('tasks',os.clock()) end,
  },]]
  {
    ["text"]=activity.getString(R.string.func_inspiration),
    ["img"]=R.drawable.ic_lightbulb_outline,
    ["onClick"]=function() sub('inspirationX',os.clock()) end,
  },
  {
    ["text"]=activity.getString(R.string.func_markdown),
    ["img"]=R.drawable.ic_language_markdown_outline,
    ["onClick"]=function() sub('favorite',os.clock())print(AdapLan("开发中","Developing.")) end,
  },
  {
    ["text"]=activity.getString(R.string.func_one_article),
    ["img"]=R.drawable.ic_article,
    ["onClick"]=function() sub('oneArticle') end,
  },
  {
    ["text"]=activity.getString(R.string.func_collection),
    ["img"]=R.drawable.ic_star,
    ["onClick"]=function() sub('collectionX',os.clock()) end,
  },
  {
    ["text"]=activity.getString(R.string.func_logcat),
    ["img"]=R.drawable.ic_android_debug_bridge,
    ["onClick"]=function() sub('logcat',os.clock()) end,
  },

}