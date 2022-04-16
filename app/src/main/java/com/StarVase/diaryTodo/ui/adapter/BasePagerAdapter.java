package com.StarVase.diaryTodo.ui.adapter;

import android.view.View;
import android.view.ViewGroup;
import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import androidx.viewpager.widget.PagerAdapter;
import java.util.List;

@Keep
public class BasePagerAdapter extends PagerAdapter {
    List<View> mViews;

    public BasePagerAdapter(List<View> list) {
        this.mViews = list;
    }

    @NonNull
    public Object instantiateItem(@NonNull ViewGroup viewGroup, int i) {
        viewGroup.addView((View) this.mViews.get(i));
        return this.mViews.get(i);
    }

    public void destroyItem(@NonNull ViewGroup viewGroup, int i, @NonNull Object obj) {
        viewGroup.removeView((View) this.mViews.get(i));
    }

    public int getCount() {
        return this.mViews.size();
    }

    public boolean isViewFromObject(@NonNull View view, @NonNull Object obj) {
        return view == obj;
    }
}
