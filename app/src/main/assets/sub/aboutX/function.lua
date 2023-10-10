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
versionName=tostring(packinfo.versionName)
versionCode=tostring(packinfo.versionCode)

function contactDev()
  local items={"QQ",AdapLan("酷安","Coolapk"),AdapLan("邮箱","E-mail")}
  AlertDialog.Builder(this)
  .setNegativeButton(AdapLan("关闭","close"),nil)
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
        xpcall(lambda -> this.startActivity(intent),lambda -> MyToast.showSnackBar(AdapLan("未安装正确版本的QQ","QQ was not installed properly.")))
      end
      if v==2 then
        sendEmail("lxz2102141297@163.com")
      end
    end})
  .show()
end

function checkAgreement(name)
  if activity.getSharedData("PrivacyState20220402") then
    return AdapLan("已同意","Agreed")
   else
    return AdapLan("未同意","NOT Agreed")

  end
end

function JoiningQGroup()
  url="mqqapi://card/show_pslcard?src_type=internal&version=1&uin=485652458&card_type=group&source=qrcode"
  xpcall(lambda-> activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url))),lambda -> MyToast.showSnackBar(AdapLan("未安装正确版本的QQ","QQ was not installed properly.")))


end

function privacy()
  subed("privacy")
end