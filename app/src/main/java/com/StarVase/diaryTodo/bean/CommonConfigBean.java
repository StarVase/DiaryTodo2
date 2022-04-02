package com.StarVase.diaryTodo.bean;

import java.io.Serializable;

public class CommonConfigBean implements Serializable {
    
    public static String path;
    
    public CommonConfigBean setPath(String mpath){
        
        path = mpath;
        
        return this;
    }
    
    public String getPath(){
        
        return path;
        
    }
    
}
