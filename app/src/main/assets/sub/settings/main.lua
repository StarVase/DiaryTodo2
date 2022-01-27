require"import"
import "android.view.Window"
--优先关闭自带标题栏
activity.supportRequestWindowFeature(Window.FEATURE_NO_TITLE);

import "cjson"
require "StarVase"(this,{enableTheme=true})
this.setTitle(activity.getString(R.string.func_settings))
import "android.widget.ExListView"
import "androidx.coordinatorlayout.widget.CoordinatorLayout"

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
--adp.add{__type=1,title=AdapLan("编辑器","Editor")})
--adp.add{__type=2,intent="FontSize",p={Focusable=false},img={ImageResource=R.drawable.ic_format_size},subtitle=AdapLan("字体大小","Font Size"),message=tostring(activity.getSharedData("FontSize")or 14)}
table.insert(dataset,{__type=1,title=AdapLan("密码","Password")})
table.insert(dataset,{__type=5,intent="EncryptDiary",p={Focusable=false},img={ImageResource=R.drawable.ic_lock_outline},subtitle=AdapLan("日记加密","Diary encryption"),message=AdapLan('实验室功能',"Laboratory function"),status={Checked=Boolean.valueOf(this.getSharedData("EncryptDiary"))}})
--adp.add{__type=2,intent="PasswordPro",p={Focusable=false},img={ImageResource=R.drawable.ic_lock_outline},subtitle=AdapLan("设置密保","Set password security"),message=AdapLan('可用密保找回密码',"The password can be recovered with security")}
table.insert(dataset,{__type=1,title=AdapLan("展示","Showing")})
table.insert(dataset,{__type=4,intent="BingImage",img={ImageResource=R.drawable.ic_microsoft_bing},subtitle=AdapLan("每日必应","Bing images"),message=AdapLan("从必应加载每日图片","Load daily pictures from Bing"),status={Checked=Boolean.valueOf(this.getSharedData("BingImage"))}})
table.insert(dataset,{__type=5,intent="WeatherTip",p={Focusable=false},img={ImageResource=R.drawable.ic_weather},subtitle=AdapLan("天气提示","Weather tips"),status={Checked=Boolean.valueOf(this.getSharedData("WeatherTip"))}})
table.insert(dataset,{__type=1,title=AdapLan("一言","Yiyan")})
table.insert(dataset,{__type=4,intent="YiyanEnabled",img={ImageResource=R.drawable.ic_comment_processing_outline},subtitle=AdapLan("显示一言","Show Yiyan"),message=AdapLan("在首页加载本地句子","Load local sentences at home page"),status={Checked=Boolean.valueOf(this.getSharedData("YiyanEnabled"))}})
table.insert(dataset,{__type=2,intent="YiyanType",p={Focusable=false},img={ImageResource=R.drawable.ic_comment_processing_outline},subtitle=AdapLan("一言类型","Yiyan Type"),message=yiyan.listYiyanType("name")[yiyan.listYiyanType("id")[activity.getSharedData("YiyanType") or "undefined"]]})

table.insert(dataset,{__type=1,title=AdapLan("应用","Application")})
table.insert(dataset,{__type=5,intent="AutoBackup",img={ImageResource=R.drawable.ic_backup},subtitle=AdapLan("自动备份","Auto backup"),status={Checked=Boolean.valueOf(this.getSharedData("AutoBackup"))}})
table.insert(dataset,{__type=3,intent="RecoveryBackup",img={ImageResource=R.drawable.ic_backup},subtitle=AdapLan("恢复备份","Restore backup")})
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
      dataset[4].status["Checked"]=true
      adp.notifyDataSetChanged()--更新列表
    end
  end
end

themeold=activity.getSharedData("theme")
encStateold=activity.getSharedData("EncryptDiary")

function onResume()
  task(1,function()
    if themeold!=activity.getSharedData("theme") then
      --[[activity.newActivity("sub/settings/main", android.R.anim.fade_in, android.R.anim.fade_out)
    activity.finish()]]
      activity.recreate()
    end
    if encStateold != activity.getSharedData("EncryptDiary") then
      dataset[4].status["Checked"]=activity.getSharedData("EncryptDiary")
      adapter.notifyDataSetChanged()
    end
  end)
end