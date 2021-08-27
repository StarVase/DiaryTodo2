package com.StarVase.diaryTodo.app;

/*
 * This activity is exportable in order developers can 
 * debug this application easily.
 * To keep users information safe, the parent class will
 * be tagged as unexportable and this activity will show
 * a floating text to notice users to keep an eye on his
 * or her personal information, and don't do some payments
 * in this mode.
 *
 * Author : StarVase@Coolapk
 * Email : lxz2102141297@163.com
 * Date : 2021 Aug.27 00:35
 *
 */
 
import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.view.Gravity;
import android.view.ViewGroup;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;
import java.io.File;

public class DtdDebugActivity extends BaseActivity {
    
    private final static String ARG = "arg";
    private final static String DATA = "data";
    private final static String NAME = "name";
    private String luaDir = getLuaDir();
    protected Activity mActivity = (Activity)this.getContext();
    @Override
    public void onCreate(Bundle savedInstanceState) {
        
        //mCompatActivity = this.getContext();
        // TODO: Implement this method
        super.onCreate(savedInstanceState);
        //super.setSwipeBackEnable(false);
        
        final TextView copyrightText=new TextView(this.getContext());
        copyrightText.setText(R.string.debug);
        copyrightText.setGravity(Gravity.BOTTOM|Gravity.CENTER);
            
        new Handler().postDelayed(new Runnable(){

                @Override
                public void run() {
                    ViewGroup decorView = (ViewGroup) getDecorView();
                    decorView.addView(copyrightText);
                }
            }, 10);
      
	}
    

    public void newActivity(String path, boolean newDocument) {
        newActivity(1, path, null, newDocument);
    }

    public void newActivity(String path, Object[] arg, boolean newDocument){
        newActivity(1, path, arg, newDocument);
    }

    public void newActivity(int req, String path, boolean newDocument){
        newActivity(req, path, null, newDocument);
    }

    public void newActivity(String path){
        newActivity(1, path, null);
    }

    public void newActivity(String path, Object[] arg){
        newActivity(1, path, arg);
    }

    public void newActivity(int req, String path){
        newActivity(req, path, null);
    }

    public void newActivity(int req, String path, Object[] arg){
        newActivity(req, path, arg, false);
    }

    public void newActivity(int req, String path, Object[] arg, boolean newDocument){
        Intent intent = new Intent(this.getContext(), DtdDebugActivity.class);
        if (newDocument)
            intent = new Intent(this.getContext(), DtdDebugActivityX.class);

        intent.putExtra(NAME, path);
        if (path.charAt(0) != '/')
            path = luaDir + "/" + path;
        File f = new File(path);
        if (f.isDirectory() && new File(path + "/main.lua").exists())
            path += "/main.lua";
        else if ((f.isDirectory() || !f.exists()) && !path.endsWith(".lua"))
            path += ".lua";
  

        if (newDocument) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_DOCUMENT);
                intent.addFlags(Intent.FLAG_ACTIVITY_MULTIPLE_TASK);
            }
        }

        intent.setData(Uri.parse("file://" + path));

        if (arg != null)
            intent.putExtra(ARG, arg);
        if (newDocument)
            mActivity.startActivity(intent);
        else
            mActivity.startActivityForResult(intent, req);
        //overridePendingTransition(android.R.anim.slide_in_left, android.R.anim.slide_out_right);
    }

    public void newActivity(String path, int in, int out, boolean newDocument){
        newActivity(1, path, in, out, null, newDocument);
    }

    public void newActivity(String path, int in, int out, Object[] arg, boolean newDocument){
        newActivity(1, path, in, out, arg, newDocument);
    }

    public void newActivity(int req, String path, int in, int out, boolean newDocument){
        newActivity(req, path, in, out, null, newDocument);
    }

    public void newActivity(String path, int in, int out){
        newActivity(1, path, in, out, null);
    }

    public void newActivity(String path, int in, int out, Object[] arg){
        newActivity(1, path, in, out, arg);
    }

    public void newActivity(int req, String path, int in, int out){
        newActivity(req, path, in, out, null);
    }

    public void newActivity(int req, String path, int in, int out, Object[] arg){
        newActivity(req, path, in, out, arg, false);
    }

    public void newActivity(int req, String path, int in, int out, Object[] arg, boolean newDocument){
        Intent intent = new Intent(this.getContext(), DtdDebugActivity.class);
        if (newDocument)
            intent = new Intent(this.getContext(), DtdDebugActivityX.class);
        intent.putExtra(NAME, path);
        if (path.charAt(0) != '/')
            path = luaDir + "/" + path;
        File f = new File(path);
        if (f.isDirectory() && new File(path + "/main.lua").exists())
            path += "/main.lua";
        else if ((f.isDirectory() || !f.exists()) && !path.endsWith(".lua"))
            path += ".lua";
      
            
        intent.setData(Uri.parse("file://" + path));

        if (newDocument) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_DOCUMENT);
                intent.addFlags(Intent.FLAG_ACTIVITY_MULTIPLE_TASK);
            }
        }


        if (arg != null)
            intent.putExtra(ARG, arg);
        if (newDocument)
            mActivity.startActivity(intent);
        else
            mActivity.startActivityForResult(intent, req);
        mActivity.overridePendingTransition(in, out);

    }
    
}
