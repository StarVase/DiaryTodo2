require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.text.*"
import "android.content.Intent"
import "android.app.AlertDialog"
import "android.net.Uri"
import "android.provider.*"
import "com.StarVase.diaryTodo.app.LuaAdapter"
import "android.graphics.drawable.BitmapDrawable"
import "android.graphics.Color"
import "android.support.v7.widget.*"
import "com.tencent.qq.widget.ReboundEffectsView"
import "StarVase"
function 发送邮件()
  import "android.content.Intent"
  i = Intent(Intent.ACTION_SEND)
  i.setType("message/rfc822")
  i.putExtra(Intent.EXTRA_EMAIL, {"lxz2102141297@163.com"})
  i.putExtra(Intent.EXTRA_SUBJECT,"Feedback")
  i.putExtra(Intent.EXTRA_TEXT,"Content,作者邮箱：lxz2102141297@163.com")
  activity.startActivity(Intent.createChooser(i, "Choice"))
end
packinfo=this.getPackageManager().getPackageInfo(this.getPackageName(),((32552732/2/2-8183)/10000-6-231)/9)
banbenming=tostring(packinfo.versionName)




function DialogButtonFilter(dialog,button,WidgetColor)
  if Build.VERSION.SDK_INT >= 21 then
    import "android.graphics.PorterDuffColorFilter"
    import "android.graphics.PorterDuff"
    if button==1 then
      dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(WidgetColo)
     elseif button==2 then
      dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(WidgetColor)
     elseif button==3 then
      dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(WidgetColor)
    end
  end
end

color1,color2,color3=background,titlec,wordcolor


layout=importFile("about","layout")




activity.setContentView(loadlayout(layout))

圆波纹=graph.Ripple
圆波纹(back,普通波纹)
圆波纹(logo,普通波纹)








--[[adpd={
  {
    img={
      src="drawable/information.png",
    },
    title={
      text="版本",
    },
    content={
      text=banbenming,
    },
  },
  {
    img={
      src="drawable/account.png",
    },
    title={
      text="作者",
    },
    content={
      text="@StarVase",
    },
  },
  {
    img={
      src="drawable/credit_card.png",
    },
    title={
      text="捐赠",
    },
    content={
      text="若你喜欢，随意捐赠",
    },
  },

}]]

items=importFile("about","items")

onclick={
  function()--版本

  end,
  function(v)
    联系()
  end,
  function()--捐赠
    sub("donate")
  end,

};

adapter=LuaMultiAdapter(this,adpd,items)
list.Adapter=adapter
list.onItemClick=function(adp,view,pos,id)
  if onclick[id] then
    onclick[id]()
  end
end
adapter.add{__type=1}
adapter.add{__type=2,title={text="应用"}}
adapter.add{__type=3,
  img={
    src="drawable/information.png",
  },
  title={
    text="版本",
  },
  content={
    text=banbenming,
  },
}
adapter.add{__type=4,
  img={
    src="images/license.png",
  },
  title={
    text="用户协议",
  },

}

adapter.add{__type=2,title={text="开发"}}
adapter.add{__type=3,
  img={
    src="drawable/account.png",
  },
  title={
    text="作者",
  },
  content={
    text="@StarVase",
  },
}
adapter.add{__type=3,
  img={
    src="drawable/credit_card.png",
  },
  title={
    text="捐赠",
  },
  content={
    text="若你喜欢，随意捐赠",
  },
}
adapter.add{__type=4,
  img={
    src="images/github.png",
  },
  title={
    text="开源许可",
  },

}

back.onClick=function()
  activity.finish()
end

--[[logo.onClick=function()
  双按钮对话框("关于",'软件作者：StarVase\n作者QQ：3399205421\n作者邮箱：lxz2102141297@163.com\n酷安：StarVase_Six\n如有bug请反馈',"联系作者","取消",
  function()
    关闭对话框(an)
    联系() end,function() 关闭对话框(an) end)


end

]]
function 弹出消息(内容)
  Toast.makeText(activity,内容,Toast.LENGTH_SHORT).show()
end





function 联系()
  items={"QQ","酷安","邮箱"}
  AlertDialog.Builder(this)
  .setNegativeButton("关闭",nil)
  .setItems(items,{onClick=function(l,v)
      if v==0 then
        qurl="mqqwpa://im/chat?chat_type=wpa&uin=3399205421"
        activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(qurl)))
      end
      if v==1 then
        intent=Intent("android.intent.action.VIEW")
        intent.setPackage("com.coolapk.market")
        intent.setData(Uri.parse("coolmarket://u/3047937"))
        intent.addFlags(intent.FLAG_ACTIVITY_NEW_TASK)
        this.startActivity(intent)
      end
      if v==2 then
        发送邮件("lxz2102141297@163.com")
      end
    end})
  .show()
end