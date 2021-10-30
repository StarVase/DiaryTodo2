--[[
捐赠页面 by 幻了个城fly
使用时请在应用中的「关于页面」注明开发者
]]

require "import"
import "StarVase"
import "loadlayout"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.graphics.drawable.BitmapDrawable"
import "android.graphics.Color"
import "android.support.v7.widget.*"

function tointstr(num)
  return (tostring("#ff"..string.sub(Integer.toHexString(num),3,8)))
end
--背景颜色
color1=tointstr(BGC)
--标题颜色
color2=tointstr(titleColor)
--副标题颜色
color3=tointstr(textColor)
--按钮副色
btnColor1=tointstr(forceColor)
--按钮主色
btnColor2=tointstr(forceColor)
--支付宝二维码网址
alipayHongbaoUrl="https://qr.alipay.com/fkx04609b8qev7tmo0lnb10"

import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.text.Spannable"
spTitle = SpannableString("捐赠")
spTitle.setSpan(ForegroundColorSpan(titleColor),0,#spTitle,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
activity.getSupportActionBar().setTitle(spTitle)
activity.getSupportActionBar().setDisplayShowCustomEnabled(true)
activity.getSupportActionBar().setCustomView(editTitle)
activity.getSupportActionBar().setDisplayHomeAsUpEnabled(true)
function onOptionsItemSelected(item)
  local id=item.getItemId()
  if id==android.R.id.home then
    activity.finish()
  end
end


import "layout"
--控件圆角
function CircleButton(view,InsideColor,radiu)
  import "android.graphics.drawable.GradientDrawable"
  drawable = GradientDrawable()
  drawable.setShape(GradientDrawable.RECTANGLE)
  drawable.setColor(InsideColor)
  drawable.setCornerRadii({radiu,radiu,radiu,radiu,radiu,radiu,radiu,radiu});
  view.setBackgroundDrawable(drawable)
end
activity.setContentView(loadlayout(layout))
graph.Ripple(back,普通波纹)
--卡片圆角处理
CircleButton(cardAlipay,Color.parseColor(color1),30)
CircleButton(cardInnerAlipay,Color.parseColor(color1),30)

CircleButton(cardHongbao,Color.parseColor(color1),30)
CircleButton(cardInnerHongbao,Color.parseColor(color1),30)

CircleButton(cardWechat,Color.parseColor(color1),30)
CircleButton(cardInnerWechat,Color.parseColor(color1),30)

--按钮圆角处理
btnDrawable = GradientDrawable(GradientDrawable.Orientation.TL_BR,{Color.parseColor(btnColor1),Color.parseColor(btnColor2)});
btnDrawable.setShape(GradientDrawable.RECTANGLE)
btnDrawable.setCornerRadii({500,500,500,500,500,500,500,500});
buttonCard1.setBackground(btnDrawable);
buttonCard2.setBackground(btnDrawable);
buttonCard3.setBackground(btnDrawable);

--初始化按钮事件
buttonQQpay.onClick=function()
  qrcodeImg = AppCompatImageView(this)
  qrcodeImg.setImageBitmap(loadbitmap("drawable/qq.png"))
  qrcodeImg.setScaleType(AppCompatImageView.ScaleType.CENTER)
  --弹出消息("由于QQ限制，请手动截图")
  dl=AlertDialog.Builder(this)
  .setView(qrcodeImg)
  .setTitle("捐赠二维码")
  .setPositiveButton("关闭",nil)
  imgDia=dl.show()
  DialogButtonFilter(imgDia,1,Color.parseColor(btnColor2))
  DialogButtonFilter(imgDia,2,Color.parseColor(btnColor2))

end
buttonHongbao.onClick=function()
  MyToast.showSnackBar("正在启动支付宝")
  import "android.content.Intent"
  import "android.net.Uri"
  xpcall(function()
    local url="alipayqr://platformapi/startapp?saId=10000007&qrcode="..alipayHongbaoUrl
    activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)));
  end,
  function()
    local url = alipayHongbaoUrl;
    activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)));
  end)
end
function DialogButtonFilter(dialog,button,WidgetColor)
  if Build.VERSION.SDK_INT >= 21 then
    import "android.graphics.PorterDuffColorFilter"
    import "android.graphics.PorterDuff"
    if button==1 then
      dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(WidgetColor)
     elseif button==2 then
      dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(WidgetColor)
     elseif button==3 then
      dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(WidgetColor)
    end
  end
end
buttonWechat.onClick=function()
  qrcodeImg = AppCompatImageView(this)
  qrcodeImg.setImageBitmap(loadbitmap("drawable/wechat.png"))
  qrcodeImg.setScaleType(AppCompatImageView.ScaleType.CENTER)
  --弹出消息("由于微信限制，请手动截图")
  dl=AlertDialog.Builder(this)
  .setView(qrcodeImg)
  .setTitle("捐赠二维码")
  .setPositiveButton("关闭",nil)
  imgDia=dl.show()
  DialogButtonFilter(imgDia,1,Color.parseColor(btnColor2))
  DialogButtonFilter(imgDia,2,Color.parseColor(btnColor2))
end
