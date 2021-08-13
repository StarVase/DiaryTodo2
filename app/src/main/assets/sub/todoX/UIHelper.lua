data={}
import "com.tencent.qq.widget.*"
import "androidx.swiperefreshlayout.widget.SwipeRefreshLayout"
import "com.google.android.material.textfield.TextInputEditText"
import "com.google.android.material.textfield.TextInputLayout"

layout=importFile('todoX',"layout")
item=importFile('todoX',"item")

activity.setContentView(loadlayout(layout))
--import"fab"
adapter=LuaAdapter(this,data,item)
list.Adapter=adapter

importFile('todoX',"function")

AutoSetToolTip(add,AdapLan("新建","new"))
graph.Ripple(add,淡色强调波纹)
graph.Ripple(back,普通波纹)




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

