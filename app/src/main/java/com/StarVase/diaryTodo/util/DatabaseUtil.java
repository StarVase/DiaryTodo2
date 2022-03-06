package com.StarVase.diaryTodo.util;

import android.content.ContentValues;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import com.StarVase.diaryTodo.object.ConfigObject;
import java.io.File;

public class DatabaseUtil {

    public static SQLiteDatabase getDatabase() {
        new File(PathUtil.data + "database/").mkdirs();
        SQLiteDatabase db = SQLiteDatabase.openOrCreateDatabase(PathUtil.data + "database/data.db", null);
        return db;
    }

    public static void exec(String sql) {
        getDatabase().execSQL(sql);
    }

    public static Cursor raw(String sql, String[] text) {
        Cursor cursor = getDatabase().rawQuery(sql, text);
        return cursor;
    }

    public static boolean isTabbleExist(String tableName) {
        boolean result = false;

        if (tableName == null) {
            return false;
        }

        Cursor cursor;

        try {
            String sql = "select count(*) as c from Sqlite_master  where type ='table' and name ='"+tableName.trim()+"' ";
            cursor = raw(sql, null);
            if (cursor.moveToNext()) {
                int count = cursor.getInt(0);
                if (count > 0) {
                    result = true;
                }
            }
        } finally {}

        return result;

    }

    public static int markdownToDb(ConfigObject config) {
        SQLiteDatabase db = getDatabase();

        String filepath = config.getPath();
        int targetId = -1;
        ContentValues values = new ContentValues();
        values.put("path", filepath);
        values.put("timestamp", String.valueOf(((int)(System.currentTimeMillis() / 1000))));
        db.insert("markdown", null, values);

        Cursor cursor=raw("select max(id) from markdown", null);
        if (cursor.moveToFirst()) {
            targetId = cursor.getInt(0);
        }
        return targetId;
    }



}
