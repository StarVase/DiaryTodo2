require "import"
import "androidx.appcompat.app.*"
import "androidx.appcompat.view.*"
import "androidx.appcompat.widget.*"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "androidx.viewpager.widget.ViewPager"
import "android.widget.LinearLayout"
import "android.widget.RelativeLayout"
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

import "layout.Recently"
import "layout.Explorer"
import "layout.layout"
import "layout.expItem"

activity.setContentView(loadlayout(layout))
actionBar=activity.getSupportActionBar()
actionBar.setDisplayHomeAsUpEnabled(true) 
spTitle = SpannableString("MarkdownX")
spTitle.setSpan(ForegroundColorSpan(titleColor),0,#spTitle,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
actionBar.setTitle(spTitle)
actionBar.setDisplayShowCustomEnabled(true)
actionBar.setCustomView(editTitle)
actionBar.setDisplayHomeAsUpEnabled(true)

