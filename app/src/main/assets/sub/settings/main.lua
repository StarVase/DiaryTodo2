require"import"
import "android.view.Window"
--优先关闭自带标题栏
activity.supportRequestWindowFeature(Window.FEATURE_NO_TITLE);

import "cjson"
require "StarVase"(this,{enableTheme=true})
TimingUtil.setName("Settings")
this.setTitle(activity.getString(R.string.func_settings))
import "android.widget.ExListView"
import "androidx.coordinatorlayout.widget.CoordinatorLayout"
import "androidx.appcompat.app.AlertDialog"

import "android.graphics.*"
import "android.graphics.drawable.GradientDrawable"
import "android.content.Context"
import "android.graphics.drawable.*"
import "MyToolbar"
MyAdapter=import "adapter.main"



ch_item_checked_background = GradientDrawable()
.setShape(GradientDrawable.RECTANGLE)
.setColor(淡色强调波纹)
.setCornerRadii({0,0,math.dp2px(24),math.dp2px(24),math.dp2px(24),math.dp2px(24),0,0});
import "layout.layout"


local main = nil
--标题栏下头的布局(先入为主)
MyToolbar.setContentView(loadlayout(layout))
upArrow = this.getDrawable(R.drawable.abc_ic_ab_back_material);
if(upArrow != nil) then
  upArrow.setColorFilter(titleColor, PorterDuff.Mode.SRC_ATOP);
  if(activity.getSupportActionBar() != nil) then
    activity.getSupportActionBar().setHomeAsUpIndicator(upArrow);
  end
end
activity.getSupportActionBar().setDisplayHomeAsUpEnabled(true)
--activity.getSupportActionBar().getNavigationIcon().setColorFilter(titleColor,PorterDuff.Mode.SRC_IN);
--展开时标题色
MyToolbar.setExpandedTitleColor(icon)
--MyToolbar.setExpandedToolbarBackgroundColor(BGC)

--折叠后标题色
MyToolbar.setCollapsedTitleColor(titleColor)
MyToolbar.setCollapsedToolbarBackgroundColor(mainColor)


function onOptionsItemSelected(item)
  local id=item.getItemId()
  if id==android.R.id.home then
    activity.finish()
  end
end


--activity.setSharedData("EncryptDiary",false)
--[[listView.setOnScrollListener{
  onScroll=lambda(l,s) -> nil
}]]



dataset = {}
--import "layout.setlay"

table.insert(dataset,{__type=1,title=AdapLan("界面","User Interface")})
table.insert(dataset,{__type=3,intent="ChooseTheme",img={ImageResource=R.drawable.ic_tshirt_crew_outline},subtitle=AdapLan("主题选择","Select themes")})
--adp.add{__type=3,intent="ResetFabPos",img={ImageResource=R.drawable.ic_circle},subtitle=AdapLan("重置悬浮球位置","Reset fab position")}
table.insert(dataset,{__type=1,title=AdapLan("编辑器","Editor")})
table.insert(dataset,{__type=2,intent="FontStyle",p={Focusable=false},img={ImageResource=R.drawable.ic_format_size},subtitle=AdapLan("字体","Font style"),message=tostring(activity.getSharedData("FontSize")or 16)})
table.insert(dataset,{__type=4,intent="FuncBarMargin",img={ImageResource=R.drawable.ic_format_vertical_align_bottom},subtitle=AdapLan("功能栏边距","Margin for function bar"),message=AdapLan("为工具栏设置边距，防止与全面屏手势冲突","Set margins for the function bar to prevent conflicts with full screen gestures"),status={Checked=Boolean.valueOf(this.getSharedData("FuncBarMargin"))}})

table.insert(dataset,{__type=1,title=AdapLan("密码","Password")})
table.insert(dataset,{__type=5,intent="EncryptDiary",p={Focusable=false},img={ImageResource=R.drawable.ic_lock_outline},subtitle=AdapLan("日记加密","Diary encryption"),status={Checked=Boolean.valueOf(this.getSharedData("EncryptDiary"))}})
pcall(function()
  import "android.hardware.fingerprint.FingerprintManager"
  fingerprintManager = activity.getContext().getSystemService(FingerprintManager);

  if (fingerprintManager.isHardwareDetected() && fingerprintManager.hasEnrolledFingerprints()) then
    table.insert(dataset,{__type=4,intent="EnableFingerprint",p={Focusable=false},img={ImageResource=R.drawable.ic_fingerprint},subtitle=AdapLan("使用指纹","Use fingerprint"),message=AdapLan('实验室功能',"Laboratory function"),status={Checked=Boolean.valueOf(this.getSharedData("EnableFingerprint"))}})

  end
end)
--adp.add{__type=2,intent="PasswordPro",p={Focusable=false},img={ImageResource=R.drawable.ic_lock_outline},subtitle=AdapLan("设置密保","Set password security"),message=AdapLan('可用密保找回密码',"The password can be recovered with security")}
table.insert(dataset,{__type=1,title=AdapLan("展示","Showing")})
table.insert(dataset,{__type=4,intent="BingImage",img={ImageResource=R.drawable.ic_microsoft_bing},subtitle=AdapLan("每日必应","Bing images"),message=AdapLan("从必应加载每日图片","Load daily pictures from Bing"),status={Checked=Boolean.valueOf(this.getSharedData("BingImage"))}})
table.insert(dataset,{__type=5,intent="WeatherTip",p={Focusable=false},img={ImageResource=R.drawable.ic_weather},subtitle=AdapLan("天气提示","Weather tips"),status={Checked=Boolean.valueOf(this.getSharedData("WeatherTip"))}})
table.insert(dataset,{__type=5,intent="GetFocused",p={Focusable=false},img={ImageResource=R.drawable.ic_image_filter_center_focus_weak},subtitle=AdapLan("首页聚焦","Get focused tips"),status={Checked=Boolean.valueOf(this.getSharedData("GetFocused"))}})

