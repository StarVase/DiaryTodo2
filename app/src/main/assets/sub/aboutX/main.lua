require "import"
--import 'BaseFunlib'
import "android.content.Intent"
import "android.app.AlertDialog"
import "android.net.Uri"
import "android.provider.*"
import "com.StarVase.library.adapter.MyLuaMultiAdapter"

require "StarVase"(this,{enableTheme=true})
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
  return true
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
