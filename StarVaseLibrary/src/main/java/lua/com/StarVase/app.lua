module(...,package.seeall)
function checkUpdate()
  本地版本=this.getPackageManager().getPackageInfo(this.getPackageName(),64).versionName
  urla="http://nmsix.top/index.php/archives/35/"
  canoffline=false
  packinfo=this.getPackageManager().getPackageInfo(this.getPackageName(),((32552732/2/2-8183)/10000-6-231)/9)
  appinfo=this.getPackageManager().getApplicationInfo(this.getPackageName(),0)
  applabel=this.getPackageManager().getApplicationLabel(appinfo)
  appsign=tostring(packinfo.signatures[0].toCharsString())
  import "android.content.Context"

  Http.get(urla,function(code,content)
    本地版本=this.getPackageManager().getPackageInfo(this.getPackageName(),64).versionName

    if code==200 then
      update=content:match("<p>{更新:(.-):END}")
      if(update)then

        newest=update:match("【版本:(.-):END】")
        qyysize=update:match("【大小:(.-):END】")
        bbzy=update:match("【版本注意:(.-):END】")
        if(update:match("【强制更新:(.-):END】")=="TRUE")then
          force=true
         else
          force=false
        end
        if(update:match("【版本号更新:(.-):END】")=="TRUE" )then
          usevername=true
         else
          usevername=false
        end
        if(usevername)then
          version=tostring(packinfo.versionName)
         else
          version=tostring(packinfo.versionCode)
        end
        chglog=update:match("【更新日志:(.-):END】")
        软件链接=content:match("【下载地址】(.-)【下载地址】")
        if 本地版本 ~= newest then
          双按钮对话框("更新",'最新版本：'..newest..'\n当前版本：'..本地版本..'\n更新内容：\n'..chglog,"更新","取消",
          function()
            关闭对话框(an)

            svd('ht'..软件链接,'StarVase/NewApk/','diary.apk') end,function() 关闭对话框(an) end)
        end

      end
    end
  end)

end

