package com.StarVase.diaryTodo.util;
import com.StarVase.diaryTodo.app.DtdApplication;
import android.os.Environment;

public class PathUtil {
    
    public static String envdir = Environment.getExternalStorageDirectory().toString();
    
    public static String pkgname = DtdApplication.getInstance().getPackageName();
    
    public static String data = envdir + "/Android/data/" + pkgname + "/data/";
    public static String app = envdir + "/Android/data/" + pkgname + "/";
    public static String importeds = data + "importeds/";
    public static String diary = data + ".diary/";
    public static String todo = data + ".todo/";
    public static String favorote = data + ".favorite/";
    public static String backup = envdir + "/StarVase/DiaryTodo/backup/";
    public static String dustbin = envdir + "/StarVase/DiaryTodo/.dustbin/";
    public static String StarVase = envdir + "/StarVase/";
    public static String picture = envdir + "/Picture/DiaryTodo/";
    
    
}