--table.insert(dataset,{__type=2,intent="WeatherCity",p={Focusable=false},img={ImageResource=R.drawable.ic_home_city_outline},subtitle=AdapLan("天气城市","Weather city"),message=tostring(activity.getSharedData("WeatherCity")or AdapLan("未指定","Unspecified"))})

table.insert(dataset,{__type=1,title=AdapLan("一言","Yiyan")})
table.insert(dataset,{__type=4,intent="YiyanEnabled",img={ImageResource=R.drawable.ic_comment_processing_outline},subtitle=AdapLan("显示一言","Show Yiyan"),message=AdapLan("在首页加载本地句子","Load local sentences at home page"),status={Checked=Boolean.valueOf(this.getSharedData("YiyanEnabled"))}})
table.insert(dataset,{__type=2,intent="YiyanType",p={Focusable=false},img={ImageResource=R.drawable.ic_format_list_bulleted_type},subtitle=AdapLan("一言类型","Yiyan Type"),message=yiyan.listYiyanType("name")[yiyan.listYiyanType("id")[activity.getSharedData("YiyanType") or "undefined"]]})

table.insert(dataset,{__type=1,title=AdapLan("应用","Application")})
table.insert(dataset,{__type=5,intent="AutoBackup",img={ImageResource=R.drawable.ic_backup},subtitle=AdapLan("自动备份","Auto backup"),status={Checked=Boolean.valueOf(this.getSharedData("AutoBackup"))}})
table.insert(dataset,{__type=2,intent="RecyclePeriod",p={Focusable=false},img={ImageResource=R.drawable.ic_recycle_variant},subtitle=AdapLan("回收周期","Recycle Period"),message=activity.getSharedData("RecyclePeriod")})
table.insert(dataset,{__type=3,intent="RecoveryBackup",img={ImageResource=R.drawable.ic_backup},subtitle=AdapLan("恢复备份","Restore backup")})
table.insert(dataset,{__type=3,intent="LogCat",img={ImageResource=R.drawable.ic_android_debug_bridge},subtitle=AdapLan("日志","LogCat")})
table.insert(dataset,{__type=3,intent="AboutApp",img={ImageResource=R.drawable.ic_information_outline},subtitle=AdapLan("关于应用","About")})
--print(dump(dataset))
adapter=MyAdapter(dataset)
recycler.setAdapter(adapter)
--task(50,lambda ->adapter.submitList(dataset))
adapter.notifyDataSetChanged()



import "settingFuncs"



function onResult(...)
  place,res=...
  if place=="sub/settings/setPSK" then
    if res =="true" then
      this.setSharedData("日记加密",true)
      dataset[map(dataset).EncryptDiary].status["Checked"]=true
      adp.notifyDataSetChanged()--更新列表
    end
  end
end

themeold=activity.getSharedData("theme")
encStateold=activity.getSharedData("EncryptDiary")
fontsizeold=activity.getSharedData("FontSize")
function onResume()
  task(1,function()
    if themeold!=activity.getSharedData("theme") then
      themeold=activity.getSharedData("theme")
      activity.recreate()
    end
    if encStateold != activity.getSharedData("EncryptDiary") then
      encStateold=activity.getSharedData("EncryptDiary")
      dataset[map(dataset).EncryptDiary].status["Checked"]=activity.getSharedData("EncryptDiary")
      adapter.notifyDataSetChanged()
    end
    if fontsizeold!=activity.getSharedData("FontSize") then
      fontsizeold=activity.getSharedData("FontSize")
      dataset[map(dataset).FontStyle].message=tostring(activity.getSharedData("FontSize") or 16)
      adapter.notifyDataSetChanged()
    end
  end)
end

