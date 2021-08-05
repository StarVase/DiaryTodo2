package com.StarVase.library.adapter;

import android.annotation.SuppressLint;
import android.content.res.Resources;
import android.graphics.drawable.Drawable;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.ImageView;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.fragment.app.FragmentActivity;
import androidx.recyclerview.widget.RecyclerView;
import com.StarVase.diaryTodo.app.LuaContext;
import com.bumptech.glide.Glide;
import com.luajava.LuaFunction;
import com.luajava.LuaJavaAPI;
import com.luajava.LuaObject;
import com.luajava.LuaState;
import com.luajava.LuaTable;
import java.io.File;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

public class LuaRecyclerAdapter extends RecyclerView.Adapter<LuaRecyclerAdapter.LuaViewHolder> implements Filterable {
    private LuaState L;
    private LuaFunction<?> insert;
    private HashMap<String, Boolean> loaded;
    private LuaFunction<View> loadlayout;
    private AdapterInterface mAdapterInterface;
    private HashMap<View, Animation> mAnimCache;
    private LuaFunction<Animation> mAnimationUtil;
    private String mClickViewId;
    private LuaTable<Integer, LuaTable<String, Object>> mData;
    private Drawable mDraw;
    private ArrayFilter mFilter;
    //private FusionApp mFusionApp;
    @SuppressLint({"HandlerLeak"})
    private final Handler mHandler;
    private LuaTable mLayout;
    private LuaFunction mLuaFilter;
    private LuaContext mLuaSupport;
    private boolean mNotifyOnChange;
    private OnItemClickListener mOnItemClickListener;
    private OnItemLongClickListener mOnItemLongClickListener;
    private CharSequence mPrefix;
    private Resources mRes;
    private HashMap<View, Boolean> mStyleCache;
    private LuaTable<String, Object> mTheme;
    private LuaFunction<?> remove;
    private boolean updateing;

    public interface AdapterInterface {
        void onBindViewHolder(LuaViewHolder luaViewHolder, int i2);
    }

    /* access modifiers changed from: private */
    public class ArrayFilter extends Filter {
        private ArrayFilter() {
        }

        /* access modifiers changed from: protected */
        public Filter.FilterResults performFiltering(CharSequence charSequence) {
            Filter.FilterResults filterResults = new Filter.FilterResults();
            LuaRecyclerAdapter.this.mPrefix = charSequence;
            if (LuaRecyclerAdapter.this.mData == null) {
                return filterResults;
            }
            if (LuaRecyclerAdapter.this.mLuaFilter != null) {
                LuaRecyclerAdapter.this.mHandler.sendEmptyMessage(1);
                return null;
            }
            filterResults.values = LuaRecyclerAdapter.this.mData;
            filterResults.count = LuaRecyclerAdapter.this.mData.size();
            return filterResults;
        }

        /* access modifiers changed from: protected */
        public void publishResults(CharSequence charSequence, Filter.FilterResults filterResults) {
        }
    }

    /* access modifiers changed from: package-private */
    public static class LuaViewHolder extends RecyclerView.ViewHolder {
        public LuaObject tag;

        public LuaViewHolder(View view) {
            super(view);
        }

        public LuaObject getTag() {
            return this.tag;
        }

        public void setTag(LuaObject luaObject) {
            this.tag = luaObject;
        }
    }

    public interface OnItemClickListener {
        void onItemClick(LuaRecyclerAdapter luaRecyclerAdapter, View view, View view2, int i2);
    }

    public interface OnItemLongClickListener {
        boolean onItemLongClick(LuaRecyclerAdapter luaRecyclerAdapter, View view, View view2, int i2);
    }

    public LuaRecyclerAdapter(LuaContext context, LuaTable luaTable) {
        this(context, null, luaTable);
    }

    /* access modifiers changed from: private */
    /* renamed from: c */
    public /* synthetic */ void d(LuaViewHolder luaViewHolder, View view) {
        OnItemClickListener onItemClickListener = this.mOnItemClickListener;
        if (onItemClickListener != null) {
            onItemClickListener.onItemClick(this, luaViewHolder.itemView, view, luaViewHolder.getAdapterPosition());
        }
    }

