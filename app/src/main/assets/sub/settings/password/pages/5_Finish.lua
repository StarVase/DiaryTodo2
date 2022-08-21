return{
  layout={
    LinearLayoutCompat;
    orientation="vertical";
    layout_height="fill";
    layout_width="fill";
    padding="24dp",
    {
      NestedScrollView;
      layout_width="fill";
      layout_height="fill";
      {
        LinearLayoutCompat,
        orientation="vertical";
        layout_height="fill";
        layout_width="fill";
        {
          AppCompatTextView;
          text="完成";
          textSize="32sp";
          TextColor=icon,
        };
        {
          AppCompatTextView;
          layout_marginTop="48dp";
          textSize="14dp";
          textColor=textColor,
          text="一切准备就绪！";
        };
        {
          AppCompatCheckBox;
          text="立即启用加密";
          id="checkBox";
          layout_marginTop="48dp";
          textColor=textColot;
          layout_width="fill";

        };
      },
    }
  },

  NextButtonText="完成",
  onInitLayout=function(self)
    import "android.text.Html"
    --self.textView.text=Html.fromHtml(io.open(activity.getLuaPath("../../app/Privacy policy.html")):read("*a"))
    self.checkBox.setOnCheckedChangeListener({onCheckedChanged=function()self:refresh()end})
    self.checkBox.checked=activity.getSharedData("PrivacyPolicy20201008") or false
  end,
  onPageChange=function(self)
    self:refresh()
  end,
  refresh=function(self)
    local checkBox=self.checkBox
    local checked=checkBox.checked
    if checked then
      nextButton.setVisibility(View.VISIBLE)
     else
      nextButton.setVisibility(View.GONE)
    end

  end,
  onNextButtonClick=function()
    activity.setSharedData("EncryptDiary",checked)
    activity.setSharedData("PwdSet",true)
  end
}