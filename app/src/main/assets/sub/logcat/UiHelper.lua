
import "androidx.swiperefreshlayout.widget.SwipeRefreshLayout"
import "com.google.android.material.tabs.TabLayout"
import "com.StarVase.library.view.*"
import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.text.Spannable"
import "layout"
dataset={}
activity.setContentView(loadlayout(layout))

adapter=require"adapter"(dataset)
recycler.setAdapter(adapter)
adapter.notifyDataSetChanged()


searchedit.addTextChangedListener{
  onTextChanged=function(c)
    print(c)
    scroll.adapter.filter(tostring(c))
  end
}



spTitle = SpannableString(activity.getString(R.string.func_logcat))
spTitle.setSpan(ForegroundColorSpan(titleColor),0,#spTitle,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
activity.getSupportActionBar().setTitle(spTitle)
activity.getSupportActionBar().setDisplayShowCustomEnabled(true)
activity.getSupportActionBar().setCustomView(editTitle)
activity.getSupportActionBar().setDisplayHomeAsUpEnabled(true)


import "android.content.*"
cm=activity.getSystemService(activity.CLIPBOARD_SERVICE)

function copy(str)
  local cd = ClipData.newPlainText("label",str)
  cm.setPrimaryClip(cd)
  Toast.makeText(activity,"已复制的剪切板",1000).show()
end


--[[sr.setRefreshing(false);
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
]]