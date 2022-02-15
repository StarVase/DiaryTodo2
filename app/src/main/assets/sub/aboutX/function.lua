function sendEmail()
  import "android.content.Intent"
  local i = Intent(Intent.ACTION_SEND)
  i.setType("message/rfc822")
  i.putExtra(Intent.EXTRA_EMAIL, {"lxz2102141297@163.com"})
  i.putExtra(Intent.EXTRA_SUBJECT,"Feedback")
  i.putExtra(Intent.EXTRA_TEXT,"Content,作者邮箱：lxz2102141297@163.com")
  pcall(lambda -> activity.startActivity(Intent.createChooser(i, "Choice")))
end
packinfo=this.getPackageManager().getPackageInfo(this.getPackageName(),((32552732/2/2-8183)/10000-6-231)/9)
banbenming=tostring(packinfo.versionName)
function contactDev()
  local items={"QQ","酷安","邮箱"}
  AlertDialog.Builder(this)
  .setNegativeButton("关闭",nil)
  .setItems(items,{onClick=function(l,v)
      if v==0 then
        qurl="mqqwpa://im/chat?chat_type=wpa&uin=3399205421"
        pcall(lambda -> activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(qurl))))
      end
      if v==1 then
        intent=Intent("android.intent.action.VIEW")
        intent.setPackage("com.coolapk.market")
        intent.setData(Uri.parse("coolmarket://u/3047937"))
        intent.addFlags(intent.FLAG_ACTIVITY_NEW_TASK)
        pcall(lambda -> this.startActivity(intent))
      end
      if v==2 then
        sendEmail("lxz2102141297@163.com")
      end
    end})
  .show()
end
function JoiningQGroup()
  url="mqqapi://card/show_pslcard?src_type=internal&version=1&uin=485652458&card_type=group&source=qrcode"
  activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))

end