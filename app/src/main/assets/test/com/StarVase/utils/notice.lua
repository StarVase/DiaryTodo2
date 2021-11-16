module(...,package.seeall)
function send(title,content,callback)
  import "android.R"
  import "android.widget.RemoteViews"
  import "android.net.Uri"
  import "android.content.Intent"
  import "android.content.Context"
  import "android.app.ActivityManager"
  import "android.app.PendingIntent"
  import "android.app.Notification"
  import "android.app.NotificationManager"

  notificationManager=activity.getSystemService(Context.NOTIFICATION_SERVICE)
  builder=Notification.Builder(this)
  mIntent = Intent(Intent.ACTION_MAIN);
  mIntent.setComponent(ComponentName(activity.getPackageName(),"com.StarVase.diaryTodo.app.DtdMain"));
  mIntent.setData(Uri.parse(callback));

  pendingIntent=PendingIntent.getActivity(this,0,mIntent,0)
  builder.setContentIntent(pendingIntent)--点击事件
  builder.setSmallIcon((android.R.drawable.ic_dialog_info))--图标
  builder.setContentTitle(title)--标题
  builder.setContentText(content)--消息
  notification=builder.build()
  notificationManager.notify(1,notification)--发送通知
end