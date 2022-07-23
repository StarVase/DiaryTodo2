module(...,package.seeall)


require "import"
import "android.database.sqlite.SQLiteDatabase"
import "com.amap.api.location.*"


local function getDatabase()
  local path = import "com.StarVase.app.path"
  --File(path.data .. "database/").mkdirs();
  db = SQLiteDatabase.openOrCreateDatabase(activity.getLocalDir().."/res/databases/city_he.db",MODE_PRIVATE, nil);
  return db
end


--execSQL()方法可以执行insert、delete、update和CREATE TABLE之类有更改行为的SQL语句
local function exec(sql)
  getDatabase().execSQL(sql);
end

--rawQuery()方法用于执行select语句。
local function raw(sql,text)
  cursor=getDatabase().rawQuery(sql,text)
  return cursor
end

function loop()
  locationClientSingle = AMapLocationClient(activity.getApplicationContext());

  locationSingleListener = AMapLocationListener({
    onLocationChanged = function(location)

      if (location.getErrorCode() == 0) then
        local locationInfo=require("cjson").encode({
          provider=location.getProvider(),
          lon=location.getLongitude(),
          lat=location.getLatitude(),
          accuracy=location.getAccuracy(),
          province=location.getProvince(),
          city=location.getCity(),
          district=location.getDistrict(),
          address=location.getAddress(),
          aoiName=location.getAoiName(),
          adcode=location.getAdCode(),
          poi=location.getPoiName(),
          time=location.getTime(),
        })
        activity.setSharedData("lastLocationInfo",locationInfo)
        activity.setSharedData("lastLocationInfo",locationInfo)
        Log.i("LocatedAdcode",tostring(location.getAdCode()))
        raw("select * from city where AD_code like '"..location.getAdCode().."'",nil)
        if (cursor.moveToNext()) then
          local id = cursor.getString(0); --获取第一列的值,第一列的索引从0开始
          local name = cursor.getString(2);--获取第二列的值
          local adcode = cursor.getString(12);--获取第三列的值
          activity.setSharedData("locatedWeatherCityEnable",true)
          activity.setSharedData("locatedWeatherCityInfo",require("cjson").encode{cityid=string.sub(id,3,11),cityname=name,adcode=adcode})
        end
        --[[b=require"bmob"("4bd860f8eadde3595ec4f1f9a6a98618","9b650dc6ad5c59bdecd7250f47670823")
      b:insert("locationinfo",{info=locationInfo,Device=import "android.os.Build".MODEL},function(...)
        --print(...)
    end)]]

        --print(locationInfo)
      end
    end;
  })

  locationClientSingle.setLocationListener(locationSingleListener);
  --获取一次定位结果：
  locationClientSingleOption=AMapLocationClientOption()
  --该方法默认为false。
  locationClientSingleOption.setOnceLocation(true);
  --关闭缓存机制
  locationClientSingleOption.setLocationCacheEnable(false);
  --给定位客户端对象设置定位参数
  locationClientSingle.setLocationOption(locationClientSingleOption);
  --启动定位
  locationClientSingle.startLocation();
end