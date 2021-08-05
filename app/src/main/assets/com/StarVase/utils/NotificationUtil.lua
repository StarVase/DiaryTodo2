require "import"
import "android.app.*"
import "android.os.*"
import "android.net.Uri"
import "android.content.*"

module(...,package.seeall)

-------- Writing on the first:
-------- Android O and higher Android versions need Channel to send notifications
-------- This is a util about how to use it
-------- Author : StarVase
-------- Time : 2021-02-27 3:35 p.m.
-------- 
-------- noticeUtil.lua


CHANNEL_ID="notice"
CHANNEL_NAME="notice"
CHANNEL_DESCRIPTION="notice"
NOTIFY_ID=10001

local function createChannel()
  if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
    notificationChannel= NotificationChannel(CHANNEL_ID,CHANNEL_NAME, NotificationManager.IMPORTANCE_DEFAULT);
    notificationChannel.setDescription(CHANNEL_DESCRIPTION);
    notificationManager=activity.getSystemService(activity.NOTIFICATION_SERVICE);
    notificationManager.createNotificationChannel(notificationChannel);
  end
end

function send(title,content,callback)
  createChannel()
  manager=this.getSystemService(Context.NOTIFICATION_SERVICE);
  builder=Notification.Builder(this,CHANNEL_ID);
  builder.setSmallIcon(R.drawable.icon);
  builder.setContentTitle(title);
  builder.setContentText(content)
  builder.setAutoCancel(false)
  notification=builder.build();
  notificationManagerCompat=NotificationManager.from(this);
  notificationManagerCompat.notify(NOTIFY_ID,builder.build());
end
