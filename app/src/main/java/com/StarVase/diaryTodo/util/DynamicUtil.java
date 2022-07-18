package com.StarVase.diaryTodo.util;

import android.content.res.ColorStateList;

public class DynamicUtil {
    
    
    public static ColorStateList createColorStateList(int pressed, int normal) {
        //状态
        int[][] states = new int[2][];
        //按下
        states[0] = new int[] {android.R.attr.state_pressed};
        //默认
        states[1] = new int[] {};

        //状态对应颜色值（按下，默认）
        int[] colors = new int[] { pressed, normal};
        ColorStateList colorList = new ColorStateList(states, colors);
        return colorList;
    }
    
    public static int[][] create2dArray(int a,int b) {
        int[][] x = new int[a][b];
        return x;
    }

    public static int[][][] create3dArray(int a,int b,int c) {
        int[][][] x = new int[a][b][c];
        return x;
    }
    
}
