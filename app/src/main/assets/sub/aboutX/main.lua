require "import"
--import 'BaseFunlib'
import "android.content.Intent"
import "android.app.AlertDialog"
import "android.net.Uri"
import "android.provider.*"
import "com.StarVase.library.adapter.MyLuaMultiAdapter"

import "StarVase"
import "function"

import "layout"
activity.setContentView(loadlayout(layout))
graph.Ripple(show1,普通波纹)

import "items"
import "adpd"

adapter=MyLuaMultiAdapter(this,adpd,items)
list.Adapter=adapter
list.onItemClick=function(adp,view,pos,id)
  if adpd[id].onClick then
    adpd[id].onClick()
  end
end



show1.onClick=function()
  双按钮对话框("关于",'软件作者：StarVase\n作者QQ：3399205421\n作者邮箱：lxz2102141297@163.com\n酷安：StarVase_Six\n如有bug请反馈',"联系作者","取消",
  function()
    关闭对话框(an)
    联系() end,function() 关闭对话框(an) end)
end


import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.text.Spannable"
spTitle = SpannableString("关于")
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
