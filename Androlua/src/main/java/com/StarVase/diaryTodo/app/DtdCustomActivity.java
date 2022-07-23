package com.StarVase.diaryTodo.app;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffColorFilter;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.os.Bundle;
import android.util.TypedValue;
import android.view.Menu;
import android.view.View;
import android.view.Window;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import com.StarVase.diaryTodo.app.DtdCoreService;
import com.StarVase.diaryTodo.app.R;
import com.StarVase.diaryTodo.manager.AppManager;
import com.StarVase.util.OreoFixUtil;
import java.util.ArrayList;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffColorFilter;

public class DtdCustomActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        OreoFixUtil.hookOrientation(this);
        AppManager.getAppManager().addActivity(this);
        //startService(new Intent(this,DtdCoreService.class));

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

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        for (int i = 0; i < menu.size(); i++){
            Drawable drawable = menu.getItem(i).getIcon();
            if (drawable != null) {
                drawable.mutate();
                drawable.setColorFilter(
                    new PorterDuffColorFilter(
                        getMenuColor(), 
                        PorterDuff.Mode.SRC_IN)
                );
            }
        }
        return super.onCreateOptionsMenu(menu);
    }

    public int getMenuColor(){
        TypedValue typedValue = new TypedValue();
        getTheme().resolveAttribute(R.attr.menuIconColor, typedValue, true);
        return typedValue.data;
    }



    public boolean setSwipeBackEnable(boolean p1){
        return false;
    };

}

