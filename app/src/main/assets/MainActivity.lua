require "import"
a1=os.clock()
import "com.bumptech.glide.*"
import "android.view.Window"
import "android.widget.ExListView"
import "androidx.swiperefreshlayout.widget.SwipeRefreshLayout"
import "android.graphics.ColorFilter"
import "android.content.res.ColorStateList"
import "com.google.android.material.textfield.TextInputEditText"
import "com.google.android.material.textfield.TextInputLayout"
import "com.StarVase.view.MaterialButton.TextButton"
import "com.google.android.material.button.MaterialButton"
import "com.blankj.utilcode.util.ImageUtils"

--保存设置参数
bingimgo=activity.getSharedData("BingImage")
weathero=activity.getSharedData("WeatherTip")
themeo=activity.getSharedData("theme")
yiyanTypeo=activity.getSharedData("YiyanType")
yiyanEnabledo=activity.getSharedData("YiyanEnabled")
focuso=activity.getSharedData("GetFocused")

--设置基础路径，不设置会有想不到的后果
activity.setSharedData("BaseLuaPath",activity.getLuaDir())


--优先关闭自带题栏
activity.supportRequestWindowFeature(Window.FEATURE_NO_TITLE);

--定位并保存位置信息
Thread(Runnable({
  run=function()
    require("models.locating").loop()
  end
}).run())

require "StarVase"(this,{enableTheme=true})

require "models.getFocused"
activity.runOnUiThread(luajava.createProxy("java.lang.Runnable", {
  run=function()
    import "com.StarVase.diaryTodo.CreateFileUtil"
    import "intentCallback"
    import "models.mods"
    import "layouts.recycler_item"
    import "layouts.layout"
    import "models.MyToolbar"



    if (AppTheme.isDarkTheme()) then
      imageShade.setVisibility(View.VISIBLE)
    end


    --标题栏下头的布局(先入为主)
    MyToolbar.setContentView(loadlayout(layout))



    import "models.weather"
    import "models.bing"
    import "models.checkUpdate"


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
    local adapter=require("adapters.main_recycler")
    mainGrid.adapter=adapter

    adapter.submitList(import "tables.mainItem")
  end
}))


function new()
  --task(50,function()
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
  --end)
end

--没注释，不解释不抱怨
function fab.onClick()
  new()
end


--标题栏监听器
appBarLayout.addOnOffsetChangedListener(AppBarLayout.OnOffsetChangedListener({

  onOffsetChanged=function(appBarLayout,verticalOffset)
    activity.runOnUiThread(Runnable({run=function()
        local collapsingToolbarLayoutHeight=collapsingToolbarLayout.getHeight()
        local toolBarHeight=toolBar.getHeight()
        local scale=-verticalOffset/(collapsingToolbarLayoutHeight-toolBarHeight)
        subAppCompatImageView.alpha=scale*2.5

      end}))
  end
}))

--创建菜单
function onCreateOptionsMenu(menu)
  local inflater=activity.getMenuInflater()
  inflater.inflate(R.menu.menu_main,menu)

end

--菜单点击
function onOptionsItemSelected(item)
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

end

--点击标题栏一言
MyToolbar.setCollapsedOnClick(function()

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


  return true
end)


--点击图片
imageFrame.onClick=function()
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
      dest=File(path.picture.."Bing/Bing_Dtd_"..os.time()..".jpg")
      dest.getParentFile().mkdirs()
      dest.createNewFile()
      thread(function(Glide,context,uri,dest)

        function copyfile(source,destination)
          --print(destination)
          sourcefile = io.open(source, "r")

          destinationfile = io.open(destination, "w")
          --print(destination)
          destinationfile:write(sourcefile:read("*all"))
          sourcefile:close()
          destinationfile:close()
        end


        require "import"
        import( "android.os.Environment")
        import( "java.io.File")
        import "com.StarVase.app.path"
        import "java.nio.file.Files"
        --file.download(info.uri,import "android.os.Environment".DIRECTORY_PICTURES,"DiaryTodo/Bing/Bing_Dtd_"..os.date()..".jpg")
        recvImgFile = Glide.with(context)
        .load(uri)
        .downloadOnly(1920, 1080)
        .get();
        --print (recvImgFile.getPath())

        copyfile(recvImgFile.getPath(),dest.getPath(),dest)
      end, Glide,this.getContext(),info.uri,dest)
      bsd.dismiss()
      MyToast.showSnackBar(dest.getPath())

    end
    bottom = bsd.findViewById(R.id.design_bottom_sheet);
    if (bottom != null) then
      bottom.setBackgroundResource(android.R.color.transparent)
      --.setPadding(math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(32))
    end
  end

