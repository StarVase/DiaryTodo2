return{
  layout={
    LinearLayoutCompat;
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
        --padding="16dp";
        {
          AppCompatTextView;
          text="请阅读服务协议";
          textSize="32sp";
          TextColor=icon,
        };
        {
          AppCompatTextView;
          id="textView";
          layout_marginTop="18dp";
          layout_width="fill";
          layout_height="fill";
          textColor=textColor;
        };
        {
          AppCompatCheckBox;
          text="我已阅读并同意服务协议";
          layout_marginTop="48dp";
          id="checkBox";
          textColor=textColor;
          layout_width="fill";

        };

      };
    };
  },

  --ActionbarTitle="隐私政策",
  onInitLayout=function(self)
    import "android.text.Html"
    self.textView.text=Html.fromHtml(io.open(activity.getLuaDir("ServiceLicense.html")):read("*a"))
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
    activity.setSharedData("PrivacyPolicy20201008",checked)

  end
}