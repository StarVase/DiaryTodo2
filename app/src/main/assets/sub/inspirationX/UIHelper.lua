data={}
import "com.tencent.qq.widget.ReboundEffectsView"
import "androidx.swiperefreshlayout.widget.SwipeRefreshLayout"

layout=importFile('inspirationX',"layout")
item=importFile('inspirationX',"item")

activity.setContentView(loadlayout(layout))
--import"fab"
adapter=LuaAdapter(this,data,item)
list.Adapter=adapter

importFile('inspirationX',"function")

AutoSetToolTip(add,AdapLan("新建","new"))
graph.Ripple(add,淡色强调波纹)


import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.text.Spannable"
spTitle = SpannableString("灵感X")
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
    Refresh()

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

