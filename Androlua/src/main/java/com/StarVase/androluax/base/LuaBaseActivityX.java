package com.StarVase.androluax.base;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import com.StarVase.diaryTodo.app.DtdCoreService;
import com.StarVase.diaryTodo.manager.AppManager;
import com.StarVase.util.OreoFixUtil;
import java.util.ArrayList;

public class LuaBaseActivityX extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        OreoFixUtil.hookOrientation(this);
        AppManager.getAppManager().addActivity(this);
        startService(new Intent(this,DtdCoreService.class));

        super.onCreate(savedInstanceState);
		
    }

    //入口是getLocation

    /**
     * 定位：权限判断
     */
    @RequiresApi(api = Build.VERSION_CODES.M)
    public boolean getLocationPermission() {
        //检查定位权限
        ArrayList<String> permissions = new ArrayList<>();
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            permissions.add(Manifest.permission.ACCESS_FINE_LOCATION);
        }
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            permissions.add(Manifest.permission.ACCESS_COARSE_LOCATION);
        }

        //判断
        if (permissions.size() == 0) {//有权限，直接获取定位
            return true;
			
        } else {//没有权限，获取定位权限
            return false;
            //requestPermissions(permissions.toArray(new String[permissions.size()]), 2);
        }
		
    }

   
	public static void setDarkStatusIcon(Window window, boolean bDark) {
    if (window != null) {
        View decorView = window.getDecorView();
        if(decorView != null){
			int vis = decorView.getSystemUiVisibility();
            if(bDark){
                //设置黑色状态栏图标
                vis |= View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR;
            } else{
                //设置白色状态栏图标
                vis &= ~View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR;
            }
            decorView.setSystemUiVisibility(vis);
        }
    }
}
	
    
	
	public boolean setSwipeBackEnable(boolean p1){
		return false;
	};

}

