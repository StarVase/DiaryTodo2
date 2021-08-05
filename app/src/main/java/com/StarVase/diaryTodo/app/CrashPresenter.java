package com.StarVase.diaryTodo.app;

import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;
import com.androlua.R;
public class CrashPresenter extends AppCompatActivity {
    
	public TextView mCrashText = findViewById(R.id.crashText);
	
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
		setContentView(R.layout.layout_crash_presenter);
        Intent intent = getIntent(); 
		String data = intent.getStringExtra("crashContent");    //通过键提取数据
		mCrashText.setText(data);
	}
    
}
