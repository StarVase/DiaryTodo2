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
spTitle = SpannableString("隐私协议")
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
      bottombar.visibility=View.VISIBLE
     else
      bottombar.visibility=View.GONE
    end
  end
})
nextButton.onClick=function()
  activity.setSharedData("PrivacyState20220402",checkBox.isChecked())
  import "com.amap.api.location.AMapLocationClient"
  AMapLocationClient.updatePrivacyShow(this,true,true)
  AMapLocationClient.updatePrivacyAgree(this,checkBox.isChecked())
  
  task(100,function()
    this.startActivity(Intent(this,luajava.bindClass("com.StarVase.diaryTodo.app.MainActivity")));
    this.finish()
  end)
end

applyPermissions(permissionTable)
