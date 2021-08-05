require"import"
import "cjson"
import "StarVase"
import "android.widget.ExListView"
xpcall(function()import "com.tencent.qq.widget.ReboundEffectsView"end,function()ReboundEffectsView=ListView end)
import "androidx.coordinatorlayout.widget.CoordinatorLayout"
import "android.os.*"
import "android.app.*"
import "android.view.*"
import "android.widget.*"
import "android.graphics.*"
import "android.graphics.drawable.GradientDrawable"
import "android.content.Context"
import "android.graphics.drawable.*"
import "android.app.ActionBar"


ch_item_checked_background = GradientDrawable()
.setShape(GradientDrawable.RECTANGLE)
.setColor(淡色强调波纹)
.setCornerRadii({0,0,math.dp2px(24),math.dp2px(24),math.dp2px(24),math.dp2px(24),0,0});
layout=importFile("settings","layout")


local main = nil
this.setContentView(loadlayout(layout))
import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.text.Spannable"
spTitle = SpannableString("设置")
spTitle.setSpan(ForegroundColorSpan(titleColor),0,#spTitle,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
activity.getSupportActionBar().setTitle(spTitle)
activity.getSupportActionBar().setDisplayShowCustomEnabled(true)
activity.getSupportActionBar().setCustomView(editTitle)
activity.getSupportActionBar().setDisplayHomeAsUpEnabled(true)
--activity.getSupportActionBar().getNavigationIcon().setColorFilter(titleColor,PorterDuff.Mode.SRC_IN);







function onOptionsItemSelected(item)
  local id=item.getItemId()
  if id==android.R.id.home then
    activity.finish()
  end
end



listView.setOnScrollListener{
  onScroll=function(l,s)
    --MyToolbarStyle.AutoElevation(activity.getSupportActionBar(),listView.getFirstVisiblePosition())
  end
}



dataset = {}
setting=importFile('settings',"setlay")
adp=LuaMultiAdapter(this,dataset,setting)
adp.add{__type=1,title=AdapLan("界面","User Interface")}
adp.add{__type=3,intent="ChooseTheme",img={ImageResource=R.drawable.ic_tshirt_crew_outline},subtitle=AdapLan("主题选择","Select themes")}
adp.add{__type=3,intent="ResetFabPos",img={ImageResource=R.drawable.ic_circle},subtitle=AdapLan("重置悬浮球位置","Reset fab position")}
adp.add{__type=1,title=AdapLan("编辑器","Editor")}
adp.add{__type=2,intent="FontSize",p={Focusable=false},img={ImageResource=R.drawable.ic_format_size},subtitle=AdapLan("字体大小","Font Size"),message=tostring(activity.getSharedData("FontSize")or 14)}
adp.add{__type=1,title=AdapLan("密码","Password")}
adp.add{__type=5,intent="EncryptDiary",p={Focusable=true},img={ImageResource=R.drawable.ic_lock_outline},subtitle=AdapLan("日记加密","Diary encryption"),message=AdapLan('实验室功能',"Laboratory function"),status={Checked=Boolean.valueOf(this.getSharedData("日记加密"))}}
adp.add{__type=2,intent="PasswordPro",p={Focusable=true},img={ImageResource=R.drawable.ic_lock_outline},subtitle=AdapLan("设置密保","Set password security"),message=AdapLan('可用密保找回密码',"The password can be recovered with security")}
adp.add{__type=1,title=AdapLan("展示","Showing")}
adp.add{__type=4,intent="BingImage",img={ImageResource=R.drawable.ic_microsoft_bing},subtitle=AdapLan("每日必应","Bing images"),message=AdapLan("从必应加载每日图片","Load daily pictures from Bing"),status={Checked=Boolean.valueOf(this.getSharedData("BingImage"))}}
adp.add{__type=5,intent="WeatherTip",p={Focusable=false},img={ImageResource=R.drawable.ic_weather},subtitle=AdapLan("天气提示","Weather tips"),status={Checked=Boolean.valueOf(this.getSharedData("WeatherTip"))}}
adp.add{__type=1,title=AdapLan("一言","Yiyan")}
adp.add{__type=4,intent="YiyanEnabled",img={ImageResource=R.drawable.ic_comment_processing_outline},subtitle=AdapLan("显示一言","Show Yiyan"),message=AdapLan("在首页加载本地句子","Load f--k"),status={Checked=Boolean.valueOf(this.getSharedData("YiyanEnabled"))}}
adp.add{__type=2,intent="YiyanType",p={Focusable=false},img={ImageResource=R.drawable.ic_comment_processing_outline},subtitle=AdapLan("一言类型","Yiyan Type"),message=yiyan.listYiyanType("name")[yiyan.listYiyanType("id")[activity.getSharedData("YiyanType") or "undefined"]]}

adp.add{__type=1,title=AdapLan("应用","Application")}
adp.add{__type=5,intent="AutoBackup",img={ImageResource=R.drawable.ic_backup},subtitle=AdapLan("自动备份","Auto backup"),status={Checked=Boolean.valueOf(this.getSharedData("AutoBackup"))}}
adp.add{__type=3,intent="RecoveryBackup",img={ImageResource=R.drawable.ic_backup},subtitle=AdapLan("恢复备份","Restore backup")}
adp.add{__type=3,intent="AboutApp",img={ImageResource=R.drawable.ic_information_outline},subtitle=AdapLan("关于应用","About")}

listView.setAdapter(adp)

listView.onItemLongClick=function(id,v,zero,one)

  Popup_layout={
    LinearLayout;
    {
      CardView;
      CardElevation="6dp";
      CardBackgroundColor=background;
      Radius="12dp";
      layout_width="wrap";
      layout_height="-2";
      layout_margin="8dp";

      {
        GridView;
        layout_height="-1";
        layout_width="wrap";

        NumColumns=3;
        id="Popup_list";
      };
    };
  };
  pop=PopupWindow(activity)
  pop.setContentView(loadlayout(Popup_layout))
  --pop.setWidth(-2)
  --pop.setHeight(-2)
  pop.setOutsideTouchable(true)
  pop.setBackgroundDrawable(ColorDrawable(0x00000000))
  pop.onDismiss=function()
    --消失事件
  end
  Popup_list_item={
    LinearLayout;
    layout_width="wrap";
    layout_height="64dp";
    backgroundColor=BGC;
    {
      TextView;
      id="popadp_text";
      textColor=textColor;
      layout_width="107dp";
      layout_height="fill";
      paddingRight="10dp";
      textSize="14sp";
      gravity="center";
      paddingLeft="10dp";
      --Typeface=字体("product");
    };
  };

  --列表适配器
  popadp=LuaAdapter(activity,Popup_list_item)
  Popup_list.setAdapter(popadp)


  --添加项目(菜单项)
  --[[  popadp.add{popadp_text=AdapLan("设置ghff哈哈嘎嘎嘎嘎","Settings"),}
  popadp.add{popadp_text=AdapLan("关于","About"),}
  popadp.add{popadp_text=AdapLan("退出","Exit"),}
  popadp.add{popadp_text=AdapLan("设置","Settings"),}
  popadp.add{popadp_text=AdapLan("关于","About"),}
  popadp.add{popadp_text=AdapLan("退出","Exit"),}
  popadp.add{popadp_text=AdapLan("设置ghff哈哈嘎嘎嘎嘎","Settings"),}
  popadp.add{popadp_text=AdapLan("设置ghff哈哈嘎嘎嘎嘎","Settings"),}
  popadp.add{popadp_text=AdapLan("设置ghff哈哈嘎嘎嘎嘎","Settings"),}
]]

  --菜单点击事件
  Popup_list.setOnItemClickListener(AdapterView.OnItemClickListener{
    onItemClick=function(parent, v, pos,id)
      pop.dismiss()
      local s=v.Tag.popadp_text.Text
      if id == 2 then
        sub('about')
       elseif id == 1 then
        sub('settings')
       elseif id == 3 then
        os.exit()
      end
    end
  })


  pop.showAsDropDown(v)

  return true
end



importFile("settings","settingFuncs")



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


function onResume()
  if themeold~=activity.getSharedData("theme") then
    --[[activity.newActivity("sub/settings/main", android.R.anim.fade_in, android.R.anim.fade_out)
    activity.finish()]]
    activity.recreate()
  end
end