end

activity.newTask(function()
  local Bakdata={}
  require "import"
  import "android.os.Looper"
  --Looper.prepare()
  --Looper.loop()
  import "android.util.Log"
  import "java.lang.System"
  import "com.StarVase.app.backup"
  import("java.io.File")
  import "com.StarVase.app.path"
  import "com.StarVase.utils.string"

  xpcall(function()
    Bakdir=luajava.astable(File(tostring(path.backup)).listFiles())
  end,function() Bakdir={} end)

  if Bakdir[1] then
    for i = 1,#Bakdir do
      local path=Bakdir[i]
      local name=File(tostring(path)).getName()

      if (file.getExtensionName(tostring(name))=="dbk") then
        table.insert(Bakdata,{
          file_name=name,
          path=path,
        })
      end
    end
  end

  import "java.util.Calendar"
  import "java.util.Date"
  calendar=Calendar.getInstance()
  calendar.setTime(Date())

  switch activity.getSharedData("RecyclePeriod")

   case"3-day"
    calendar.add(Calendar.DAY_OF_MONTH,-3)
   case "7-day"
    calendar.add(Calendar.DAY_OF_MONTH,-7)
   case "1-month"
    calendar.add(Calendar.MONTH,-1)
   case "6-month"
    calendar.add(Calendar.MONTH,-6)
   case "1-year"
    calendar.add(Calendar.YEAR,-1)
   case "none"

  end
  year=calendar.get(Calendar.YEAR)
  yearstr=tostring(year)
  month=calendar.get(Calendar.MONTH)+1
  monthstr=tostring(month)
  if (#monthstr < 2) then
    monthstr="0"..monthstr
  end
  day=calendar.get(Calendar.DAY_OF_MONTH)
  daystr=tostring(day)
  if (#daystr < 2) then
    daystr="0"..daystr
  end
  boundaryDate=yearstr..monthstr..daystr

  for key,filestruct in ipairs(Bakdata) do
    -- print(tointeger(string.sub(tostring(filestruct.file_name),1,8)))
    scannedDate=tointeger(string.sub(filestruct.file_name,1,8)) or 2^31


    if (scannedDate<tointeger(boundaryDate)) then
      pcall(function() os.remove(tostring(filestruct.path)) end)
    end
  end
end
).execute()




--返回程序
function onResume()
  activity.runOnUiThread(luajava.createProxy("java.lang.Runnable", {
    run=function()
      --刷新聚焦
      if (activity.getSharedData("GetFocused")==false)&&(activity.getSharedData("WeatherTip")==false) then
        focuslabelpatent.setVisibility(View.GONE)

      end


      FOCUS()

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
    end
  }))
  --用线程备份
  thread(function()
    if activity.getSharedData("AutoBackup") == true then
      require "import"
      import "models.qkbackup"
      pcall(function()backupNow()end)

    end
  end)

end


local arg=0
function onKeyUp(code,event)
  if string.find(tostring(event),"KEYCODE_BACK") then
    if arg+2 > tonumber(os.time()) then
      activity.finish()
     else
      MyToast.showSnackBar(AdapLan("再按一次后退出","Press again to exit"))
      arg=tonumber(os.time())
    end
    return true
  end
end


Log.i("StartTime",tostring(os.clock()-a1).."sec(s)")
