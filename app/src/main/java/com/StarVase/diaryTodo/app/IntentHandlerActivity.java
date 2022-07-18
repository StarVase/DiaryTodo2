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

public class IntentHandlerActivity extends BaseActivity {

    Context activity = this.getContext();

    @Override
    public void onCreate(Bundle savedInstanceState) {
        // TODO: Implement this method
        
        super.onCreate(savedInstanceState);
        //super.setSwipeBackEnable(false);
        Intent intent = this.getIntent();
	    
    }
    
    protected void onNewIntent(Intent intent)
    {
        // TODO: Implement this method
        runFunc("onNewIntent", intent);
        
	}
    
    @Override
    public String getLuaDir() {
        // TODO: Implement this method
        return getLocalDir();
    }

    @Override
    public String getLuaPath() {
        // TODO: Implement this method
        initMain();
        return getLocalDir() + "/intentCallback.lua";
    }
    

	
}
