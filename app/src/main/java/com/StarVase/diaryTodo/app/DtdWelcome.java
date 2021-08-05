package com.StarVase.diaryTodo.app;

import android.content.Intent;
import android.os.Bundle;


public class DtdWelcome extends BaseActivity
{

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


}

