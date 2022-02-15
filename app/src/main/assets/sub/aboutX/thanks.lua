require "StarVase"(this,{enableTheme=true})

spTitle = SpannableString("鸣谢")
spTitle.setSpan(ForegroundColorSpan(titleColor),0,#spTitle,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
activity.getSupportActionBar().setTitle(spTitle)
activity.getSupportActionBar().setDisplayShowCustomEnabled(true)
activity.getSupportActionBar().setCustomView(editTitle)
activity.getSupportActionBar().setDisplayHomeAsUpEnabled(true)
function onOptionsItemSelected(item)
  local id=item.getItemId()
  if id==android.R.id.home then
    activity.finish()
  end
end

layout={
  CoordinatorLayout;
  id="mainLay";
  layout_width="fill",
  layout_height="fill",
  backgroundColor=BGC,
  {
    LinearLayout;
    layout_height="fill";
    orientation="vertical";
    layout_width="fill";
    layoutTransition=LayoutTransition().enableTransitionType(LayoutTransition.CHANGING);

    --padding="24dp",

    {
      NestedScrollView;
      layout_width="fill";
      layout_weight=1;

      layout_marginLeft="8dp",
      layout_marginRight="8dp",
      {
        LinearLayoutCompat;
        layout_height="fill";
        orientation="vertical";
        layout_width="fill";
        {
          AppCompatTextView;
          id="textView";
          --layout_marginTop="18dp";
          layout_width="fill";
          textIsSelectable=true,
          layout_height="fill";
          textColor=textColor;
        };
      };
    },
  },
}


activity.setContentView(loadlayout(layout))

textView.text=Html.fromHtml(io.open(activity.getLuaDir("thanks.html")):read("*a"))
