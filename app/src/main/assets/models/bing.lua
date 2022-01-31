cjson = require "cjson"



today=tostring(os.date("%Y-%m-%d"))

function getWallPaper()
  wallpaperManager = WallpaperManager.getInstance(activity);
  wallpaperDrawable = wallpaperManager.getDrawable();
  if wallpaperDrawable then
    bm = (wallpaperDrawable).getBitmap();
    import "com.blankj.utilcode.util.ImageUtils"
    --mhbm=ImageUtils.fastBlur(bm)
    --mhbm=graph.高斯模糊(IMG,bm,10,10)
    return bm,mhbm
  end
end

function setWallPaper()
  MainImageType="WallPaper"
  -- thread(function()
  require "import"
  import "com.StarVase.utils.graph"
  import "android.app.WallpaperManager"
  wallpaperManager = WallpaperManager.getInstance(activity);
  wallpaperDrawable = wallpaperManager.getDrawable();
  if wallpaperDrawable then
    source = (wallpaperDrawable).getBitmap();
    --deep=graph.高斯模糊(IMG,source,10,10)
    import "com.blankj.utilcode.util.ImageUtils"
    deep=ImageUtils.stackBlur(source,25)
    --call("setHomeImage",source,deep)
    setHomeImage(source,deep)
    --  end)
  end
end

setHomeImage=function(source,deep)
  setImage(source,deep)
end

--setWallPaper()

function setBingDailyImage(i,j)
  setWallPaper()

  import "okhttp3.*"
  BASE_URL="http://cn.bing.com/HPImageArchive.aspx?format=js&idx="..i.."&n=8"

  cjson=require "cjson"
  request=Request.Builder()
  .url(BASE_URL)
  .build();

  call=OkHttpClient().newCall(request);
  call.enqueue(Callback{

    onFailure=function(call,e)
      Log.d("TAG",BASE_URL);
      activity.runOnUiThread(Runnable{
        run=function()
          info=dump2table(activity.getSharedData("bingImgInfo"))
          api=info.uri
          import "com.bumptech.glide.request.RequestOptions";
          import "com.bumptech.glide.request.target.SimpleTarget"
          import "com.StarVase.library.util.BlurTransformation"
          import "com.bumptech.glide.load.resource.drawable.DrawableTransitionOptions"

          Glide.with(activity)
          .load(api)
          .transition(DrawableTransitionOptions.withCrossFade())
          --.apply(RequestOptions.bitmapTransform(BlurTransformation(activity,18)))
          .into(mainAppCompatImageView)
          Glide.with(activity)
          .load(api)
          .transition(DrawableTransitionOptions.withCrossFade())
          .apply(RequestOptions.bitmapTransform(BlurTransformation(activity,18)))
          .into(subAppCompatImageView)
        end
      })
    end,


    onResponse=function(call,response)

      if(response.isSuccessful())then
        content=response.body().string();
        activity.runOnUiThread(Runnable{
          run=function()
            Log.v("bingImgJson",tostring(content))
            local json=cjson.decode(content)
            detail=(json.images[j].copyright)--介绍
            date=(json.images[j].enddate)--时间
            api="http://s.cn.bing.net"..(json.images[j].url)
            Log.v("bingImage",dump{detail=detail,date=date,uri=api})
            MainImageType="Bing"
            activity.setSharedData("bingImgInfo",dump{detail=detail,date=date,uri=api})

            --[[          --thread(function()
              require "import"
              import "com.StarVase.utils.graph"
              api=activity.get("api")
              source=loadbitmap(api)
              import "com.blankj.utilcode.util.ImageUtils"
              deep=ImageUtils.stackBlur(source,25)
              task(100,function()
                setHomeImage(source,deep)
              end)
           -- end)]]
            import "com.bumptech.glide.request.RequestOptions";
            import "com.bumptech.glide.request.target.SimpleTarget"
            import "com.StarVase.library.util.BlurTransformation"
            Glide.with(activity)
            .load(api)
            --.apply(RequestOptions.bitmapTransform(BlurTransformation(activity,18)))
            .into(mainAppCompatImageView)
            Glide.with(activity)
            .load(api)
            .apply(RequestOptions.bitmapTransform(BlurTransformation(activity,18)))
            .into(subAppCompatImageView)
          end
        })
      end
    end
  })

end


if activity.getSharedData("BingImage")==true then
  setBingDailyImage(-1,1)
 else setWallPaper()
end

