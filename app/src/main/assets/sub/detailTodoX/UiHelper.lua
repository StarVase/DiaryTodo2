data={}
import "android.widget.ExListView"
import "androidx.swiperefreshlayout.widget.SwipeRefreshLayout"
import "android.graphics.ColorFilter"
import "android.content.res.ColorStateList"
import "com.google.android.material.textfield.TextInputEditText"
import "com.google.android.material.textfield.TextInputLayout"
import "com.StarVase.view.MaterialButton.TextButton"
import "com.google.android.material.button.MaterialButton"
import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.text.Spannable"

import "layout.layout"
import "layout.item"

spTitle = SpannableString("待办")
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


editTitle=loadlayout({
  TextInputEditText;
  layout_width="fill";
  Hint="待办标题";
  --singleLine=true;
  textIsSelectable=true;
  lines=1;
  inputType="text";
  backgroundColor=0;
  --theme=0x01010099;
  style="?android:attr/windowTitleStyle";
  textColor=titleColor,
  HintTextColor=subTitleColor,
  padding=0;
  layout_height="48dp";
  gravity="center|left";
})
activity.supportActionBar.setTitle(nil)
activity.supportActionBar.setDisplayShowCustomEnabled(true)
activity.supportActionBar.setCustomView(editTitle)
activity.getSupportActionBar().setDisplayHomeAsUpEnabled(true)


activity.setContentView(loadlayout(layout))
--import"fab"
adapter=LuaAdapter(this,data,item)
list.Adapter=adapter

import "function"

AutoSetToolTip(fab,AdapLan("新建","new"))
--graph.Ripple(add,淡色强调波纹)



sr.setRefreshing(false);
sr.setColorSchemeColors({icon});
sr.setOnRefreshListener(SwipeRefreshLayout.OnRefreshListener{onRefresh=function()
    Refresh(todoid)

  end
})


--监听list是否到顶
list.setOnScrollListener{
  onScrollStateChanged=function(l,s)
    if list.getFirstVisiblePosition()==0 then
      sr.setEnabled(true)
     else
      sr.setEnabled(false)
    end
  end
}

