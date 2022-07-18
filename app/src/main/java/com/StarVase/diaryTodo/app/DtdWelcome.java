package com.StarVase.diaryTodo.app;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.PowerManager;
import android.provider.Settings;
import android.view.KeyEvent;
import androidx.annotation.RequiresApi;


public class DtdWelcome extends BaseActivity
{
    
    Context activity = this.getContext();
    
    @Override
    public void onCreate(Bundle savedInstanceState) {
        // TODO: Implement this method
        if (!isIgnoringBatteryOptimizations()) {
            //requestIgnoreBatteryOptimizations();
        }
        super.onCreate(savedInstanceState);
        //super.setSwipeBackEnable(false);
	}

	@Override
	public String getLuaDir()
	{
		// TODO: Implement this method
		return getLocalDir();
	}

	@Override
	public String getLuaPath()
	{
		// TODO: Implement this method
		initMain();
		return getLocalDir()+"/welcome.lua";
	}

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event)  
    {
        if(keyCode==KeyEvent.KEYCODE_BACK)
        {
            return true;
        }
        return false;
    }
    @RequiresApi(api = Build.VERSION_CODES.M)
    public void requestIgnoreBatteryOptimizations() {
         try{
             Intent intent = new Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS);
             intent.setData(Uri.parse("package:"+ activity.getPackageName()));
             activity.startActivity(intent);
             } catch(Exception e) {
             e.printStackTrace();
         }
    }
    @RequiresApi(api = Build.VERSION_CODES.M)
    private boolean isIgnoringBatteryOptimizations() {
        boolean isIgnoring = false;
        PowerManager powerManager = (PowerManager) activity.getSystemService(Context.POWER_SERVICE);
        if(powerManager != null) {
            isIgnoring = powerManager.isIgnoringBatteryOptimizations(activity.getPackageName());
        }
        return isIgnoring;
    }
}

