return{
  layout={
    LinearLayoutCompat;
    orientation="vertical";
    layout_height="fill";
    layout_width="fill";
    padding="24dp",
    {
      AppCompatTextView;
      text="欢迎";
      textSize="32sp";
      TextColor=icon,
    };
    {
      AppCompatTextView;
      layout_marginTop="48dp";
      textSize="14dp";
      textColor=textColor,
      text="本页面将引导你启用日记加密功能";
    };
  };
}