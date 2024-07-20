require "StarVase"(this,{enableTheme=true})
import "android.widget.ArrayPageAdapter"
import "android.widget.CircleImageView"
import "android.widget.*"
require "com.StarVase.view.StyleWidget"
activity.setContentView(loadlayout(require "layout"))
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
spTitle = SpannableString(AdapLan("隐私协议","Privacy Agreement"))
spTitle.setSpan(ForegroundColorSpan(titleColor),0,#spTitle,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
activity.getSupportActionBar().setTitle(spTitle)
activity.getSupportActionBar().setDisplayShowCustomEnabled(true)
activity.getSupportActionBar().setCustomView(editTitle)
activity.getSupportActionBar().setDisplayHomeAsUpEnabled(true)
function onOptionsItemSelected(item)
  local id=item.getItemId()
  if id==android.R.id.home then
    activity.finish()
  end
end

textView.text=Html.fromHtml(io.open(activity.getLuaDir("PrivacyPolicy.html")):read("*a"))
checkBox.setOnCheckedChangeListener({
  onCheckedChanged=function()
    if checkBox.isChecked() then
      hintText.visibility=View.GONE
      nextButton.visibility=View.VISIBLE
     else
      nextButton.visibility=View.GONE
      hintText.visibility=View.VISIBLE
    end
  end
})
nextButton.onClick=function()
  activity.setSharedData("PrivacyState20240720",checkBox.isChecked())
  import "com.amap.api.location.AMapLocationClient"
  AMapLocationClient.updatePrivacyShow(this,true,true)
  AMapLocationClient.updatePrivacyAgree(this,checkBox.isChecked())
  applyPermissions(permissionTable)

  task(5000,function()
    this.startActivity(Intent(this,luajava.bindClass("com.StarVase.diaryTodo.app.MainActivity")));
    this.finish()
  end)
end

backButton.onClick=function()
  this.finish()
end
