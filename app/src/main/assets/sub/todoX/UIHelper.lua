data={}
import "com.tencent.qq.widget.*"
import "androidx.swiperefreshlayout.widget.SwipeRefreshLayout"
import "com.google.android.material.textfield.TextInputEditText"
import "com.google.android.material.textfield.TextInputLayout"
import "com.StarVase.view.MaterialButton.TextButton"
import "com.google.android.material.button.MaterialButton"

layout=import "layout.layout"
item=import "layout.item"

activity.setContentView(loadlayout(layout))
--import"fab"
adapter=LuaAdapter(this,data,item)
list.Adapter=adapter

import "function"

AutoSetToolTip(fab,AdapLan("新建","new"))


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

