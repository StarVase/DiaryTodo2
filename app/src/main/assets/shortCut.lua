--import "StarVase"
import "android.net.Uri"


if Build.VERSION.SDK_INT >= 25 then


  import "android.content.ComponentName"
  import "android.content.Intent"
  import "android.content.pm.ShortcutInfo"
  import "java.util.ArrayList"
  import "android.graphics.drawable.Icon"


  --创建Intent对象
  diaryIntent = Intent(Intent.ACTION_MAIN);
  diaryIntent.setComponent(ComponentName(activity.getPackageName(),"com.StarVase.diaryTodo.app.MainActivity"));
  diaryIntent.setData(Uri.parse("diary"));

  todoIntent = Intent(Intent.ACTION_MAIN);
  todoIntent.setComponent(ComponentName(activity.getPackageName(),"com.StarVase.diaryTodo.app.MainActivity"));
  todoIntent.setData(Uri.parse("todo"));

  bulbIntent = Intent(Intent.ACTION_MAIN);
  bulbIntent.setComponent(ComponentName(activity.getPackageName(),"com.StarVase.diaryTodo.app.MainActivity"));
  bulbIntent.setData(Uri.parse("bulb"));

  artIntent = Intent(Intent.ACTION_MAIN);
  artIntent.setComponent(ComponentName(activity.getPackageName(),"com.StarVase.diaryTodo.app.MainActivity"));
  artIntent.setData(Uri.parse("art"));

  favIntent = Intent(Intent.ACTION_MAIN);
  favIntent.setComponent(ComponentName(activity.getPackageName(),"com.StarVase.diaryTodo.app.MainActivity"));
  favIntent.setData(Uri.parse("fav"));

  markdownIntent = Intent(Intent.ACTION_MAIN);
  markdownIntent.setComponent(ComponentName(activity.getPackageName(),"com.StarVase.diaryTodo.app.MainActivity"));
  markdownIntent.setData(Uri.parse("markdown"));


  SHORTCUT_TABLE={
    {"diary",activity.getString(R.string.func_diary),diaryIntent,R.drawable.ic_diary},
    {"todo",activity.getString(R.string.func_todo),todoIntent,R.drawable.ic_check},
    {"bulb",activity.getString(R.string.func_inspiration),bulbIntent,R.drawable.ic_lightbulb_outline},
    --{"Markdown",activity.getString(R.string.func_markdown),markdownIntent,R.drawable.ic_language_markdown_outline},
    {"oneArticle",activity.getString(R.string.func_one_article),artIntent,R.drawable.ic_article},
    {"favorite",activity.getString(R.string.func_collection),favIntent,R.drawable.ic_star},
  }

  scm = activity.getSystemService(activity.SHORTCUT_SERVICE);

  infos = ArrayList();
  for k,v in pairs(SHORTCUT_TABLE) do
    si = ShortcutInfo.Builder(this,v[1])
    --设置图标
    .setIcon(Icon.createWithResource(activity,v[4]))
    --快捷方式添加到桌面显示的标签文本
    .setShortLabel(v[2])
    --长按图标快捷方式显示的标签文本(既快捷方式名字)
    .setLongLabel(v[2])
    .setIntent(v[3])
    .build();
    infos.add(si);
  end

  --添加快捷方式
  scm.setDynamicShortcuts(infos);

end