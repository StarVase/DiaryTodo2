require "import"
import "android.widget.PageView"
import "androidx.appcompat.app.*"
import "androidx.appcompat.view.*"
import "androidx.appcompat.widget.*"
import "androidx.viewpager.widget.ViewPager"
import "android.widget.LinearLayout"
import "android.widget.RelativeLayout"
import "com.StarVase.view.MaterialButton.TextButton"
import "com.google.android.material.button.MaterialButton"

import "com.google.android.material.bottomnavigation.BottomNavigationView"
import "androidx.coordinatorlayout.widget.CoordinatorLayout"
import "android.text.Spannable"
import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "androidx.recyclerview.widget.RecyclerView"
import "androidx.appcompat.widget.LinearLayoutCompat"
import "com.StarVase.diaryTodo.view.FileTagView"
import "com.google.android.material.tabs.TabLayout"
import "android.animation.LayoutTransition"
import "androidx.swiperefreshlayout.widget.SwipeRefreshLayout"

import "java.io.File"


import "layout.Recently"
import "layout.Explorer"
import "layout.layout"
import "layout.expItem"

activity.setContentView(loadlayout(layout))
import "function"


actionBar=activity.getSupportActionBar()
actionBar.setDisplayHomeAsUpEnabled(true)
spTitle = SpannableString("MarkdownX")
spTitle.setSpan(ForegroundColorSpan(titleColor),0,#spTitle,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
actionBar.setTitle(spTitle)
actionBar.setDisplayShowCustomEnabled(true)
actionBar.setCustomView(editTitle)
actionBar.setDisplayHomeAsUpEnabled(true)

nav.inflateMenu(R.menu.bottom_nav_markdown)
nav.itemIconTintList.getColors()[0]=icon
nav.itemTextColor.getColors()[0]=icon
nav.itemIconTintList.getColors()[1]=subTextColor
nav.itemTextColor.getColors()[1]=subTextColor

nav.setOnNavigationItemSelectedListener(BottomNavigationView.OnNavigationItemSelectedListener{
  onNavigationItemSelected = function(item)
    switch item.getItemId()
     case R.id.navigation_recently then
      page.showPage(0)
     case R.id.navigation_explorer then
      page.showPage(1);
    end
    return true
  end
})

page.setOnPageChangeListener(PageView.OnPageChangeListener{
  --页面状态改变监听
  onPageScrolled=(lambda(a,b,c) -> nil),
  onPageSelected=lambda(currentPage) -> nav.getMenu().getItem(currentPage).setChecked(true)
})


import "java.lang.String"
import "androidx.recyclerview.widget.StaggeredGridLayoutManager"
import "com.google.android.material.tabs.TabLayout$OnTabSelectedListener"
import "com.StarVase.library.adapter.MyLuaMultiAdapter"
data1={}
adp1=MyLuaMultiAdapter(activity,data1,expItem)
listView1.setAdapter(adp1)

data2={}
adp2=MyLuaMultiAdapter(activity,data2,expItem)
listView2.setAdapter(adp2)



appliedToSwipeRefreshLayout(sr1)
sr1.setOnRefreshListener(SwipeRefreshLayout.OnRefreshListener{
  onRefresh = lambda -> task(10,lambda -> recent())
})

listView1.setOnScrollListener{
  onScrollStateChanged=function(l,s)
    if listView1.getFirstVisiblePosition()==0 then
      sr1.setEnabled(true)
     else
      sr1.setEnabled(false)
    end
  end
}


appliedToSwipeRefreshLayout(sr2)
sr2.setOnRefreshListener(SwipeRefreshLayout.OnRefreshListener{
  onRefresh = lambda -> task(10,lambda -> refresh(crtpath))
})

listView2.setOnScrollListener{
  onScrollStateChanged=function(l,s)
    if listView2.getFirstVisiblePosition()==0 then
      sr2.setEnabled(true)
     else
      sr2.setEnabled(false)
    end
  end
}

