import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"

import "layout"

activity.setContentView(loadlayout(layout))

import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.text.Spannable"
spTitle = SpannableString("一文")
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



sr.setRefreshing(false);
sr.setColorSchemeColors({icon});
sr.setOnRefreshListener(SwipeRefreshLayout.OnRefreshListener{onRefresh=function()
    getArticle()
    sr.setRefreshing(false);
  end})


scroll.setOnScrollChangeListener({
  onScrollChange=function(v,scrollx,scrolly,lastscrollx,lastscrolly)
    if scrolly==0 then
      sr.setEnabled(true)
     else
      sr.setEnabled(false)
    end
  end,
})
