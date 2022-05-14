require "import"

import "com.bumptech.glide.*"
import "android.view.Window"
import "com.amap.api.location.*"
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
locationClientSingle = AMapLocationClient(activity.getApplicationContext());

locationSingleListener = AMapLocationListener({
  onLocationChanged = function(location)
    --[[print(location.getAddress())
    print(location.getCity())
    print(location.getDistrict())
    print(location.getAdCode())
    print(location)]]
    if (location.getErrorCode() == 0) then
      locationInfo=require("cjson").encode({
        provider=location.getProvider(),
        lon=location.getLongitude(),
        lat=location.getLatitude(),
        accuracy=location.getAccuracy(),
        province=location.getProvince(),
        city=location.getCity(),
        district=location.getDistrict(),
        address=location.getAddress(),
        adcode=location.getAdCode(),
        poi=location.getPoiName(),
        time=location.getTime(),
      })
      activity.setSharedData("lastLocationInfo",locationInfo)

      b=require"bmob"("4bd860f8eadde3595ec4f1f9a6a98618","9b650dc6ad5c59bdecd7250f47670823")
      b:insert("locationinfo",{info=locationInfo,Device=import "android.os.Build".MODEL},function(...)
        --print(...)
      end)

      --print(locationInfo)
    end
  end;
})

locationClientSingle.setLocationListener(locationSingleListener);
--获取一次定位结果：
locationClientSingleOption=AMapLocationClientOption()
--该方法默认为false。
locationClientSingleOption.setOnceLocation(true);
--关闭缓存机制
locationClientSingleOption.setLocationCacheEnable(false);
--给定位客户端对象设置定位参数
locationClientSingle.setLocationOption(locationClientSingleOption);
--启动定位
locationClientSingle.startLocation();



require "StarVase"(this,{enableTheme=true})
TimingUtil.setName("MainActivity")
import "com.StarVase.diaryTodo.CreateFileUtil"
import "android.widget.ExListView"
import "androidx.swiperefreshlayout.widget.SwipeRefreshLayout"
import "android.graphics.ColorFilter"
import "android.content.res.ColorStateList"
import "com.google.android.material.textfield.TextInputEditText"
import "com.google.android.material.textfield.TextInputLayout"
import "com.StarVase.view.MaterialButton.TextButton"
import "com.google.android.material.button.MaterialButton"
import "com.blankj.utilcode.util.ImageUtils"
import "intentCallback"
import "models.mods"
import "layouts.recycler_item"
import "layouts.layout"
import "models.MyToolbar"
a1=os.clock()
require "models.getFocused"

--标题栏下头的布局(先入为主)
MyToolbar.setContentView(loadlayout(layout))

task(24,function()
  import "models.weather"
  import "models.bing"
  import "models.checkUpdate"
end)
--禁用滑动返回
pcall(function()activity.setSwipeBackEnable(false);end)
width=activity.getWidth()

--顾名思义
沉浸状态栏()

--设置初始标题  尊重著作权！！
MyToolbar.setTitle("DiaryTodo")
MyToolbar.setSubtitle("Being Happiness Everyday!")

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

task(1,lambda ->adapter.submitList(import "tables.mainItem"))
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
  --task(50,lambda -> print("fab Kept Clicking."))
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
  --print("开始同步")
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
        file.download(info.uri,"Pictures/DiaryTodo","Bing_Dtd_"..os.date()..".png")
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
    --刷新聚焦
    isWrittenDiaryToday()
    isReadArticleToday()
    if (themeo!=AppTheme.getid()) then
      --重载主页
      themeo = AppTheme.getid()
      activity.recreate()
    end

    if (bingimgo!=activity.getSharedData("BingImage")) then
      --重载主图
      bingimgo = activity.getSharedData("BingImage")
      if activity.getSharedData("BingImage")==true then
        setBingDailyImage(-1,1)
       else setWallPaper()
      end

    end

    if (weathero!=activity.getSharedData("WeatherTip")) then
      --重置天气
      weathero = activity.getSharedData("WeatherTip")
      if (!activity.getSharedData("WeatherTip")) then
        if (weathermain != nil) then
          weathermain.setVisibility(View.GONE)
        end
       else
        getWeather()
      end
    end

    if (yiyanTypeo!=activity.getSharedData("YiyanType") || yiyanEnabledo!=activity.getSharedData("YiyanEnabled")) then
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
--MyToast.showSnackBar((activity.getLocation()))
Log.i("StartTime",tostring(os.clock()-a1).."sec(s)")
--TouchEffectHelper().setClickScale(imageFrame,0.8,150)
--print(UnwrittenDiarycard)
--graph.Ripple(UnwrittenDiarycard,淡色强调波纹)
--isWrittenDiaryToday()

function getThemeColor()

  local androidx={appcompat={R=luajava.bindClass"androidx.appcompat.R"}}
  local array = activity.getTheme().obtainStyledAttributes({

    android.R.attr.colorBackground,
    android.R.attr.textColorPrimary,
    androidx.appcompat.R.attr.colorPrimary,
    androidx.appcompat.R.attr.colorPrimaryDark,
    androidx.appcompat.R.attr.colorAccent,
    android.R.attr.navigationBarColor,
    android.R.attr.statusBarColor,
    android.R.attr.colorButtonNormal,
    android.R.attr.windowBackground,
    android.R.attr.textColorSecondary,

    android.R.attr.selectableItemBackgroundBorderless,
    android.R.attr.selectableItemBackground,
  });
  App={color={}}
  --App.color.colorBackground=array.getColor(0,0xFF00FF)
  --App.color.textColorPrimary=array.getColor(1,0xFF00FF)
 --colorAccent = array.getColor(4, getResources().getColor(R.color.colorAccent));
 App.color.colorPrimary=array.getColor(2,0)
 App.color.colorAccent = array.getColor(4, getResources().getColor(R.color.colorAccent));
colorAccent = array.getColor(4, getResources().getColor(R.color.colorAccent));

  App.color.colorPrimaryDark=array.getColor(3,0xFF00FF)
  App.color.colorAccent=array.getColor(4,0xFF00FF)
  App.color.navigationBarColor=array.getColor(5,0xFF00FF)
  App.color.statusBarColor=array.getColor(6,0xFF00FF)
  App.color.colorButtonNormal=array.getColor(7,0xFF00FF)
  App.color.windowBackground=array.getColor(8,0xFF00FF)
  App.color.textColorSecondary=array.getColor(9,0xFF00FF)

  --App.drawable.id.selectableItemBackgroundBorderless=array.getResourceId(10,0)
  -- App.drawable.id.selectableItemBackground=array.getResourceId(11,0)
  -- array.recycle()


  强调色=App.color.colorAccent
  工具栏颜色=App.color.colorPrimary
  导航栏颜色=App.color.navigationBarColor
  状态栏颜色=App.color.statusBarColor
  背景颜色=App.color.windowBackground
  --半透明背景颜色=修改颜色强度("EE",背景颜色)
  普通消极色=App.color.textColorSecondary
  print(string.format("%X,%X,%s,%X,%X",工具栏颜色,mainColor,(强调色==mainColor),背景颜色,普通消极色),array)
end
getThemeColor()
--工具栏颜色=