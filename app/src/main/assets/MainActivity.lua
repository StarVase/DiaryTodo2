require "import"
--[[
activity.newActivity("debug")
activity.finish()]]
--关闭activity自带标题栏，此字段优先级高于一切
import "android.view.Window"
activity.supportRequestWindowFeature(Window.FEATURE_NO_TITLE);
import "StarVase"
import "androidx.appcompat.app.*"
import "androidx.appcompat.view.*"
import "androidx.appcompat.widget.*"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "androidx.appcompat.widget.Toolbar"
import "com.google.android.material.button.MaterialButton"
import "com.google.android.material.appbar.CollapsingToolbarLayout"
import "com.google.android.material.appbar.SubtitleCollapsingToolbarLayout"
import "com.google.android.material.appbar.AppBarLayout"
import "androidx.coordinatorlayout.widget.CoordinatorLayout"
import "com.google.android.material.floatingactionbutton.FloatingActionButton"
import "androidx.core.widget.NestedScrollView"
import "com.google.android.material.card.MaterialCardView"
import "android.graphics.drawable.BitmapDrawable"
import "com.google.android.material.internal.FlowLayout"
--保存设置参数
bingimgo=activity.getSharedData("BingImage")
weathero=activity.getSharedData("WeatherTip")
themeo=activity.getSharedData("theme")
yiyanTypeo=activity.getSharedData("YiyanType")
yiyanEnabledo=activity.getSharedData("YiyanEnabled")

import "intentCallback"
import "mods"

import "layout"
import "MyToolbar"

--标题栏下头的布局(先入为主)
MyToolbar.setContentView(loadlayout(layout))

import "weather"
import "bing"

--禁用滑动返回
pcall(function()activity.setSwipeBackEnable(false);end)
width=activity.getWidth()

--顾名思义
沉浸状态栏()

--设置初始标题  尊重著作权！！
MyToolbar.setTitle("DiaryTodo")
MyToolbar.setSubtitle("Be a knight of your own glory and bravely pursue the red sun of your dreams")

--刷新一言
refreshYiyan()

--设置fab波纹颜色
MyToolbar.setFabRippleColor(0x577cbcff)
--设置fab
MyToolbar.setFabImageResource(R.drawable.ic_plus)--悬浮按钮图片
MyToolbar.setFabColor(mainColor)--悬浮按钮颜色
MyToolbar.setFabImageColor(titleColor)--设置悬浮按钮图标颜色
--标题栏背景
MyToolbar.setCollapsedToolbarBackgroundColor(0xffffffff)
--标题
MyToolbar.setTitle(activity.getString(R.string.app_name))--设置标题
MyToolbar.setCollapsedToolbarBackgroundColor(graph.修改颜色强度("fd",mainColor))
--展开时标题色
MyToolbar.setExpandedTitleColor(0xffffffff)
--折叠后标题色
MyToolbar.setCollapsedTitleColor(titleColor)



--没注释，不解释不抱怨
function fab.onClick()
  import "addgb"
  bt=AdapLan("新建","New")
  nr=AdapLan("内容","Content")
  qd=AdapLan("确定","OK")
  qx=AdapLan("取消","Cancel")
  gb=function(one)
    关闭对话框(an)

    if one==1 then
      addDiary()

    end
    if one ==2 then
      addtodo()
    end
    if one == 3 then
      addBulb()
    end
    if one == 4 then
      addFav()
    end
  end
  qdnr=function()
    关闭对话框(an)
  end


  import "com.google.android.material.bottomsheet.BottomSheetDialog"

  local dann=import "layouts.dialog_new_file"

  dl=BottomSheetDialog(activity)
  dl.setContentView(loadlayout(dann))
  an=dl.show()
  bottom = dl.findViewById(R.id.design_bottom_sheet);
  if (bottom != null) then
    bottom.setBackgroundResource(android.R.color.transparent)
    .setPadding(math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(32))
  end
  itemins={
    TextView,
    id="instext",
    layout_height="42dp",
    layout_width="fill",
    Gravity="center|left",
    TextColor=textColor,
  }
  adp=LuaAdapter(activity,itemins)
  inslist.setAdapter(adp)
  import "tables.add"
  for i =1,#addtable do
    adp.add{instext=addtable[i]}
  end
  inslist.onItemClick=function(a,b,c,one)
    if gb then
      gb(one)
    end
  end

  --新建对话框(bt,nr,text,qd,qx,qdnr,qxnr,gb)
end


fab.onLongClick=function()
  print("fab Kept Clicking.")
  return true
end


--标题栏监听器
appBarLayout.addOnOffsetChangedListener(AppBarLayout.OnOffsetChangedListener({

  onOffsetChanged=function(appBarLayout,verticalOffset)
    local collapsingToolbarLayoutHeight=collapsingToolbarLayout.getHeight()
    local toolBarHeight=toolBar.getHeight()
    local scale=-verticalOffset/(collapsingToolbarLayoutHeight-toolBarHeight)

    subImageView.alpha=scale*2.5
  end
}))



function onSyncButtonClick()
  print("开始同步")
end



