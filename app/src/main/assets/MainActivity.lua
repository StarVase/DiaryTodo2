require "import"
import "com.bumptech.glide.*"
import "android.view.Window"
--保存设置参数
bingimgo=activity.getSharedData("BingImage")
weathero=activity.getSharedData("WeatherTip")
themeo=activity.getSharedData("theme")
yiyanTypeo=activity.getSharedData("YiyanType")
yiyanEnabledo=activity.getSharedData("YiyanEnabled")

--设置基础路径，不设置会有想不到的后果
activity.setSharedData("BaseLuaPath",activity.getLuaDir())

--优先关闭自带标题栏
activity.supportRequestWindowFeature(Window.FEATURE_NO_TITLE);


  
require "StarVase"(this,{enableTheme=true})
import "com.StarVase.diaryTodo.CreateFileUtil"
import "android.widget.ExListView"
import "androidx.swiperefreshlayout.widget.SwipeRefreshLayout"
import "android.graphics.ColorFilter"
import "android.content.res.ColorStateList"
import "com.google.android.material.textfield.TextInputEditText"
import "com.google.android.material.textfield.TextInputLayout"
import "com.StarVase.view.MaterialButton.TextButton"
import "com.google.android.material.button.MaterialButton"


import "intentCallback"
import "models.mods"
import "layouts.recycler_item"
import "layouts.layout"
import "models.MyToolbar"

--标题栏下头的布局(先入为主)
MyToolbar.setContentView(loadlayout(layout))

import "models.weather"
import "models.bing"

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
MyToolbar.setFabRippleColor(普通波纹)
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
--[[  end
})).start()]]

local adapter=require("adapters.main_recycler")
mainGrid.adapter=adapter

task(50,lambda ->adapter.submitList(import "tables.mainItem"))
function new()
  task(50,function()
    import "models.addgb"
    bt=AdapLan("新建","New")
    nr=AdapLan("内容","Content")
    qd=AdapLan("确定","OK")
    qx=AdapLan("取消","Cancel")
    gb=function(one)
      an.dismiss()

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
      an.dismiss()
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
      AppCompatTextView,
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
  end)
end

--没注释，不解释不抱怨
function fab.onClick()
  new()
  --新建对话框(bt,nr,text,qd,qx,qdnr,qxnr,gb)
end


fab.onLongClick=function()
  task(50,lambda -> print("fab Kept Clicking."))
  return true
end


--标题栏监听器
appBarLayout.addOnOffsetChangedListener(AppBarLayout.OnOffsetChangedListener({

  onOffsetChanged=function(appBarLayout,verticalOffset)
    Thread(Runnable({run=function()
        local collapsingToolbarLayoutHeight=collapsingToolbarLayout.getHeight()
        local toolBarHeight=toolBar.getHeight()
        local scale=-verticalOffset/(collapsingToolbarLayoutHeight-toolBarHeight)
        subAppCompatImageView.alpha=scale*2.5
      end})).start()
  end
}))



function onSyncButtonClick()
  print("开始同步")
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
    --call("addMainItem",text,img,func)
  end
end)
--end)


--创建菜单
function onCreateOptionsMenu(menu)
  local inflater=activity.getMenuInflater()
  inflater.inflate(R.menu.menu_main,menu)

end

--菜单点击
function onOptionsItemSelected(item)
  task(1,function()
    local id=item.getItemId()
    switch id
     case R.id.menu_main_new
      new()
     case
      android.R.id.home
      activity.finish()
     case
      R.id.menu_main_settings
      sub("settings")
     case
      R.id.menu_main_about
      sub("aboutX")
     case
      R.id.menu_main_exit
      activity.finish()
      import "android.os.Process"
      Process.killProcess(Process.myPid());
      System.exit(0);
    end
  end)
end

--点击标题栏一言
MyToolbar.setCollapsedOnClick(function()
  task(50,function()
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
  end)

  return true
end)

--点击图片
imageFrame.onClick=function()
  task(50,function()
    if MainImageType=="Bing" then
      info=dump2table(activity.getSharedData("bingImgInfo"))

      --print(MainImageType)
      import"com.StarVase.view.MaterialButton.TextButton"
      import "com.google.android.material.bottomsheet.BottomSheetDialog"
      bitmap=mainAppCompatImageView.getDrawable().getBitmap()
      bsd=BottomSheetDialog(this)

      .setContentView(loadlayout(import "layouts.dialog_bing_image"))
      .show()
      -- .getWindow().setBackgroundDrawable(BitmapDrawable(graph.高斯模糊(nil,graph.getScreenshot(mainLay),8,4)))
      dialog_detail_text.setText(info.detail)
      dialog_image.setImageBitmap(bitmap)
      dialog_download.onClick=function()
        file.download(info.uri,path.picture,"Bing_Dtd_"..os.date())
      end
      bottom = bsd.findViewById(R.id.design_bottom_sheet);
      if (bottom != null) then
        bottom.setBackgroundResource(android.R.color.transparent)
        --.setPadding(math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(32))
      end
    end
  end)
end



--返回程序
function onResume()
  task(50,function()
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
      if activity.getSharedData("AutoBackup") == true then
        require "import"
        import "com.StarVase.app.backup"
        backup.backupnow()
      end
    end)
  end)
end


local arg=0
function onKeyUp(code,event)
  if string.find(tostring(event),"KEYCODE_BACK") then
    if arg+2 > tonumber(os.time()) then
      activity.finish()
     else
      MyToast.showSnackBar("再按一次后退出")
      arg=tonumber(os.time())
    end
    return true
  end
end
MyToast.showSnackBar((activity.getLocation()))

--[[CreateFileUtil.createDatabase()
print(path.data .. "database/data.db")
print(CreateFileUtil.getDatabase())]]

import "android.database.sqlite.*"
--import "com.StarVase.app.path"
--打开数据库(没有自动创建)
function getDatabase()
  local path = import "com.StarVase.app.path"
  db = SQLiteDatabase.openOrCreateDatabase(path.app .. "data/database/data.db",MODE_PRIVATE, nil);
  return db
end
print(path.app .. "data/database/data.db")
print(path.data .. "database/data.db")
getDatabase()