    /* access modifiers changed from: private */
    /* renamed from: e */
    public /* synthetic */ boolean f(LuaViewHolder luaViewHolder, View view) {
        OnItemLongClickListener onItemLongClickListener = this.mOnItemLongClickListener;
        return onItemLongClickListener != null && onItemLongClickListener.onItemLongClick(this, luaViewHolder.itemView, view, luaViewHolder.getAdapterPosition());
    }

    private int javaSetListener(Object obj, String str, Object obj2) {
        Iterator<Method> it2 = LuaJavaAPI.getMethod(obj.getClass(), "setOn" + str.substring(2) + "Listener", false).iterator();
        while (it2.hasNext()) {
            Method next = it2.next();
            Class<?>[] parameterTypes = next.getParameterTypes();
            if (parameterTypes.length == 1 && parameterTypes[0].isInterface()) {
                this.L.newTable();
                this.L.pushObjectValue(obj2);
                this.L.setField(-2, str);
                try {
                    next.invoke(obj, this.L.getLuaObject(-1).createProxy(parameterTypes[0]));
                    return 1;
                } catch (Exception e2) {
                    //throw new LuaException(e2);
                }
            }
        }
        return 0;
    }

    private int javaSetMethod(Object obj, String str, Object obj2) {
        if (Character.isLowerCase(str.charAt(0))) {
            str = Character.toUpperCase(str.charAt(0)) + str.substring(1);
        }
        Class<?> cls = obj2.getClass();
        StringBuilder sb = new StringBuilder();
        Iterator<Method> it2 = LuaJavaAPI.getMethod(obj.getClass(), "set" + str, false).iterator();
        while (it2.hasNext()) {
            Method next = it2.next();
            Class<?>[] parameterTypes = next.getParameterTypes();
            if (parameterTypes.length == 1) {
                if (parameterTypes[0].isPrimitive()) {
                    try {
                        if (!(obj2 instanceof Double)) {
                            if (!(obj2 instanceof Float)) {
                                if (!(obj2 instanceof Long)) {
                                    if (!(obj2 instanceof Integer)) {
                                        if (obj2 instanceof Boolean) {
                                            next.invoke(obj, (Boolean) obj2);
                                            return 1;
                                        }
                                    }
                                }
                                next.invoke(obj, LuaState.convertLuaNumber(Long.valueOf(((Number) obj2).longValue()), parameterTypes[0]));
                                return 1;
                            }
                        }
                        next.invoke(obj, LuaState.convertLuaNumber(Double.valueOf(((Number) obj2).doubleValue()), parameterTypes[0]));
                        return 1;
                    } catch (Exception e2) {
                        sb.append(e2.getMessage());
                        sb.append("\n");
                    }
                } else if (!parameterTypes[0].isAssignableFrom(cls)) {
                    continue;
                } else {
                    try {
                        next.invoke(obj, obj2);
                        return 1;
                    } catch (Exception e3) {
                        sb.append(e3.getMessage());
                        sb.append("\n");
                    }
                }
            }
        }
      return 1;
    }

    private int javaSetter(Object obj, String str, Object obj2) {
        if (str.length() <= 2 || !str.substring(0, 2).equals("on") || !(obj2 instanceof LuaFunction)) {
            return javaSetMethod(obj, str, obj2);
        }
        return javaSetListener(obj, str, obj2);
    }

    private void setFields(View view, LuaTable<String, Object> luaTable) {
        for (Map.Entry<String, Object> entry : luaTable.entrySet()) {
            String key = entry.getKey();
            Object value = entry.getValue();
            if (key.toLowerCase().equals("src")) {
                setHelper(view, value);
            } else {
                javaSetter(view, key, value);
            }
        }
    }

