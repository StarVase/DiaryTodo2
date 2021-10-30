package com.StarVase.androluax.base;

import android.Manifest;
import android.content.pm.PackageManager;
import android.location.Location;
import android.location.LocationManager;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;
import androidx.annotation.RequiresApi;
import androidx.core.app.ActivityCompat;
import com.StarVase.diaryTodo.app.MainActivity;
import com.StarVase.diaryTodo.manager.AppManager;
import com.StarVase.util.OreoFixUtil;
import java.util.ArrayList;
import java.util.List;
import me.imid.swipebacklayout.lib.app.SwipeBackActivity;
import androidx.appcompat.app.AppCompatActivity;

public class LuaBaseActivityX extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        OreoFixUtil.hookOrientation(this);
        AppManager.getAppManager().addActivity(this);
        super.onCreate(savedInstanceState);
    }

    //入口是getLocation

    /**
     * 定位：权限判断
     */
    @RequiresApi(api = Build.VERSION_CODES.M)
    public String getLocation() {
		String result;
        //检查定位权限
        ArrayList<String> permissions = new ArrayList<>();
        if (ActivityCompat.checkSelfPermission(LuaBaseActivityX.this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            permissions.add(Manifest.permission.ACCESS_FINE_LOCATION);
        }
        if (ActivityCompat.checkSelfPermission(LuaBaseActivityX.this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            permissions.add(Manifest.permission.ACCESS_COARSE_LOCATION);
        }

        //判断
        if (permissions.size() == 0) {//有权限，直接获取定位
            result = getLocationLL();
			
        } else {//没有权限，获取定位权限
            requestPermissions(permissions.toArray(new String[permissions.size()]), 2);
			result = "lon=0#lat=0";
            Log.d("*************", "没有定位权限");
        }
		return result;
    }

    /**
     * 定位：获取经纬度
     */
    private String getLocationLL() {
		String result;
        Log.d("*************", "获取定位权限1 - 开始");
        Location location = getLastKnownLocation();
        if (location != null) {
            
            //日志
            String locationStr = "维度：" + location.getLatitude() + "\n"
				+ "经度：" + location.getLongitude();
            Log.d("*************", "经纬度：" + locationStr);
			result = "lon="+location.getLongitude()+"#lat="+location.getLatitude();
        } else {
            Toast.makeText(this, "位置信息获取失败", Toast.LENGTH_SHORT).show();
            Log.d("*************", "获取定位权限7 - " + "位置获取失败");
			result = "lon=0#lat=0";
        }
		return result;
    }

    /**
     * 定位：得到位置对象
     * @return
     */
    private Location getLastKnownLocation() {
        //获取地理位置管理器
        LocationManager mLocationManager = (LocationManager) getApplicationContext().getSystemService(LOCATION_SERVICE);
        List<String> providers = mLocationManager.getProviders(true);
        Location bestLocation = null;
        for (String provider : providers) {
            Location l = mLocationManager.getLastKnownLocation(provider);
            if (l == null) {
                continue;
            }
            if (bestLocation == null || l.getAccuracy() < bestLocation.getAccuracy()) {
                // Found best last known location: %s", l);
                bestLocation = l;
            }
        }
        return bestLocation;
    }
	
	public boolean setSwipeBackEnable(boolean p1){
		return false;
	};

}

