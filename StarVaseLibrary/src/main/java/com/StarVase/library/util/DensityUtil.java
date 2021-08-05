package com.StarVase.library.util;

import android.content.Context;
import android.util.TypedValue;

public class DensityUtil {

	// dp2px
	public static int dp2px(Context context, int dp) {
		return (int ) TypedValue.applyDimension(TypedValue. COMPLEX_UNIT_DIP,
                   dp, context.getResources().getDisplayMetrics());

	}

	// px2dp
	public static float px2dp(Context context, int px) {
		float density = context.getResources().getDisplayMetrics().density ;
		// +0.5f为了四舍五入
		return px / density;
	}


	// sp2px
	protected int sp2px(Context context,int spVal) {
		return (int) TypedValue.applyDimension(TypedValue. COMPLEX_UNIT_SP ,
											   spVal, context.getResources().getDisplayMetrics());

	}
}
