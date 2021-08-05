import "com.tencent.qq.widget.ReboundEffectsView"
import "android.support.v4.widget.*"
layout=importFile('tasks',"layout")
item=importFile('tasks',"item")
importFile('tasks',"function")
activity.setContentView(loadlayout(layout))
import"fab"

AutoSetToolTip(add,AdapLan("新建","new"))
graph.Ripple(add,淡色强调波纹)
graph.Ripple(back,普通波纹)


back.onClick=function()
  activity.finish()
end


sr.setRefreshing(false);
sr.setColorSchemeColors({icon});
sr.setOnRefreshListener(SwipeRefreshLayout.OnRefreshListener{onRefresh=function()
    Refresh(filename)
    sr.setRefreshing(false);
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

adapter=LuaAdapter(this,item)
list.Adapter=adapter


