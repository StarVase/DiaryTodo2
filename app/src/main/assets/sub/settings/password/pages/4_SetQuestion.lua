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
          text="设置密保";
          textSize="32sp";
          TextColor=icon,
        };
        {
          AppCompatTextView;
          layout_marginTop="48dp";
          textSize="14dp";
          layout_margin="4dp",
          textColor=textColor,
          text="请设置一个问题";
        };
        {
          TextInputLayout;
          layout_width="fill";
          layout_height="wrap";
          {
            TextInputEditText;
            textColor=textColor,
            id='question',
            textSize="14dp",
            -- InputType=type,
            backgroundColor=0,
            Typeface=Typeface.createFromAsset(activity.getAssets(),"res/fonts/product-Bold.ttf");
            hint="密保问题",
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
          text="请输入问题对应的答案";
        };
        {
          TextInputLayout;
          layout_width="fill";
          layout_height="wrap";
          {
            TextInputEditText;
            textColor=textColor,
            id='answer',
            textSize="14dp",
            -- InputType=type,
            backgroundColor=0,
            Typeface=Typeface.createFromAsset(activity.getAssets(),"res/fonts/product-Bold.ttf");
            hint="密保答案",
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

    self.question.addTextChangedListener({onTextChanged=function()self:refresh()end})
    self.answer.addTextChangedListener({onTextChanged=function()self:refresh()end})

  end,
  onPageChange=function(self)
    self:refresh()
  end,
  refresh=function(self)
    if !(#self.question.getText().toString() >= 1 && self.question.getText().toString() != " ") then
      self.question.setError("必须设置问题")
      checked = false
     elseif !(#self.answer.getText().toString() >= 1 && self.answer.getText().toString() != " ") then
      self.answer.setError("必须设置答案")
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
      activity.setSharedData("PwdProtectQst",self.question.getText().toString())
      activity.setSharedData("PwdProtectAsw",self.answer.getText().toString())
    end
  end
}