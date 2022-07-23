package com.StarVase.diaryTodo.interfaces;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import com.StarVase.diaryTodo.app.DtdApplication;
import com.StarVase.diaryTodo.app.BaseActivity;


public class JavascriptInterface {
    
    private Context mContext;
    
    public JavascriptInterface(Context context){
        mContext = context;
    }
    
    
    @android.webkit.JavascriptInterface
    public void startPhotoActivity(String imageUrl) {
        Intent intent = new Intent(mContext, BaseActivity.class);
        String path = DtdApplication.getInstance().getSharedData("BaseLuaPath") + "/sub/notepad/photopresenter.lua";
        Object[] arg = {imageUrl};
        intent.putExtra("name", path);
        intent.setData(Uri.parse("file://" + path));
        intent.putExtra("arg", arg);
        mContext.startActivity(intent);
    }
}
