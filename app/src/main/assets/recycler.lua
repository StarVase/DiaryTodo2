require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "androidx.appcompat.widget.LinearLayoutCompat"
import "androidx.recyclerview.widget.RecyclerView"
import "androidx.recyclerview.widget.StaggeredGridLayoutManager"

--import "muk"
--删掉“--”注释符号以使用中文函数

layout={
  LinearLayoutCompat,
  layout_width="fill",
  layout_height="fill",
  {
    RecyclerView,
    id="recyclerView",
    layout_height="fill";
    layout_width="fill";
  }
}

item={
  LinearLayout,
  orientation="vertical",
  layout_width="fill",
  {
    TextView,
    id="text",
    textColor=0xff000000,
    layout_margin="15dp",
    --layout_width="fill"
  },
}

activity.setContentView(loadlayout(layout))



import "java.lang.String"
import "com.google.android.material.tabs.TabLayout$OnTabSelectedListener"
import "com.StarVase.library.adapter.MyLuaRecyclerAdapter"
data={}
adp=MyLuaRecyclerAdapter(activity,data,item)
recyclerView.setAdapter(adp)
recyclerView.setLayoutManager(StaggeredGridLayoutManager(2,StaggeredGridLayoutManager.VERTICAL))

adp.add({text="666"})