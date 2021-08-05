package com.StarVase.diaryTodo.view;
import android.content.Context;
import android.graphics.Paint;
import android.util.AttributeSet;
import android.widget.TextView;

public class DeleteLineTextView extends TextView{
    
	private boolean DELETE_LINE_STATUE=false;
	
	public DeleteLineTextView(Context context){
		super(context);
	};
    public DeleteLineTextView(Context context, AttributeSet attrs) {
	
	    super(context, attrs);
	
	}

	
    public DeleteLineTextView setDeleteline(boolean statue){
		DELETE_LINE_STATUE=statue;
		
		if (statue) {
			setPaintFlags(getPaintFlags() | Paint.STRIKE_THRU_TEXT_FLAG);
			
		}else{
			setPaintFlags(getPaintFlags() & (~Paint.STRIKE_THRU_TEXT_FLAG));
		}
		return this;
	}
}
