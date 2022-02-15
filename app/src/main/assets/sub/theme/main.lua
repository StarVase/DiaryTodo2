require "import"
require "StarVase"(this,{enableTheme=true})
import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.text.Spannable"
import "layout"
import "item"
AppTheme.table=require "app.ThemeTable"
theme=require "themes"

activity.setContentView(loadlayout(layout))

function onOptionsItemSelected(item)
  local id=item.getItemId()
  if id==android.R.id.home then
    activity.finish()
  end
end


function toAbsId(id)
  for k,v in ipairs(theme) do
    if v.ThemeId == id then
      absid=k
      break
    end
  end
  return absid
end


spTitle = SpannableString("主题")
spTitle.setSpan(ForegroundColorSpan(titleColor),0,#spTitle,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
activity.getSupportActionBar().setTitle(spTitle)
activity.getSupportActionBar().setDisplayShowCustomEnabled(true)
activity.getSupportActionBar().setDisplayHomeAsUpEnabled(true)



adp=LuaAdapter(activity, theme, item)
listView.Adapter=adp

for index,content in pairs(theme) do
  if AppTheme.getid()==content.ThemeId then
    theme[index].istrue={Visibility=View.VISIBLE}
   else
    theme[index].istrue={Visibility=View.GONE}
  end
end
adp.notifyDataSetChanged()

function mSetTheme(id)
  AppTheme.setByUser(theme[id].ThemeId)
  activity.recreate()
end


listView.onItemClick=function(l, v, d, p)
  task(1,lambda -> mSetTheme(p))
end

listView.onItemLongClick=function(l, v, d, p)
  if theme[d].ThemeId==8 then
    task(1,function()
      import "com.google.android.material.bottomsheet.BottomSheetDialog"
      local dann=import "dialog_run"
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
        if edit.getText() then
          loadstring(edit.getText().toString())()
        end
      end
      cancel.onClick=lambda -> dl.dismiss()
    end)
    return true
   else
    return false
  end
end