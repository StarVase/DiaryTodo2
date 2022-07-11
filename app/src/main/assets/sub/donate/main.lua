--[[
捐赠页面 by 幻了个城fly
使用时请在应用中的「关于页面」注明开发者
]]

require "import"
require "StarVase"(this,{enableTheme=true})
import "loadlayout"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.graphics.drawable.BitmapDrawable"
import "android.graphics.Color"
import "androidx.appcompat.app.AlertDialog"
import "android.graphics.Typeface"

function tointstr(num)
  return (tostring("#ff"..string.sub(Integer.toHexString(num),3,8)))
end

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
activity.setContentView(loadlayout(layout))


buttonQQpay.onClick=function()
  qrcodeImg = AppCompatImageView(this)
  qrcodeImg.setImageBitmap(loadbitmap("drawable/qq.png"))
  qrcodeImg.setScaleType(AppCompatImageView.ScaleType.CENTER)

  dl=AlertDialog.Builder(this)
  .setView(qrcodeImg)
  .setTitle("捐赠二维码")
  .setPositiveButton("关闭",nil)
  imgDia=dl.show()

end
buttonAlipay.onClick=function()
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

buttonWeChatPay.onClick=function()
  qrcodeImg = AppCompatImageView(this)
  qrcodeImg.setImageBitmap(loadbitmap("drawable/wechat.png"))
  qrcodeImg.setScaleType(AppCompatImageView.ScaleType.CENTER)
  dl=AlertDialog.Builder(this)
  .setView(qrcodeImg)
  .setTitle("捐赠二维码")
  .setPositiveButton("关闭",nil)
  imgDia=dl.show()
end
