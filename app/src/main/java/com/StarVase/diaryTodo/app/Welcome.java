package com.StarVase.diaryTodo.app;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.KeyEvent;
import androidx.appcompat.app.AppCompatActivity;
import java.io.File;
import net.lingala.zip4j.ZipFile;
import net.lingala.zip4j.exception.ZipException;



public class Welcome extends AppCompatActivity {

    private boolean isUpdata;

    private DtdApplication app;

    private String luaMdDir;

    private String localDir;

    private long mLastTime;

    private long mOldLastTime;
    
    private boolean isVersionChanged;

    private String mVersionName;

    private String mOldVersionName;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //getSupportActionBar().hide();
        setTheme(R.style.Welcome);
        app = (DtdApplication) getApplication();
        luaMdDir = app.getMdDir();
        localDir = app.getLocalDir();
        if (checkInfo()) {
            setContentView(R.layout.welcome_icon);
            DtdApplication.getInstance().setSharedData("UnZiped",false);
            new UpdateTask().execute();
        } else {
            startActivity();
            /*if (DtdApplication.getInstance().getSharedData("UnZiped") == true){
                startActivity();
            } else {
                setContentView(R.layout.welcome_icon);
                //new UpdateTask().execute();
            }*/
            
        }
    }

    public void startActivity() {
        Intent intent = new Intent(Welcome.this, DtdWelcome.class);
        if (isVersionChanged) {
            intent.putExtra("isVersionChanged", isVersionChanged);
            intent.putExtra("newVersionName", mVersionName);
            intent.putExtra("oldVersionName", mOldVersionName);
        }
        startActivity(intent);
        //overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out                                                                                                                 );
        finish();

    }

    public boolean checkInfo() {
        try {
            PackageInfo packageInfo = getPackageManager().getPackageInfo(this.getPackageName(), 0);
            long lastTime = packageInfo.lastUpdateTime;
            String versionName = packageInfo.versionName;
            SharedPreferences info = getSharedPreferences("appInfo", 0);
            String oldVersionName = info.getString("versionName", "");
            if (!versionName.equals(oldVersionName)) {
                SharedPreferences.Editor edit = info.edit();
                edit.putString("versionName", versionName);
                edit.apply();
                isVersionChanged = true;
                mVersionName = versionName;
                mOldVersionName = oldVersionName;
            }
            long oldLastTime = info.getLong("lastUpdateTime", 0);
            if (oldLastTime != lastTime) {
                SharedPreferences.Editor edit = info.edit();
                edit.putLong("lastUpdateTime", lastTime);
                edit.apply();
                isUpdata = true;
                mLastTime = lastTime;
                mOldLastTime = oldLastTime;
                return true;
            }
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        return true;
    }

    @SuppressLint("StaticFieldLeak")
    private class UpdateTask extends AsyncTask<String, String, String> {
        @Override
        protected String doInBackground(String[] p1) {
            // TODO: Implement this method
            try {
                unApk("assets/", localDir);
                unApk("lua/", luaMdDir);
            } catch (ZipException e) {
                e.printStackTrace();
            }
            return null;
        }

        @Override
        protected void onPostExecute(String result) {
            startActivity();
            DtdApplication.getInstance().setSharedData("UnZiped",true);

        }

        private void unApk(String dir, String extDir) throws ZipException {
            File file=new File(extDir);
            String tempDir=getCacheDir().getPath();
            LuaUtil.rmDir(file);
            ZipFile zipFile = new ZipFile(getApplicationInfo().publicSourceDir);
            zipFile.extractFile(dir,tempDir);
            new File(tempDir+"/"+dir).renameTo(file);
        }

    }

}
