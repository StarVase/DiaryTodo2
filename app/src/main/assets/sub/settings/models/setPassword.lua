require "import"
require "StarVase"(this,{enableTheme=true})
import "android.text.style.ForegroundColorSpan"
--设置
--显示对话框
--要求输入新密码，并设置密码保护
--写入Shareddata，重载

--取消
--验证密码（忘记密码)
--遍历数据库，读取密钥循环解密
--清楚SharedData,重载

function setPassword0()
  import "com.google.android.material.bottomsheet.BottomSheetDialog"
  bsd=BottomSheetDialog(this)
  .setContentView(loadlayout(import "layouts.dialog_yiyan"))
  .show()
  bottom = bsd.findViewById(R.id.design_bottom_sheet);
  if (bottom != null) then
    bottom.setBackgroundResource(android.R.color.transparent)
    .setPadding(math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(32))
  end

end

function clearPassword()

end
layout={
  CoordinatorLayout;
  layout_width="fill";
  layout_height="fill";
  id="mainLay";
  backgroundColor=BGC,
  -- paddingTop=状态栏高度,
  {
    LinearLayout,
    layout_width="fill",
    layout_height="fill",
    orientation="vertical",
    backgroundColor=BGC,
    Gravity="center",



    {
      RelativeLayout,
      layout_width="fill",
      layout_height="fill",

      {
        LinearLayout,
        layout_width="fill",
        layout_height="fill",
        orientation="vertical";
        {
          TextInputLayout;
          layout_width="fill";
          layout_height="wrap";
          {
            TextInputEditText;
            textColor=textColor,
            id='edit',
            textSize="14dp",
            -- InputType=type,
            backgroundColor=0,
            Typeface=Typeface.createFromAsset(activity.getAssets(),"res/fonts/product-Bold.ttf");
            hint="密码",
            layout_width="fill";
            layout_height="wrap";
          };
        },
        {
          TextInputLayout;
          layout_width="fill";
          layout_height="wrap";
          {
            TextInputEditText;
            textColor=textColor,
            id='edit',
            textSize="14dp",
            -- InputType=type,
            backgroundColor=0,
            Typeface=Typeface.createFromAsset(activity.getAssets(),"res/fonts/product-Bold.ttf");
            hint="确认密码",
            layout_width="fill";
            layout_height="wrap";
          };
        },
        {
          TextInputLayout;
          layout_width="fill";
          layout_height="wrap";
          {
            TextInputEditText;
            textColor=textColor,
            id='edit',
            textSize="14dp",
            -- InputType=type,
            backgroundColor=0,
            Typeface=Typeface.createFromAsset(activity.getAssets(),"res/fonts/product-Bold.ttf");
            hint="设置密保问题",
            layout_width="fill";
            layout_height="wrap";
          };
        },
        {
          TextInputLayout;
          layout_width="fill";
          layout_height="wrap";
          {
            TextInputEditText;
            textColor=textColor,
            id='edit',
            textSize="14dp",
            -- InputType=type,
            backgroundColor=0,
            Typeface=Typeface.createFromAsset(activity.getAssets(),"res/fonts/product-Bold.ttf");
            hint="输入密保答案",
            layout_width="fill";
            layout_height="wrap";
          };
        }
      }
    }
  },
}
activity.setContentView(loadlayout(layout))
spTitle = SpannableString("密码")
spTitle.setSpan(ForegroundColorSpan(titleColor),0,#spTitle,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
activity.getSupportActionBar().setTitle(spTitle)
activity.getSupportActionBar().setDisplayShowCustomEnabled(true)
activity.getSupportActionBar().setCustomView(editTitle)
activity.getSupportActionBar().setDisplayHomeAsUpEnabled(true)

--创建菜单
function onCreateOptionsMenu(menu)
  local inflater=activity.getMenuInflater()
  inflater.inflate(R.menu.menu_npd,menu)

end

function onOptionsItemSelected(item)
  task(1,function()
    local id=item.getItemId()
    switch id
     case android.R.id.home
      activity.finish()
    end
  end)
end