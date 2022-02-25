return{
  CoordinatorLayout;
  id="mainLay";
  layout_width="fill",
  layout_height="fill",
  backgroundColor=BGC,
  layoutTransition=LayoutTransition().enableTransitionType(LayoutTransition.CHANGING);

  {
    LinearLayoutCompat;
    layout_height="fill";
    orientation="vertical";
    layout_width="fill";
    --padding="24dp",
    layoutTransition=LayoutTransition().enableTransitionType(LayoutTransition.CHANGING);


    {
      NestedScrollView;
      layout_width="fill";
      layout_height="fill";
      layout_weight=1;
      padding="24dp",
layoutTransition=LayoutTransition().enableTransitionType(LayoutTransition.CHANGING);

      {
        LinearLayoutCompat;
        layout_width="fill";
        layout_height="fill";
        -- padding="16dp";
        orientation="vertical";
        --layoutTransition=LayoutTransition().enableTransitionType(LayoutTransition.CHANGING);

        {
          MaterialCardView;
          layout_margin="4dp";
          layout_height="30%h";
          layout_width="fill";
         -- layoutTransition=LayoutTransition().enableTransitionType(LayoutTransition.CHANGING);

          {
            LinearLayoutCompat;
            layout_width="fill";
            layout_height="fill";
            layoutTransition=LayoutTransition().enableTransitionType(LayoutTransition.CHANGING);

            {
              TextInputEditText;
              layout_height="fill";
              
              background="0";
              id="demo",
              textSize="50sp",
              text="Example text.\n示例文本。\n1234567890";
              layout_width="fill";
            };
          };
        };
        {
          AppCompatTextView;
          text="字体大小";
          id="labelSize",
          layout_marginTop="8dp";
        };
        {
          AppCompatSeekBar;
          layout_width="fill";
          max=1000,
          layout_marginTop="8dp";
          id="seekbar",
        };
        {
          AppCompatTextView;
          layout_marginTop="8dp";
          text="自定义字体文件";
        };
        {
          MaterialButton;
          layout_marginTop="8dp";
          text="选择ttf文件";
          id="selectttf",
        };
        {
          AppCompatTextView;
         -- layoutTransition=LayoutTransition().enableTransitionType(LayoutTransition.CHANGING);

          layout_marginTop="8dp";
          id="labelTtf",
        };
      };
    };
    {
      MaterialCardView;
      layoutTransition=LayoutTransition().enableTransitionType(LayoutTransition.CHANGING);

      layout_height="56dp";
      layout_width="fill";
      backgroundColor=BGC;
      radius=0;
      elevation="8dp";
      {
        FrameLayout;
        layoutTransition=LayoutTransition().enableTransitionType(LayoutTransition.CHANGING);

        layout_height="fill";
        --gravity="center";
        layout_marginLeft="8dp",
        layout_marginRight="8dp",
        layout_width="fill";
        {
          MaterialButton_TextButton,
          text="重置";
          id="resetButton";
          layout_gravity="left|center";
          -- layout_margin="16dp";
        },
      };
    };
  },
}
