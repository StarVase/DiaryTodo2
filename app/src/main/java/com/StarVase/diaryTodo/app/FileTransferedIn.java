package com.StarVase.diaryTodo.app;

import android.content.ContentValues;
import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.AppCompatTextView;
import com.StarVase.diaryTodo.bean.CommonConfigBean;
import com.StarVase.diaryTodo.util.DatabaseUtil;
import java.io.File;
import java.io.Serializable;

public class FileTransferedIn extends AppCompatActivity implements Serializable{

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Intent intent=getIntent();
        Uri uri=intent.getData();
        final String path = uri.getPath(); 
        AppCompatTextView textView =new AppCompatTextView(this);
        textView.setText(path);
        setContentView(textView);
        new Handler().postDelayed(new Runnable(){

                @Override
                public void run() {
                    openFile(path);
                    finish();
                }
            }, 100);
    }

    private void openFile(String path) {
        int id;
        String sql="select * from markdown WHERE path=? ORDER BY id DESC";
        Cursor cursor = DatabaseUtil.raw(sql, new String[] {path});
        if (cursor.moveToFirst()) {
            id = cursor.getInt(0);
            ContentValues values = new ContentValues();
            values.put("path", path);
            values.put("timestamp", String.valueOf((int) (System.currentTimeMillis() / 1000)));
            DatabaseUtil.getDatabase().update("markdown", values, "id=?", new String[] {String.valueOf(id)});

        } else {
            CommonConfigBean config = new CommonConfigBean();
            config.setPath(path);
            DatabaseUtil.markdownToDb(config);
        }
        jumpToEditor(path);
    }

    private void jumpToEditor(String docpath) {
        CommonConfigBean config = new CommonConfigBean();
        config.setPath(docpath);
        
        String path = DtdApplication.getInstance().getSharedData("BaseLuaPath") + "/sub/notepad/main.lua";
        Object[] arg = {"markdownX",new File(docpath).getName(), config};
        Intent intent = new Intent(this, BaseActivity.class);
        intent.putExtra("name", path);
        intent.setData(Uri.parse("file://" + path));
        intent.putExtra("arg", arg);
        startActivity(intent);

    }

}
