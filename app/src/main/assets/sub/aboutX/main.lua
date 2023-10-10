require "import"
--import 'BaseFunlib'
import "android.widget.ListView"
import "android.content.Intent"
import "android.app.AlertDialog"
import "android.net.Uri"
import "android.provider.*"
import "com.StarVase.library.adapter.MyLuaMultiAdapter"

require "StarVase"(this,{enableTheme=true})
TimingUtil.setName(activity.getString(R.string.menu_main_about))
import "function"

import "layout"
activity.setContentView(loadlayout(layout))
graph.Ripple(show1,普通波纹)
import "android.graphics.drawable.GradientDrawable"
ch_item_checked_background = GradientDrawable()
.setShape(GradientDrawable.RECTANGLE)
.setColor(淡色强调波纹)
.setCornerRadii({0,0,math.dp2px(24),math.dp2px(24),math.dp2px(24),math.dp2px(24),0,0});

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
  return true
end


import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.text.Spannable"
spTitle = SpannableString(activity.getString(R.string.menu_main_about))

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
