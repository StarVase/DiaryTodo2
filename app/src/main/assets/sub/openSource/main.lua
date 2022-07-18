require "import"
require "StarVase"(this,{enableTheme=true})
import "com.StarVase.library.adapter.MyLuaAdapter"
import "android.widget.ListView"
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


OpenSourceLicense=require "info"

for index,content in pairs(OpenSourceLicense) do
  OpenSourceLicense[index].background={background=graph.Ripple(nil,淡色强调波纹,"方")}
end

import "item"
adp=MyLuaAdapter(activity, OpenSourceLicense, item)
listView.Adapter=adp
adp.notifyDataSetChanged()
listView.onItemClick=function(id,v,zero,one)
  if OpenSourceLicense[one].url then
    viewIntent = Intent("android.intent.action.VIEW",Uri.parse(OpenSourceLicense[one].url))
    activity.startActivity(viewIntent)
  end
end
listView.onItemLongClick=function(id,v,zero,one)
  if OpenSourceLicense[one].DetailLicense then
    task(50,function()
      import "com.google.android.material.bottomsheet.BottomSheetDialog"
      bsd=BottomSheetDialog(this)
      .setContentView(loadlayout(require "dialog_license"))
      .show()
      content.setText(OpenSourceLicense[one].DetailLicense)
      source.setText(OpenSourceLicense[one].title)
      bottom = bsd.findViewById(R.id.design_bottom_sheet);
      if (bottom != null) then
        bottom.setBackgroundResource(android.R.color.transparent)
        .setPadding(math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(32))
      end
    end)
  end
end