    private void setHelper(View view, Object obj) {
        try {
            if (obj instanceof LuaTable) {
                setFields(view, (LuaTable) obj);
            } else if (view instanceof TextView) {
                if (obj instanceof CharSequence) {
                    ((TextView) view).setText((CharSequence) obj);
                } else {
                    ((TextView) view).setText(obj.toString());
                }
            } else if (view instanceof ImageView) {
                ImageView imageView = (ImageView) view;
                if (obj instanceof Number) {
                    imageView.setImageResource(((Number) obj).intValue());
                    return;
                }
                if (!(obj instanceof String)) {
                    if (!(obj instanceof File)) {
                        Glide.with(this.mLuaSupport.getContext()).load(obj).into(imageView);
                        return;
                    }
                }
                String valueOf = String.valueOf(obj);
                if (valueOf.startsWith("/") && this.mLuaSupport != null) {
                    File file = new File(this.mLuaSupport.getLuaDir() + valueOf);
                    //File file2 = new File(this.mFusionApp.getLoader().getImagesDir(valueOf));
                    if (file.exists()) {
                        valueOf = file.getAbsolutePath();
                    } 
                }
                Glide.with((FragmentActivity) this.mLuaSupport.getContext()).load(valueOf).into(imageView);
            }
        } catch (Exception e2) {
            this.mLuaSupport.sendError("setHelper", e2);
        }
    }

    public void add(LuaTable<String, Object> luaTable) {
        this.insert.call(this.mData, luaTable);
        if (this.mNotifyOnChange) {
            notifyDataSetChanged();
        }
    }

    public void addAll(LuaTable<Integer, LuaTable<String, Object>> luaTable) {
        int length = luaTable.length();
        for (int i2 = 1; i2 <= length; i2++) {
            this.insert.call(this.mData, luaTable.get(Integer.valueOf(i2)));
        }
        if (this.mNotifyOnChange) {
            notifyDataSetChanged();
        }
    }

    public void chageData() {
        super.notifyDataSetChanged();
        if (!this.updateing) {
            this.updateing = true;
            new Handler().postDelayed(new Runnable() {
                    /* class com.androlua.LuaRecyclerAdapter.AnonymousClass1 */

                    public void run() {
                        LuaRecyclerAdapter.this.updateing = false;
                    }
                }, 500);
        }
    }

    public void clear() {
        this.mData.clear();
        if (this.mNotifyOnChange) {
            notifyDataSetChanged();
        }
    }

    public void filter(CharSequence charSequence) {
        getFilter().filter(charSequence);
    }

    public LuaTable<Integer, LuaTable<String, Object>> getData() {
        return this.mData;
    }

