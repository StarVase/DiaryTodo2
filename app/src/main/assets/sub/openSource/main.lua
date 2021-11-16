require "import"
require "StarVase"(this,{enableTheme=true})
import "com.StarVase.library.adapter.MyLuaAdapter"
--import "android.graphics.Typeface"
import "layout"

activity.setContentView(loadlayout("layout"))

import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.text.Spannable"
spTitle = SpannableString(AdapLan("开源许可","Open source license"))
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


OpenSourceLicense={
  {
    title="HTextView",
    message="Animation effects with custom font support to TextView",
    url="https://github.com/hanks-zyh/HTextView",
    License="Apache-2.0",
  };
}

for index,content in pairs(OpenSourceLicense) do
  OpenSourceLicense[index].background={background=graph.Ripple(nil,淡色强调波纹,"方")}
end

import "item"
adp=MyLuaAdapter(activity, OpenSourceLicense, item)
listView.Adapter=adp
adp.notifyDataSetChanged()
listView.onItemClick=function(id,v,zero,one)
 -- activity.newActivity("../webview/main",{{标题=OpenSourceLicense[one].title,链接=OpenSourceLicense[one].url}})
end