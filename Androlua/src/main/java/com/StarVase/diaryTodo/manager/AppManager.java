package com.StarVase.diaryTodo.manager;

/**
 * 一个Activity管理类，对所有的Activity的生命周期进行管理
 */

import android.app.Activity;
import android.app.ActivityManager;
import android.content.Context;
import androidx.appcompat.app.AppCompatActivity;
import com.StarVase.diaryTodo.app.R;
import java.util.Stack;

public class AppManager {

    private static Stack<AppCompatActivity> activityStack;
    private static AppManager instance;

    private AppManager() {
    }
    /**
     * 单一实例
     * */
    public static AppManager getAppManager() {
        if (instance == null) {
            instance = new AppManager();
        }
        return instance;
    }
    /**
     * 添加Activity到堆栈中
     * */
    public void addActivity(AppCompatActivity activity) {
        if (activityStack == null) {
            activityStack = new Stack<AppCompatActivity>();
        }
        activityStack.add(activity);
    }
    /**
     * 获取当前Activity（堆栈中最后压入的）
     * */
    public AppCompatActivity currentActivity() {
        AppCompatActivity activity = activityStack.lastElement();
        return activity;
    }
    /**
     * 结束当前Activity（堆栈中最后压入的）
     */
    public void finishActivity() {
        AppCompatActivity activity = activityStack.lastElement();
        finishActivity(activity);
    }
    /**
     * 结束指定的Activity
     * */
    public void finishActivity(AppCompatActivity activity) {
        if (activity != null) {
            activityStack.remove(activity);
            activity.finish();
            
            activity = null;
        }
    }
    /**
     * 结束指定类名的Activity
     * */
    public void finishActivity(Class<?> cls) {
        for (AppCompatActivity activity : activityStack) {
            if (activity.getClass().equals(cls)) {
                finishActivity(activity);
            }
        }
    }
    /**
     * 结束所有Activity
     * */
    public void finishAllActivity() {
        for (int i=0, size = activityStack.size(); i<size; i++) {
            if (null != activityStack.get(i)) {
                activityStack.get(i).finish();
            }
        }
        activityStack.clear();
    }
    /**
     * 彻底退出应用程序，安全退出
     * */
    public void AppExit(Context context) {
        try {
            finishAllActivity();
            ActivityManager activityManager = (ActivityManager) context
                .getSystemService(Context.ACTIVITY_SERVICE);
            activityManager.restartPackage(context.getPackageName());
            System.exit(0);
            android.os.Process.killProcess(android.os.Process.myPid());
        } catch (Exception e) {
        }
    }
}
