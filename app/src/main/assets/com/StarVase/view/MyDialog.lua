module(...,package.seeall)

function BaseDialog(layout)
  if mode=="Dark" then

    bwz=0x3fffffff
   elseif mode=="Auto" then

   else
    bwz=0x3f000000
  end

  local gd2 = GradientDrawable()
  gd2.setColor(转0x(backgroundc))--填充
  local radius=dp2px(16)
  gd2.setCornerRadii({radius,radius,radius,radius,radius,radius,radius,radius})--圆角
  gd2.setShape(0)--形状，0矩形，1圆形，2线，3环形

  if dialog==nil then
    dialog='0xff444400'
  end
  

  dl=AlertDialog.Builder(activity)
  dl.setView(loadlayout(layout))
  
  if gb==0 then
    dl.setCancelable(false)
  end
  an=dl.show()
  window = an.getWindow();
  window.setBackgroundDrawable(ColorDrawable(0x00ffffff));
  wlp = window.getAttributes();
  wlp.gravity = Gravity.BOTTOM;
  wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
  wlp.height = WindowManager.LayoutParams.WRAP_CONTENT;
  window.setAttributes(wlp);
end




function bitmapShow(bitmap)
  import "com.nwdxlgzs.view.photoview.*"
  if mode=="Dark" then

    bwz=0x3fffffff
   elseif mode=="Auto" then

   else
    bwz=0x3f000000
  end

gd2=GradientDrawable()
.setColor(BGC)
.setCornerRadii({radius,radius,radius,radius,radius,radius,radius,radius})
.setShape(0)


  local gd2 = GradientDrawable()
  gd2.setColor(转0x(backgroundc))--填充
  local radius=dp2px(16)
  gd2.setCornerRadii({radius,radius,radius,radius,radius,radius,radius,radius})--圆角
  gd2.setShape(0)--形状，0矩形，1圆形，2线，3环形

  if dialog==nil then
    dialog='0xff444400'
  end
  local dann={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    paddingBottom="28dp",
    padding="2dp",
    {
      LinearLayout;
      orientation="vertical";
      layout_width="-1";
      layout_height="-2";
      Elevation="4dp";
      BackgroundDrawable=gd2;
      --background=dialog,
      id="ztbj";
      {
        TextView;
        layout_width="-1";
        layout_height="-2";
        textSize="20sp";
        layout_marginTop="24dp";
        layout_marginLeft="24dp";
        layout_marginRight="24dp";
        Text=AdaptationLanguage("必应图","BingImage");
        Typeface=字体("fonts/product-Bold");
        textColor=forceColor;
      };
      {
        LinearLayout,
        orientation="vertical";
        layout_height="wrap",
        layout_width="fill",
        {
          LinearLayout,
          orientation="vertical";
          layout_height="wrap",
          layout_width="fill",
          {
            PhotoView or ImageView,
            ImageBitmap=bitmap,
            scaleType="fitCenter",
            layout_height="1080",
            layout_width="1080",
          },
        },
      },
      {
        LinearLayout;
        orientation="horizontal";
        layout_width="-1";
        layout_height="-2";
        gravity="right|center";
        {
          CardView;
          layout_width="-2";
          layout_height="-2";
          radius="2dp";
          background="#00000000";
          layout_marginTop="8dp";
          layout_marginLeft="8dp";
          layout_marginBottom="24dp";
          Elevation="0";
          onClick=function()
            MyBitmap.saveAsPng(bitmap,tostring(os.time())..".png")
          end;
          {
            TextView;
            layout_width="-1";
            layout_height="-2";
            textSize="16sp";
            Typeface=字体("fonts/product-Bold");
            paddingRight="16dp";
            paddingLeft="16dp";
            paddingTop="8dp";
            paddingBottom="8dp";
            Text=AdaptationLanguage("保存","Save");
            textColor=stextc;
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
        {
          CardView;
          layout_width="-2";
          layout_height="-2";
          radius="4dp";
          backgroundColor=forceColor;
          layout_marginTop="8dp";
          layout_marginLeft="8dp";
          layout_marginRight="24dp";
          layout_marginBottom="24dp";
          Elevation="1dp";
          onClick=qdnr;
          {
            TextView;
            layout_width="-1";
            layout_height="-2";
            textSize="16sp";
            paddingRight="16dp";
            paddingLeft="16dp";
            Typeface=字体("fonts/product-Bold");
            paddingTop="8dp";
            paddingBottom="8dp";
            Text=AdaptationLanguage("关闭","Cancel");
            textColor=0xffffffff;
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
      };
    };
  };

  dl=AlertDialog.Builder(activity)
  dl.setView(loadlayout(dann))
  if gb==0 then
    dl.setCancelable(false)
  end
  an=dl.show()
  window = an.getWindow();
  window.setBackgroundDrawable(ColorDrawable(0x00ffffff));
  wlp = window.getAttributes();
  wlp.gravity = Gravity.BOTTOM;
  wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
  wlp.height = WindowManager.LayoutParams.WRAP_CONTENT;
  window.setAttributes(wlp);



end

