package com.StarVase.androluax.base;

import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;
import com.StarVase.diaryTodo.manager.AppManager;
import com.StarVase.util.OreoFixUtil;
import me.imid.swipebacklayout.lib.app.SwipeBackActivity;

public class LuaBaseActivityX extends SwipeBackActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        OreoFixUtil.hookOrientation(this);
        AppManager.getAppManager().addActivity(this);
        super.onCreate(savedInstanceState);
    }

}

