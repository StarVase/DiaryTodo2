package com.StarVase.diaryTodo.helper;

import android.annotation.SuppressLint;
import android.graphics.Rect;
import android.os.Build;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnTouchListener;

public class TouchEffectHelper {

    private float MAX_CLICK_ZOOM_FACTOR = 0.8f;
    
    /**

     * 设置点击放大效果。

     */

    public void setClickEffect(View view, final float scale, final long duration) {
        
        if (view != null) {

            view.setOnTouchListener(new OnTouchListener() {
                    public boolean onTouch(View v, MotionEvent event) {
                        switch (event.getAction()) {
                            case (MotionEvent.ACTION_DOWN) :
                                v.animate().scaleX(scale).scaleY(scale).setDuration(duration).start();
                                break;
                            case (MotionEvent.ACTION_UP) :
                            case (MotionEvent.ACTION_CANCEL) :
                                v.animate().scaleX(1f).scaleY(1f).setDuration(duration).start();
                                break;
                            
                        }
                        return false;
                    }
            });
        }
  
    }
     
    public void setClickZoomEffect(final View view) {

        if (view != null) {

            view.setOnTouchListener(new OnTouchListener() {

                    boolean cancelled;

                    Rect rect = new Rect();

                    @Override

                    public boolean onTouch(View v, MotionEvent event) {

                        switch (event.getAction()) {

                            case MotionEvent.ACTION_DOWN:

                                scaleTo(v, MAX_CLICK_ZOOM_FACTOR);

                                break;

                            case MotionEvent.ACTION_MOVE:

                                if (rect.isEmpty()) {

                                    v.getDrawingRect(rect);

                                }

                                if (!rect.contains((int) event.getX(), (int) event.getY())) {

                                    scaleTo(v, 1);

                                    cancelled = true;

                                }

                                break;

                            case MotionEvent.ACTION_UP:

                            case MotionEvent.ACTION_CANCEL: {

                                    if (!cancelled) {

                                        scaleTo(v, 1);

                                    } else {

                                            cancelled = false;

                                    }

                                    break;

                                }

                        }

                        return false;

                    }

                });

        }

    }

    /**

     * 对view进行缩放。

     */

    @SuppressLint("NewApi")

    public static void scaleTo(View v, float scale) {

        if (Build.VERSION.SDK_INT >= 11) {

            v.setScaleX(scale);

            v.setScaleY(scale);

        } else {

            float oldScale = 1;

            if (v.getTag(Integer.MIN_VALUE) != null) {

                    oldScale = (Float) v.getTag(Integer.MIN_VALUE);

            }

            
            v.getLayoutParams().width = (int) ((v.getLayoutParams().width / oldScale) * scale);

            v.getLayoutParams().height = (int) ((v.getLayoutParams().height / oldScale) * scale);

            v.setTag(Integer.MIN_VALUE, scale);

        }

    }
    
    

       
}
