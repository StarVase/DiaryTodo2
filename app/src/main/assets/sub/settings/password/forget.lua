require "StarVase"(this,{enableTheme=true})
import "android.widget.ArrayPageAdapter"
import "android.widget.CircleImageView"
import "android.widget.*"
import "android.database.sqlite.*"
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
spTitle = SpannableString("重置密码")
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

question.setText(activity.getSharedData("PwdProtectQst"))
nextButton.onClick=function()
  if answer.getText().toString()==activity.getSharedData("PwdProtectAsw") or psw.getText().toString()==activity.getSharedData("DiaryPassword") then
    if pcall(function()clickToUnlock()end) then
      activity.setSharedData("EncryptDiary",false)
      activity.setSharedData("PwdSet",false)
      MyToast("重置成功")
      task(1000,function()activity.finish()end)
     else
      MyToast("重置失败")
    end

   else
    MyToast("答案/密码错误")
  end
end
&7
function clickToUnlock()
  Thread(Runnable({run=function()
      sql="select * from diary where isEmp=1 order by id desc"
      if pcall(function()cursor=CreateFileUtil.raw(sql,nil)end) then
        while (cursor.moveToNext()) do
          id = cursor.getInt(0); --获取第一列的值,第一列的索引从0开始
          isEmp = cursor.getInt(6);
          key = cursor.getString(7);
          content = cursor.getString(8);

          import "rc4"
          trueKey=minicrypto.decrypt(key,"Diaryenced")
          content=minicrypto.decrypt(content,trueKey)
          values = ContentValues();
          values.put("isEmp",false);
          values.put("key", nil);
          values.put("content",content)
          CreateFileUtil.getDatabase().update("diary", values, "id=?", {tostring(id)});

        end
        cursor.close()
      end
    end})).run()
end
