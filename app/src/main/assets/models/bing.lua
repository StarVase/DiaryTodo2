cjson = require "cjson"



today=tostring(os.date("%Y-%m-%d"))

function getWallPaper()
  wallpaperManager = WallpaperManager.getInstance(activity);
  wallpaperDrawable = wallpaperManager.getDrawable();
  bm = (wallpaperDrawable).getBitmap();
  mhbm=graph.高斯模糊(IMG,bm,10,10)
  return bm,mhbm
end

function setWallPaper()
  MainImageType="WallPaper"
  thread(function()
    require "import"
    import "com.StarVase.utils.graph"
    import "android.app.WallpaperManager"
    wallpaperManager = WallpaperManager.getInstance(activity);
    wallpaperDrawable = wallpaperManager.getDrawable();
    source = (wallpaperDrawable).getBitmap();
    deep=graph.高斯模糊(IMG,source,10,10)
    
    call("setHomeImage",source,deep)
  end)
end

setHomeImage=function(source,deep)
  setImage(source,deep)
end



function setBingDailyImage(i,j)
  setWallPaper()
  local url="http://cn.bing.com/HPImageArchive.aspx?format=js&idx="..i.."&n=8"
  Http.get(url,nil,"utf8",nil,function(code,content,cookie,header)
    if(code==200 and content)then
      Log.v("bingImgJson",tostring(content))
      local json=cjson.decode(content)
      detail=(json.images[j].copyright)--介绍
      date=(json.images[j].enddate)--时间
      api="http://s.cn.bing.net"..(json.images[j].url)
      Log.v("bingImage",dump{detail=detail,date=date,uri=api})
      MainImageType="Bing"
      activity.setSharedData("bingImgInfo",dump{detail=detail,date=date,uri=api})

      thread(function()
        require "import"
        import "com.StarVase.utils.graph"
        api=activity.get("api")
        source=loadbitmap(api)
        deep=graph.高斯模糊(IMG,source,10,10)
        task(100,function()
          call("setHomeImage",source,deep)
        end)
      end)
     else
      setWallPaper()
    end
  end)
end


if activity.getSharedData("BingImage")==true then
  setBingDailyImage(-1,1)
 else setWallPaper()
end