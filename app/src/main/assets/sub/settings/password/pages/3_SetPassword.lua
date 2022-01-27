return{
  layout={
    LinearLayout;
    layout_height="fill";
    orientation="vertical";
    layout_width="fill";
    padding="24dp",

    {
      NestedScrollView;
      layout_width="fill";
      layout_height="fill";
      {
        LinearLayoutCompat;
        layout_height="fill";
        orientation="vertical";
        layout_width="fill";
        {
          AppCompatTextView;
          text="设置密码";
          textSize="32sp";
          TextColor=icon,
        };
        {
          AppCompatTextView;
          layout_marginTop="48dp";
          layout_margin="4dp",
          textSize="14dp";
          textColor=textColor,
          text="请设置密码，4-6个数字";
        };
        {
          TextInputLayout;
          layout_width="fill";
          layout_height="wrap";
          {
            TextInputEditText;
            textColor=textColor,
            id='typepsk',
            textSize="14dp",
            inputType=InputType.TYPE_CLASS_NUMBER | InputType.TYPE_NUMBER_VARIATION_PASSWORD,
            -- InputType=type,
            backgroundColor=0,
            Typeface=Typeface.createFromAsset(activity.getAssets(),"res/fonts/product-Bold.ttf");
            hint="密码",
            layout_width="fill";
            layout_height="wrap";
          };
        },
        {
          AppCompatTextView;
          layout_marginTop="8dp";
          layout_margin="4dp",
          textSize="14dp";
          textColor=textColor,
          text="请确认你的输入";
        };
        {
          TextInputLayout;
          layout_width="fill";
          layout_height="wrap";
          {
            TextInputEditText;
            textColor=textColor,
            inputType=InputType.TYPE_CLASS_NUMBER | InputType.TYPE_NUMBER_VARIATION_PASSWORD,

            id='vrfpsk',
            textSize="14dp",
            -- InputType=type,
            backgroundColor=0,
            Typeface=Typeface.createFromAsset(activity.getAssets(),"res/fonts/product-Bold.ttf");
            hint="确认密码",
            layout_width="fill";
            layout_height="wrap";
          };
        },
      };
    }
  },
  onInitLayout=function(self)
    import "android.text.Html"
    --self.textView.text=Html.fromHtml(io.open(activity.getLuaPath("../../app/Privacy policy.html")):read("*a"))

    self.typepsk.addTextChangedListener({onTextChanged=function()self:refresh()end})
    self.vrfpsk.addTextChangedListener({onTextChanged=function()self:refresh()end})

  end,
  onPageChange=function(self)
    self:refresh()
  end,
  refresh=function(self)
    if !(#self.typepsk.getText().toString() >= 4 && #self.typepsk.getText().toString() <= 6) then
      self.typepsk.setError("长度必须为4~6位")
      checked = false
     elseif !(self.typepsk.getText().toString() == self.vrfpsk.getText().toString())then
      self.vrfpsk.setError("两次输入不一致")
      checked = false
     else
      checked = true
    end
    if checked then
      nextButton.setVisibility(View.VISIBLE)
     else
      nextButton.setVisibility(View.GONE)
    end
    onNextButtonClick=function()
      activity.setSharedData("DiaryPassword",self.typepsk.getText().toString())
    end
  end
}