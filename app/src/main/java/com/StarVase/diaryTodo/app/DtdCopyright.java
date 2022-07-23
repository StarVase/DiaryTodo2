package com.StarVase.diaryTodo.app;

import android.os.Build;
import android.util.Log;
import android.view.Gravity;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.AppCompatTextView;
import com.StarVase.diaryTodo.util.APKVersionInfoUtils;

public class DtdCopyright {
    AppCompatActivity activity;
    String Author="StarVase";
    String AndroidVersion=Build.VERSION.RELEASE;
    String DeviceModel=Build.MANUFACTURER + " " + Build.MODEL;
    String SDKVersion=Build.VERSION.SDK;
    String CPUArchitecture=Build.CPU_ABI;
    String CPUArchitecture2=Build.CPU_ABI2;
    String CPUModel=Build.HARDWARE;
    String versionName;
    String versionCode;

    //Log.i("deviceInfo",info);

    public DtdCopyright(AppCompatActivity mActivity) {
        activity = mActivity;
        if (mActivity != null) {
            versionName = APKVersionInfoUtils.getVersionName(mActivity);
            versionCode = String.valueOf(APKVersionInfoUtils.getVersionCode(mActivity));
        } else {
            versionName = versionCode = "NULL";
        }

    }

    public boolean isDebugModeEnabled() {
        boolean debugModeEnabled = false;
        if (versionName.indexOf("Preview") > 0 || versionName.indexOf("Dev") > 0 || versionName.indexOf("Test") > 0) {
            debugModeEnabled = true;
        }
        return debugModeEnabled;
    }

    public AppCompatTextView getCopyrightTextView() {
        AppCompatTextView copyrightText = new AppCompatTextView(activity);
        if (isDebugModeEnabled()) {

            copyrightText.setText(getCopyrightInfo());
            copyrightText.setTextSize(8);
            copyrightText.setAlpha(0.75f);
            copyrightText.setGravity(Gravity.BOTTOM | Gravity.RIGHT);
            //.setBackgroundColor(0xff000000)

        }

        return copyrightText;
    }

    public AppCompatTextView getCopyrightTextView(String msg) {
        AppCompatTextView copyrightText = new AppCompatTextView(activity);

            copyrightText.setText(msg);
            copyrightText.setTextSize(8);
            copyrightText.setAlpha(0.75f);
            copyrightText.setGravity(Gravity.BOTTOM | Gravity.LEFT);
            //.setBackgroundColor(0xff000000)

        

        return copyrightText;
    }

    public String getCopyrightInfo() {
        String info=String.format("Test Version:%s(%s)\nCPU Architecture:%s|%s(%s)//SDK:%s"
                                  , versionName
                                  , versionCode
                                  , CPUArchitecture
                                  , CPUArchitecture2
                                  , CPUModel
                                  , SDKVersion);
        Log.i("deviceInfo", info);
        return info;
    }

}
