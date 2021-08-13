require "import"
import "android.widget.*"
import "android.view.*"

--设置
--显示对话框
--要求输入新密码，并设置密码保护
--写入Shareddata，重载

--取消
--验证密码（忘记密码)
--遍历数据库，读取密钥循环解密
--清楚SharedData,重载

function setPassword()
  import "com.google.android.material.bottomsheet.BottomSheetDialog"
  bsd=BottomSheetDialog(this)
  .setContentView(loadlayout(import "layouts.dialog_yiyan"))
  .show()
  bottom = bsd.findViewById(R.id.design_bottom_sheet);
  if (bottom != null) then
    bottom.setBackgroundResource(android.R.color.transparent)
    .setPadding(math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(32))
  end

end

function clearPassword()

end