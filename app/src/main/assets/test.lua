require "import"
import "android.widget.*"
import "android.view.*"
import "StarVase"
import "androidx.swiperefreshlayout.widget.SwipeRefreshLayout"
import "com.google.android.material.textfield.TextInputEditText"
import "com.google.android.material.textfield.TextInputLayout"
import "com.StarVase.view.MaterialButton.TextButton"
import "com.google.android.material.button.MaterialButton"


layout={
  LinearLayout;
  orientation="vertical";
  layout_width="fill";
  --Elevation="1dp";
  backgroundDrawable=GradientDrawable()
  .setColor(BGC)
  .setCornerRadii({math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(16)})
  .setShape(0),
  {
    AppCompatAppCompatAppCompatAppCompatTextView;
    layout_width="-1";
    layout_height="-2";
    textSize="20sp";
    layout_marginTop="24dp";
    layout_marginLeft="24dp";
    layout_marginRight="24dp";
    layout_marginBottom="8dp";
    Text=AdapLan("删除","Delete");
    Typeface=Typeface.createFromAsset(activity.getAssets(),"res/fonts/product-Bold.ttf");
    textColor=forceColor;
  };
  {
    MaterialCardView,
    layout_height="wrap",
    layout_width="fill",
    layout_marginLeft="24dp";
    layout_marginRight="24dp";
    radius="4dp";
    CardBackgroundColor=0,
    Elevation="0";

    {
      AppCompatAppCompatAppCompatAppCompatTextView;
      textColor=textColor,
      id='text',
      textSize="14dp",
      Typeface=Typeface.createFromAsset(activity.getAssets(),"res/fonts/product-Bold.ttf");
      Text=AdapLan("操作不可逆！你确定要删除吗？" ,"The operation is irreversible! Are you sure to delete? "),
      layout_width="fill";
      layout_height="wrap";
    };
  },


  {
    LinearLayout;
    orientation="horizontal";
    layout_width="-1";
    layout_height="-2";
    layout_marginTop="8dp";
    layout_marginLeft="8dp";
    layout_marginRight="24dp";
    layout_marginBottom="8dp";
    gravity="right|center";

    {
      TextButton,
      id="cancel",
      text=AdapLan("取消","Cancel"),
      textColor=forceColor;
      padding="2dp",
      layout_marginLeft="4dp";
      layout_marginRight="4dp";
    },
    {
      MaterialButton,
      id="okey",
      text=AdapLan("确定","OK"),
      padding="2dp",
      layout_marginLeft="4dp";
      layout_marginRight="4dp";
    },
  };
};


task(100,function()

  import "com.google.android.material.bottomsheet.BottomSheetDialog"

  local dann=layout

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

    dl.dismiss()
  end
  cancel.onClick=lambda -> dl.dismiss()
end)