--添加项目
import "tables.mainItem"
function addMainItem(text,img,func)
  mainGrid.addView(loadlayout({
    LinearLayout,
    orientation="vertical";
    layout_height="wrap";
    gravity="center";
    layout_width="fill";
    layoutTransition=LayoutTransition().enableTransitionType(LayoutTransition.CHANGING);

    paddingTop="8dp",
    paddingBottom="8dp",


    {
      MaterialCardView,
      layout_width='fill',
      Elevation=0;

      id="CardParent",
      --CardBackgroundColor=graph.修改颜色强度(5,mainColor),
      cardBackgroundColor=0,
      StrokeColor=lightForceColor,
      StrokeWidth=math.dp2int(2),
      radius=math.dp2int(16),
      {
        LinearLayout,
        id="itemlayout";
        layout_width='fill',
        paddingTop="6dp",
        --backgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{淡色强调波纹}));

        paddingBottom="6dp",
        layout_height='fill',
        focusable="true";
        gravity="center|left";
        {
          LinearLayout,
          layout_width='fill',
          layout_height='fill',
          id="card",
          orientation="horizontal";
          gravity="center|left";
          onClick=mainItem[func].onClick,
          {
            ImageView;
            layout_height="30dp";
            layout_width="30dp";
            layout_margin="16dp";
            ImageResource=img;
            id="img",
            colorFilter=icon,
          };
          {
            TextView;
            textColor=textColor;
            paddingLeft="28dp",
            layout_weight="1";
            Text=text,
            id="text";
          };

        };
      },
    },
  }))
  graph.Ripple(card,淡色强调波纹)
  --动画！
  import "android.view.animation.*"
  Translate_up_down=TranslateAnimation(mainGrid.getWidth(), 0, 0, 0)
  Translate_up_down.setDuration(500)
  Translate_up_down.setFillAfter(true)

  import "android.view.animation.Animation$AnimationListener"


  Alpha=AlphaAnimation(0,1)
  Alpha.setDuration(800)
  CardParent.startAnimation(Alpha)
  Translate_up_down.setAnimationListener(AnimationListener{
    onAnimationStart=function()
      CardParent.startAnimation(Alpha)
    end,
    onAnimationEnd=function()
    end,
    onAnimationRepeat=function()
    end})

end

--用线程加载，免得卡
thread(function()
  require "import"
  import "com.StarVase.utils.language"
  import "tables.mainItem"
  for i=1,#mainItem do
    text=mainItem[i].text
    img=mainItem[i].img
    func=i
    call("addMainItem",text,img,func)
  end

end)



--创建菜单
function onCreateOptionsMenu(menu)
  local inflater=activity.getMenuInflater()
  inflater.inflate(R.menu.menu_main,menu)

end

--菜单点击
function onOptionsItemSelected(item)
  local id=item.getItemId()
  switch id
   case
    android.R.id.home
    activity.finish()
   case
    R.id.menu_main_settings
    sub("settings")
   case
    R.id.menu_main_about
    sub("about")
   case
    R.id.menu_main_exit
    activity.finish()
    import "android.os.Process"
    Process.killProcess(Process.myPid());
    System.exit(0);
  end
end




--返回程序
function onResume()
  if bingimgo!=activity.getSharedData("BingImage")
    or weathero!=activity.getSharedData("WeatherTip")
    or themeo!=AppTheme.getid()
    then
    --重构activity
    activity.recreate()
    --修完背景建议使用activity.recreate()
   elseif yiyanTypeo!=activity.getSharedData("YiyanType")
    or yiyanEnabledo!=activity.getSharedData("YiyanEnabled")
    then
    --重置一言
    yiyanTypeo=activity.getSharedData("YiyanType")
    yiyanEnabledo=activity.getSharedData("YiyanEnabled")
    refreshYiyan()
  end
  --用线程备份
  thread(function()
    if activity.getSharedData("AutoBackup")=="true" or activity.getSharedData("自动备份")==true then
      require "import"
      import "com.StarVase.app.backup"
      backup.backupnow()
    end
  end)
end

MyToolbar.setCollapsedOnClick(function()
  import "com.google.android.material.bottomsheet.BottomSheetDialog"
  sentences=dump2table(activity.getSharedData("thisYiyan"))
  bsd=BottomSheetDialog(this)

  .setContentView(loadlayout(import "layouts.dialog_yiyan"))
  .show()
  -- .getWindow().setBackgroundDrawable(BitmapDrawable(graph.高斯模糊(nil,graph.getScreenshot(activity.getWindow().getDecorView()),8,4)))
  content.setText("\t\t\t\t"..sentences.sentence)
  source.setText("————"..sentences.from)
  bottom = bsd.findViewById(R.id.design_bottom_sheet);
  if (bottom != null) then
    bottom.setBackgroundResource(android.R.color.transparent)
    .setPadding(math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(32))
  end


  return true
end)

imageFrame.onClick=function()
  if MainImageType=="Bing" then
    info=dump2table(activity.getSharedData("bingImgInfo"))

    --print(MainImageType)
    import"com.StarVase.view.MaterialButton.TextButton"
    import "com.google.android.material.bottomsheet.BottomSheetDialog"
    bitmap=mainImageView.getDrawable().getBitmap()
    bsd=BottomSheetDialog(this)

    .setContentView(loadlayout(import "layouts.dialog_bing_image"))
    .show()
    -- .getWindow().setBackgroundDrawable(BitmapDrawable(graph.高斯模糊(nil,graph.getScreenshot(mainLay),8,4)))
    dialog_detail_text.setText(info.detail)
    dialog_image.setImageBitmap(bitmap)
    dialog_download.onClick=function()
      file.download(info.uri,path.picture,"Bing_Dtd_"..os.date())
    end

  end
end
