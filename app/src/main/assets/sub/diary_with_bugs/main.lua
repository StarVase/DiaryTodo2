require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
require "StarVase"(this,{enableTheme=true})
item=importFile('diary',"item")
--import "muk"
--删掉“--”注释符号以使用中文函数


--https://opendata.baidu.com/data/inner?tn=reserved_all_res_tn&dspName=iphone&from_sf=1&dsp=iphone&resource_id=28565&alr=1&query=%E8%82%BA%E7%82%8E

require "import"
--import 'BaseFunlib'
import "android.app.*"
--import "com.nirenr.Color"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.text.*"
import "android.content.Intent"
import "android.net.Uri"
import "android.provider.*"
import "com.StarVase.diaryTodo.app.LuaAdapter"
import "android.graphics.drawable.BitmapDrawable"
import "android.graphics.Color"
import "android.support.v7.widget.*"
import "android.graphics.*"
import "android.renderscript.*"
import "android.graphics.drawable.*"
import "android.support.v4.widget.*"
--import "android.support.v7.widget.RecyclerView.LayoutManager"
--import "com.LuaRecyclerAdapter"
--import "com.LuaRecyclerHolder"
--import "com.AdapterCreator"
--MyRecyclerAdapter=importFile('diary',"MyRecyclerAdapter")
importFile('diary',"function")
layout=importFile('diary',"layout")

activity.setContentView(loadlayout(layout))
import "fab"
graph.Ripple(back,普通波纹)

--print(RecyclerView)


back.onClick=function()
  activity.finish()
end


--[[recy=list
adapter=MyRecyclerAdapter.diary()
recy.setLayoutManager(StaggeredGridLayoutManager(2,StaggeredGridLayoutManager.VERTICAL))
recy.setAdapter(adapter)



]]

sr.setRefreshing(false);
sr.setColorSchemeColors({icon});
sr.setOnRefreshListener(SwipeRefreshLayout.OnRefreshListener{onRefresh=function()
    Refresh()
    sr.setRefreshing(false);
    list.setLayoutAnimation(lac)
  end})


RecycleScrollListener().setOnScrollStateListener( RcycleScrollListener.OnScrollStateListener() {

  function scrollState( isScrlling)
    if(isScrolling) then
      ToastUtil.shortShow("正在滑动");
      LogUtil.i("======正在滑动======");
     else
      ToastUtil.shortShow("未滑动");
      LogUtil.i("======未滑动======");
    end
  end
});








--list.addOnScrollListener(
--[[list.setOnScrollListener {

  function onScrollChanged(recyclerView,dx,dy)
    --super.onScrolled(recyclerView, dx, dy);
    -- manager = recyclerView.getLayoutManager()
    --if (manager ~= nil) then

    --firstPosition = (manager).findFirstVisibleItemPosition();

    if (dy<0) then
      --上滑监听
      --topBar.setVisibility(firstPosition>1 ? View.VISIBLE : View.GONE);
     else
      --下滑监听
      --topBar.setVisibility(firstPosition==0 ? View.GONE : View.VISIBLE);
    end
  end
}]]
--[[监听list是否到顶
list.setOnScrollListener{
  onScrollStateChanged=function(l,s)
    if list.getFirstVisiblePosition()==0 then
      --事件
      --print('到顶')
      --到顶了
      sr.setEnabled(true)
      sr.setRefreshing(false);
      sr.setColorSchemeColors({icon});
      sr.setOnRefreshListener(SwipeRefreshLayout.OnRefreshListener{onRefresh=function()
          --jsong()
          Refresh()
          sr.setRefreshing(false);
          list.setLayoutAnimation(lac)
        end})

     else
      sr.setEnabled(false)

    end
  end}

back.onClick=function()
  activity.finish()
end
]]



function Refresh()
  --[[ task(getTable,nil,function(key)
    adapter.clear()
    tab=getTable()
    loading.setVisibility(View.GONE)
    --print(dump(tab))
    for i = 1,#tab do
      date=tab[i].date.year.."."..tab[i].date.month.."."..tab[i].date.day

      filename=tab[i].file_name
      enc=tab[i].enc
      content=tab[i].content
      if enc==true then
        img='images/lock.png'
       else img='images/unlock.png'
      end
      adapter.add({title=date,image=img})
    end
  end)]]
end
Refresh()







--[[
list.onItemLongClick=function(id,v,zero,one)
  data=getTable()
  pop=PopupMenu(activity,v)
  menu=pop.Menu

  menu.add("挂起到通知栏").onMenuItemClick=function()
    doctitle="日记"
    doccontent=data[one].date.year.."."..data[one].date.month.."."..data[one].date.day
    notice.send(doctitle,doccontent,"diary")
  end

  menu.add(highLight("删除")).onMenuItemClick=function()
    双按钮对话框('删除','删除之后不能恢复,你确定要删除吗？','确定','取消',function()
      pcall(function() os.remove(data[one].path) end)
      Refresh()
      关闭对话框(an)
    end,function()
      关闭对话框(an)
    end)

  end
  pop.show()
  return true
end
]]
graph.Ripple(add,淡色强调波纹)
add.onClick=function()
  date=os.date("%y.%m.%d")
  输入对话框("新建","日期",date,"创建","取消",function() onEditDialogCallback(edit.Text) 关闭对话框(an) return edit.Text end,function() 关闭对话框(an) return nil end )

  function onEditDialogCallback(edit)
    tab=getTable()
    if activity.getSharedData("日记加密")==true and pcall(function() minicrypto.encrypt("日记新建成功",activity.getSharedData('diaryRC4PSK'))end) then
      encstr="<enc=true>"
      addcon=minicrypto.encrypt("日记新建成功",activity.getSharedData('diaryRC4PSK'))
      check=minicrypto.encrypt("Diary-enced",activity.getSharedData('diaryRC4PSK'))

     else
      encstr="<enc=false>"
      addcon=""
      check="Diary-enced"
    end
    path="/Android/data/"..activity.getPackageName().."/data/.diary/"
    name=".diary-"..os.time()..edit
    con=[[<docType=StarVase_diary>
]]..encstr..[[<date>]]..edit..[[</date>
<content>>]]..addcon..[[<</content>
<check>]]..check..[[</check>
]]
    file.writeFile(Environment.getExternalStorageDirectory().toString()..path..name,con)
    Refresh()
  end
end
if add then
  AutoSetToolTip(add,"新建")
end
--[[
list.onItemClick=function(id,v,zero,one)
  data=getTable()
  sub("notepad",'diary',data[one].date.year.."."..data[one].date.month.."."..data[one].date.day,data[one].path,data[one].PATH,data[one].content,data[one].enc,data[one].check)
  return true
end
]]

function onResume()
  Refresh()
end