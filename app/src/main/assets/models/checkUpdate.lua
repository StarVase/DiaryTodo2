import "okhttp3.*"
cjson=require "cjson"

UPDATE_URL="https://wds.ecsxs.com/220434.json"

CurrentVersionName=APKVersionInfoUtils.getVersionName(activity)
CurrentVersionCode=APKVersionInfoUtils.getVersionCode(activity)

requestUpdate=Request.Builder()
.url(UPDATE_URL)
.build();

call_update=OkHttpClient().newCall(requestUpdate);
call_update.enqueue(Callback{

  onFailure=function(call,e)
    Log.d("TAG",UPDATE_URL);
  end,


  onResponse=function(call,response)

    if(response.isSuccessful())then
      local result=response.body().string();
      activity.runOnUiThread(Runnable{
        run=function()
          result=cjson.decode(result)
          if result.VersionName != CurrentVersionName && result.VersionCode > CurrentVersionCode then
            focusing.addView(loadlayout(require"layouts.newversion"))

            WhatIsNew=result.WhatIsNew
            DownloadUrl=result.DownloadUrl
            ApkSize=result.ApkSize
            if type(DownloadUrl) == "string" then
              DownloadEnabled=true
              redirectableUrl=false
              DownloadButton.setEnabled(true);
             elseif DownloadUrl == -1 then
              DownloadEnabled=true
              redirectableUrl=false
              DownloadButton.setEnabled(true);
             else
              DownloadEnabled=false
              redirectableUrl=nil
              DownloadButton.text=AdapLan("敬请期待","Please wait...")
              DownloadButton.setEnabled(false);
            end
            versionText.text=CurrentVersionName.." -> "..result.VersionName
            NewButton.onClick=function()
              task(50,function()
                import "com.google.android.material.bottomsheet.BottomSheetDialog"
                sentences=dump2table(activity.getSharedData("thisYiyan"))
                bsd=BottomSheetDialog(this)

                .setContentView(loadlayout(import "layouts.dialog_WhatIsNew"))
                .show()
                wtncontent.setText(WhatIsNew)
                bottom = bsd.findViewById(R.id.design_bottom_sheet);
                if (bottom != null) then
                  bottom.setBackgroundResource(android.R.color.transparent)
                  .setPadding(math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(32))
                end
              end)
            end
            DownloadButton.onClick=function()
              if redirectableUrl then
                local okhcli = OkHttpClient().newCall(Request.Builder().url("https://www.coolapk.com/apk/com.StarVase.diaryTodo").build()).enqueue(Callback{

                  onFailure=function(call,e)
                    Log.d("TAG",UPDATE_URL);
                  end,


                  onResponse=function(call,response)

                    if(response.isSuccessful())then
                      body=response.body().string()

                      pcall(function()
                        resultofca=body:match([[dl.coolapk.com/down(.-)&from=click]])
                        DownloadUrlCoolapk="https://dl.coolapk.com/down"..resultofca.."&from=click"
                      end)
                      print(DownloadUrlCoolapk)
                      if DownloadUrlCoolapk then
                        import "com.StarVase.diaryTodo.util.DownloadUtil"
                        downloadManagerUtils = DownloadUtil(this);
                        --print(result)
                        id = downloadManagerUtils.download(DownloadUrlCoolapk,"DiaryTodo_"..result.VersionName.."_"..tostring(result.VersionCode),"Update package for DiaryTodo, version of "..result.VersionName);
                        downloadManagerUtils.registerReceiver(DownloadUtil.OnDownloadCompleted( {--注册广播和下载完成监听

                          onDownloadCompleted=function(completeDownloadId)
                            downloadManagerUtils.installApk(completeDownloadId);--调用第5步的方法
                          end
                        }));
                      end

                    end
                  end
                })

               else
                import "com.StarVase.diaryTodo.util.DownloadUtil"
                downloadManagerUtils = DownloadUtil(this);
                id = downloadManagerUtils.download(DownloadUrl,"DiaryTodo_"..result.VersionName.."_"..tostring(result.VersionCode),"Update package for DiaryTodo, version of "..result.VersionName);
                downloadManagerUtils.registerReceiver(DownloadUtil.OnDownloadCompleted( {--注册广播和下载完成监听

                  onDownloadCompleted=function(completeDownloadId)
                    downloadManagerUtils.installApk(completeDownloadId);--调用第5步的方法
                  end
                }));
              end
            end

          end
        end
      })
    end
  end
})