    public Filter getFilter() {
        if (this.mFilter == null) {
            this.mFilter = new ArrayFilter();
        }
        return this.mFilter;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.Adapter
    public int getItemCount() {
        return this.mData.length();
    }

    @Override // androidx.recyclerview.widget.RecyclerView.Adapter
    public long getItemId(int i2) {
        return (long) (i2 + 1);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.Adapter
    public int getItemViewType(int i2) {
        return i2;
    }

    public void insert(int i2, LuaTable<String, Object> luaTable) {
        this.insert.call(this.mData, Integer.valueOf(i2 + 1), luaTable);
        if (this.mNotifyOnChange) {
            chageData();
        }
    }

    public void remove(int i2) {
        this.remove.call(this.mData, Integer.valueOf(i2 + 1));
        if (this.mNotifyOnChange) {
            notifyDataSetChanged();
        }
    }

    public void setAdapterInterface(AdapterInterface adapterInterface) {
        this.mAdapterInterface = adapterInterface;
    }

    public void setAnimation(LuaFunction<Animation> luaFunction) {
        setAnimationUtil(luaFunction);
    }

    public void setAnimationUtil(LuaFunction<Animation> luaFunction) {
        this.mAnimCache.clear();
        this.mAnimationUtil = luaFunction;
    }

    public void setClickViewId(String str) {
        this.mClickViewId = str;
    }

    public void setFilter(LuaFunction luaFunction) {
        this.mLuaFilter = luaFunction;
    }

    public void setNotifyOnChange(boolean z) {
        this.mNotifyOnChange = z;
        if (z) {
            notifyDataSetChanged();
        }
    }

    public void setOnItemClickListener(OnItemClickListener onItemClickListener) {
        this.mOnItemClickListener = onItemClickListener;
    }

    public void setOnItemLongClickListener(OnItemLongClickListener onItemLongClickListener) {
        this.mOnItemLongClickListener = onItemLongClickListener;
    }

    public void setStyle(LuaTable<String, Object> luaTable) {
        this.mStyleCache.clear();
        this.mTheme = luaTable;
    }

    /* JADX DEBUG: Type inference failed for r3v7. Raw type applied. Possible types: com.luajava.LuaFunction<?>, com.luajava.LuaFunction<android.view.View> */
    public LuaRecyclerAdapter(LuaContext context, LuaTable<Integer, LuaTable<String, Object>> luaTable, LuaTable luaTable2) {
        this.loaded = new HashMap<>();
        this.mStyleCache = new HashMap<>();
        this.mAnimCache = new HashMap<>();
        this.mNotifyOnChange = true;
        this.mClickViewId = null;
        this.mHandler = new Handler() {
            /* class com.androlua.LuaRecyclerAdapter.AnonymousClass2 */

            public void handleMessage(Message message) {
                if (message.what == 0) {
                    LuaRecyclerAdapter.this.notifyDataSetChanged();
                    return;
                }
                try {
                    LuaTable luaTable = new LuaTable(LuaRecyclerAdapter.this.mData.getLuaState());
                    LuaRecyclerAdapter.this.mLuaFilter.call(LuaRecyclerAdapter.this.mData, luaTable, LuaRecyclerAdapter.this.mPrefix);
                    LuaRecyclerAdapter.this.mData = luaTable;
                    LuaRecyclerAdapter.this.notifyDataSetChanged();
                } catch (Exception e2) {
                    e2.printStackTrace();
                    LuaRecyclerAdapter.this.mLuaSupport.sendError("performFiltering", e2);
                }
            }
        };
        
        LuaContext luaSupport = context;
        this.mLuaSupport = luaSupport;
        this.mLayout = luaTable2;
        this.mRes = luaSupport.getContext().getResources();
        //this.mDraw = ContextCompat.getDrawable(luaSupport.getContext(), R.drawable.ic_error_red_32dp);
        LuaState luaState = this.mLuaSupport.getLuaState();
        this.L = luaState;
        this.mData = luaTable == null ? new LuaTable<>(luaState) : luaTable;
        this.loadlayout = (LuaFunction<View>) this.L.getLuaObject("loadlayout").getFunction();
        this.insert = this.L.getLuaObject("table").getField("insert").getFunction();
        this.remove = this.L.getLuaObject("table").getField("remove").getFunction();
        this.L.newTable();
        this.loadlayout.call(this.mLayout, this.L.getLuaObject(-1), ViewGroup.class);
        this.L.pop(1);
    }

    @NonNull
    @Override
    public LuaViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        LuaObject holder;
        View view;
        L.newTable();
        holder = L.getLuaObject(-1);
        L.pop(1);

        view = loadlayout.call(mLayout.get(viewType+1), holder, RecyclerView.class);

        return new LuaViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull LuaViewHolder holder, int position) {

        LuaObject tag= holder.tag;

        LuaTable<String, Object> hm = mData.get(position + 1);

        if (hm == null) {
            Log.i("lua", position + " is null");
            return;
        }


        Set<Map.Entry<String, Object>> sets = hm.entrySet();
        for (Map.Entry<String, Object> entry : sets) {
            try {
                String key = entry.getKey();
                Object value = entry.getValue();
                LuaObject obj = tag.getField(key);
                if (obj.isJavaObject()) {
                    setHelper((View) obj.getObject(), value);
                }
            } catch (Exception e) {
                Log.i("lua", e.getMessage());
            }
        }



    }
}

