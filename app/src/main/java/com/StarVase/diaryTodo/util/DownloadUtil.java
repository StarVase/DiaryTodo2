package com.StarVase.diaryTodo.util;

import android.app.DownloadManager;
import android.content.ActivityNotFoundException;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import androidx.core.content.FileProvider;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class DownloadUtil {
    
    DownloadManager downloadManager;
    Context context;
    /**
     * 初始化downloadManager
     */
    private void getService() {
        String serviceString = Context.DOWNLOAD_SERVICE;
        downloadManager = (DownloadManager) context.getSystemService(serviceString);
    }
    
    List<Long> downloadIds;//记录所有下载任务id

    /** * @param uil 下载地址 
     * @param title 通知栏标题
     * @param description 描述
     * @return */ 
    public long download(String uil, String title, String description) {
        Uri uri = Uri.parse(uil);
        DownloadManager.Request request = new DownloadManager.Request(uri);//设置下载地址
        request.setTitle(title);//设置Notification的title信息
        request.setDescription(description);//设置Notification的message信息
        request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);//设置通知栏下载通知显示状态
        //下载到download文件夹下 
        request.setDestinationInExternalPublicDir(Environment.DIRECTORY_DOWNLOADS, "update.apk");
        //只能在WiFi下进行下载
        request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_WIFI);
        //reference变量是系统为当前的下载请求分配的一个唯一的ID，我们可以通过这个ID重新获得这个下载任务，进行一些自己想要进行的操作或者查询
        long id = downloadManager.enqueue(request);
        downloadIds.add(id);
        return id; 
    }
    
    /**
     * 判断下载组件是否可用
     *
     * @param context
     * @return
     */
    private boolean canDownloadState(Context context) {
        try {
            int state = context.getPackageManager().getApplicationEnabledSetting("com.android.providers.downloads");
            if (state == PackageManager.COMPONENT_ENABLED_STATE_DISABLED
                || state == PackageManager.COMPONENT_ENABLED_STATE_DISABLED_USER
                || state == PackageManager.COMPONENT_ENABLED_STATE_DISABLED_UNTIL_USED) {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    /**
     * 启用下载组件
     *
     * @param context
     */
    private void enableDowaload(Context context) {
        String packageName = "com.android.providers.downloads";
        Intent intent = new Intent(android.provider.Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
        intent.setData(Uri.parse("package:" + packageName));
        context.startActivity(intent);
    }
    
    /**
     * 下载完成监听
     */
    public interface OnDownloadCompleted {
        public void onDownloadCompleted(long completeDownloadId);
    }
    
    
    OnDownloadCompleted onDownloadCompleted;
    /**
     * 下载完成监听
     */
    class DownloadCompleteReceiver extends BroadcastReceiver {
        @Override
        public void onReceive(Context context, Intent intent) {
            long completeDownloadId = intent.getLongExtra(DownloadManager.EXTRA_DOWNLOAD_ID, -1);//获取下载完成任务的id
            if (onDownloadCompleted != null) {
                onDownloadCompleted.onDownloadCompleted(completeDownloadId);//调用下载完成接口方法
            }
            //下载完成后删除id
            for (int i = 0; i < downloadIds.size(); i++) {
                if (completeDownloadId == downloadIds.get(i)) {
                    downloadIds.remove(i);
                }
            }
        }
    }
    
    DownloadCompleteReceiver downLoadCompleteReceiver;

    /**
     * 注册广播并注册监听接口
     *
     * @param onDownloadCompleted
     */
    public void registerReceiver(OnDownloadCompleted onDownloadCompleted) {
        context.registerReceiver(downLoadCompleteReceiver,
                                 new IntentFilter(DownloadManager.ACTION_DOWNLOAD_COMPLETE));
        this.onDownloadCompleted = onDownloadCompleted;
    }
    
    /**
     * 解除注册广播
     */
    public void unregisterReceiver() {
        context.unregisterReceiver(downLoadCompleteReceiver);
    }
    
    /**
     * 根据任务id打开安装界面
     *
     * @param downloadApkId
     */
    public void installApk(long downloadApkId) {
        Uri downloadFileUri = downloadManager.getUriForDownloadedFile(downloadApkId);//获取下载文件路径
        if (downloadFileUri != null) {
            install(downloadFileUri);
        }
    }
	
	
    public void install(File file) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            //判读版本是否在7.0以上
            Uri apkUri = FileProvider.getUriForFile(context, "com.StarVase.diaryTodo.provider", file);//在AndroidManifest中的android:authorities值
            Intent install = new Intent(Intent.ACTION_VIEW);
            install.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            install.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
            install.setDataAndType(apkUri, "application/vnd.android.package-archive");
            try {
                context.startActivity(install);//打开安装界面
            } catch (ActivityNotFoundException ex) {
                ex.printStackTrace();
            }
        }else{
            //以前的启动方法
            Intent install = new Intent(Intent.ACTION_VIEW);
            install.setDataAndType(Uri.fromFile(file), "application/vnd.android.package-archive");
            install.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            try {
                context.startActivity(install);//打开安装界面
            } catch (ActivityNotFoundException ex) {
                ex.printStackTrace();
            }
        }

    }
	
	public void install(Uri apkUri) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            //判读版本是否在7.0以上
            //Uri apkUri = FileProvider.getUriForFile(context, "包名.fileprovider", file);//在AndroidManifest中的android:authorities值
            Intent install = new Intent(Intent.ACTION_VIEW);
            install.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            install.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
            install.setDataAndType(apkUri, "application/vnd.android.package-archive");
            try {
                context.startActivity(install);//打开安装界面
            } catch (ActivityNotFoundException ex) {
                ex.printStackTrace();
            }
        }else{
            //以前的启动方法
            Intent install = new Intent(Intent.ACTION_VIEW);
            install.setDataAndType(apkUri, "application/vnd.android.package-archive");
            install.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            try {
                context.startActivity(install);//打开安装界面
            } catch (ActivityNotFoundException ex) {
                ex.printStackTrace();
            }
        }

    }
	
	
    /**
     * 获取当前下载的所有任务 id
     *
     * @return
     */
    public List<Long> getDownloadIds() {
        return downloadIds;
    }
    
    public DownloadUtil(Context context) {
        this.context = context;
        getService();
        downLoadCompleteReceiver = new DownloadCompleteReceiver();
        downloadIds = new ArrayList<Long>();
    }
    
    
    
}
