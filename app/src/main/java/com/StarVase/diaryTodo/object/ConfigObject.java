package com.StarVase.diaryTodo.object;

import java.io.Serializable;

public class ConfigObject implements Serializable {
    
    public static String path;
    
    public ConfigObject setPath(String mpath){
        
        path = mpath;
        
        return this;
    }
    
    public String getPath(){
        
        return path;
        
    }
    
}
