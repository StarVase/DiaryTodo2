package com.StarVase.diaryTodo.app;

import android.os.Bundle;
import android.view.KeyEvent;


public class DtdWelcome extends BaseActivity
{

    @Override
    public void onCreate(Bundle savedInstanceState) {
        // TODO: Implement this method
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
    
}

