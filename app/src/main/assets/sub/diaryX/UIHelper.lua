data={}
import "android.widget.ExListView"
import "androidx.swiperefreshlayout.widget.SwipeRefreshLayout"
import "com.google.android.material.card.MaterialCardView"
import "com.google.android.material.chip.Chip"
import "android.graphics.ColorFilter"
import "android.content.res.ColorStateList"
import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "com.google.android.material.textfield.TextInputEditText"
import "com.google.android.material.textfield.TextInputLayout"
import "android.text.Spannable"
import "com.StarVase.view.MaterialButton.TextButton"
import "com.google.android.material.button.MaterialButton"
spTitle = SpannableString(activity.getString(R.string.func_diary))
spTitle.setSpan(ForegroundColorSpan(titleColor),0,#spTitle,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
activity.getSupportActionBar().setTitle(spTitle)
activity.getSupportActionBar().setDisplayShowCustomEnabled(true)
activity.getSupportActionBar().setCustomView(editTitle)
activity.getSupportActionBar().setDisplayHomeAsUpEnabled(true)

--创建菜单
function onCreateOptionsMenu(menu)
  local inflater=activity.getMenuInflater()
  inflater.inflate(R.menu.menu_diary,menu)

end

--菜单点击
function onOptionsItemSelected(item)
  task(1,function()
    local id=item.getItemId()
    switch id
     case
      android.R.id.home
      activity.finish()
     case
      R.id.menu_diary_unlockall
      sub("settings")
     case
      R.id.menu_diary_lockall
      sub("aboutX")

    end
  end)
end


import "layout.layout"
import "layout.item"

activity.setContentView(loadlayout(layout))
--import"fab"
adapter=LuaAdapter(this,data,item)
list.Adapter=adapter

import "function"

AutoSetToolTip(fab,AdapLan("新建","new"))


sr.setRefreshing(false);
sr.setColorSchemeColors({icon});
sr.setOnRefreshListener(SwipeRefreshLayout.OnRefreshListener{
  onRefresh=lambda -> Refresh()
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

import "java.util.Calendar"
import "java.util.Date"
calendar=Calendar.getInstance()
calendar.setTime(Date())
--[[for i=1,100 do
  calendar.add(Calendar.DAY_OF_MONTH,1)
  print(calendar.getTime())
end
]]
lastDay.onClick=function()
  calendar.add(Calendar.DAY_OF_MONTH,-1)
  -- print(date)
  --date.text=tostring(calendar.get(Calendar.YEAR)).."/"..tostring(calendar.get(Calendar.MONTH)+1).."/"..tostring(calendar.get(Calendar.DAY_OF_MONTH))
  Refresh({
    year=calendar.get(Calendar.YEAR),
    month=calendar.get(Calendar.MONTH)+1,
    day=calendar.get(Calendar.DAY_OF_MONTH)
  })
end

nextDay.onClick=function()
  calendar.add(Calendar.DAY_OF_MONTH,1)
  --date.text=tostring(calendar.get(Calendar.YEAR)).."/"..tostring(calendar.get(Calendar.MONTH)+1).."/"..tostring(calendar.get(Calendar.DAY_OF_MONTH))
  Refresh({
    year=calendar.get(Calendar.YEAR),
    month=calendar.get(Calendar.MONTH)+1,
    day=calendar.get(Calendar.DAY_OF_MONTH)
  })
end

date.onClick=function()
  task(100,function()

    import "com.google.android.material.bottomsheet.BottomSheetDialog"

    local dann=import("layout.date_dialog")

    dl=BottomSheetDialog(activity)
    dl.setContentView(loadlayout(dann))
    an=dl.show()
    bottom = dl.findViewById(R.id.design_bottom_sheet);
    if (bottom != nil) then
      bottom
      .setBackgroundResource(android.R.color.transparent)
      .setPadding(math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(32))
    end

    okey.onClick=function()
      calendar.setTime(Date(dp.getYear()-1900,dp.getMonth(),dp.getDayOfMonth()))
      Refresh({
        year=calendar.get(Calendar.YEAR),
        month=calendar.get(Calendar.MONTH)+1,
        day=calendar.get(Calendar.DAY_OF_MONTH)
      })
      dl.dismiss()
    end
    cancel.onClick=lambda -> dl.dismiss()
  end)
end
