require "StarVase"(this,{enableTheme=true})
import "android.widget.ArrayPageAdapter"
import "android.widget.CircleImageView"
import "android.widget.*"
require "com.StarVase.view.StyleWidget"
activity.setContentView(loadlayout(require "layout_forget"))
import "android.text.InputType"
import "android.text.InputFilter"
import "android.widget.ExListView"
import "androidx.swiperefreshlayout.widget.SwipeRefreshLayout"
import "android.graphics.ColorFilter"
import "android.content.res.ColorStateList"
import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "com.google.android.material.textfield.TextInputEditText"
import "com.google.android.material.textfield.TextInputLayout"
import "android.text.Spannable"
import "com.StarVase.view.MaterialButton.TextButton"
import "com.google.android.material.button.MaterialButton"
spTitle = SpannableString("忘记密码")
spTitle.setSpan(ForegroundColorSpan(titleColor),0,#spTitle,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
activity.getSupportActionBar().setTitle(spTitle)
activity.getSupportActionBar().setDisplayShowCustomEnabled(true)
activity.getSupportActionBar().setCustomView(editTitle)
activity.getSupportActionBar().setDisplayHomeAsUpEnabled(true)

question.setText(activity.getSharedData("PwdProtectQst"))
nextButton.onClick=function()
  if answer.getText().toString()==activity.getSharedData("PwdProtectAsw") then
    MyToast("您的密码:"..activity.getSharedData("DiaryPassword"))
    else
    MyToast("答案错误")
  end
end