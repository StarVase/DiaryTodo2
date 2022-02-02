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
    Log.d("TAG",BASE_URL);
  end,


  onResponse=function(call,response)

    if(response.isSuccessful())then
      result=response.body().string();
      activity.runOnUiThread(Runnable{
        run=function()
          result=cjson.decode(result)
          if result.VersionName != CurrentVersionName or result.VersionCode != CurrentVersionCode then
            focusing.addView(loadlayout(require"layouts.newVersion"))

            WhatIsNew=result.WhatIsNew
            DownloadUrl=result.DownloadUrl
            ApkSize=result.ApkSize
            if type(DownloadUrl) == "string" then
              DownloadEnabled=true
              DownloadButton.setEnabled(true);
             else
              DownloadEnabled=false
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

            end

          end
        end
      })
    end
  end
})
