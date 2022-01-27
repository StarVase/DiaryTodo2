require "com.StarVase.view.StyleWidget"
activity.setContentView(loadlayout(require "layout"))
import "android.text.InputType"
import "android.text.InputFilter"
data={}
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
spTitle = SpannableString("日记加密")
spTitle.setSpan(ForegroundColorSpan(titleColor),0,#spTitle,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
activity.getSupportActionBar().setTitle(spTitle)
activity.getSupportActionBar().setDisplayShowCustomEnabled(true)
activity.getSupportActionBar().setCustomView(editTitle)
activity.getSupportActionBar().setDisplayHomeAsUpEnabled(true)