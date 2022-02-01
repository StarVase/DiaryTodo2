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
            WhatIsNew=result.WhatIsNew
            DownloadUrl=result.DownloadUrl
            ApkSize=result.ApkSize
            if type(DownloadUrl) == "string" then
              DownloadEnabled=true
             else
              DownloadEnabled=false
            end
            focusing.addView(loadlayout(require"layouts.newVersion"))

          end
        end
      })
    end
  end
})
