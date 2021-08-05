require "import"
import "StarVase"
xpcall(function()
  import "com.tencent.qq.widget.ReboundEffectsView"
end,
function()
  ReboundEffectsView=ListView
end)
layout=importFile("theme","layout")
theme={
  {
    name="默认白",
    view={backgroundColor=AppTheme.table[1].mainColor},
    ThemeId=1,
  },
  {
    name="深海蓝",
    view={backgroundColor=AppTheme.table[2].mainColor},
    ThemeId=2,
  },
  {
    name="咕鸽粉",
    view={backgroundColor=AppTheme.table[7].mainColor},
    ThemeId=7,
  },
  {
    name="荣耀绿",
    view={backgroundColor=AppTheme.table[4].mainColor},
    ThemeId=4,
  },
  {
    name="新年红",
    view={backgroundColor=AppTheme.table[3].mainColor},
    ThemeId=3,
  },
  {
    name="夜空黑",
    view={backgroundColor=AppTheme.table[5].mainColor},
    ThemeId=5,
  },

  {
    name="纯黑",
    view={backgroundColor=AppTheme.table[6].mainColor},
    ThemeId=6,
  },
}


function toAbsId(id)
  for k,v in ipairs(theme) do
    if v.ThemeId == id then  
      absid=k
      break
    end
  end
return absid
end


print()
item= {
  LinearLayout;
  layout_height="56dp";
  gravity="center|left";
  layout_width="fill";
  {
    CardView;
    layout_height="40dp";
    radius="20dp";
    elevation=0;
    layout_marginLeft="16dp";
    layout_width="40dp";
    id="view";
    {
      LinearLayout;
      layout_height="fill";
      gravity="center";
      layout_width="fill";
      background="#22000000";
      id="istrue";
      {
        ImageView;
        layout_width="24dp";
        layout_height="24dp";
        src="icons/true.png";
        colorFilter="#FFFFFFFF";
      };
    };
  };
  {
    TextView;
    layout_marginLeft="16dp";
    textColor=textColor;
    id="name";
    textSize="16sp";
  };
}



activity.setContentView(loadlayout(layout))
import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.text.Spannable"
spTitle = SpannableString("主题")
spTitle.setSpan(ForegroundColorSpan(titleColor),0,#spTitle,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
activity.getSupportActionBar().setTitle(spTitle)
activity.getSupportActionBar().setDisplayShowCustomEnabled(true)
--activity.getSupportActionBar().setCustomView(editTitle)
activity.getSupportActionBar().setDisplayHomeAsUpEnabled(true)
function onOptionsItemSelected(item)
  local id=item.getItemId()
  if id==android.R.id.home then
    activity.finish()
  end
end


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



listView.onItemClick=function(l, v, d, p)
  print(p,theme[p].ThemeId)
  AppTheme.setByUser(theme[p].ThemeId)
  activity.newActivity("sub/theme/main", android.R.anim.fade_in, android.R.anim.fade_out)
  activity.finish()
  activity.recreate()
  --window.setStatusBarColor(mainColor)

end