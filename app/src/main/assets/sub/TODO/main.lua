require "import"
import "android.app.*"
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
import "androidx.swiperefreshlayout.widget.SwipeRefreshLayout"

require "StarVase"(this,{enableTheme=true})
import "com.tencent.qq.widget.ReboundEffectsView"
item=importFile('TODO',"item")
importFile('TODO','function')
layout=importFile('TODO',"layout")
activity.setContentView(loadlayout(layout))
import"fab"


graph.Ripple(back,普通波纹)

adapter=LuaAdapter(this,item)
list.Adapter=adapter


--import classes
import "android.view.animation.AnimationUtils"
import "android.view.animation.LayoutAnimationController"
--create an Animation object
animation = AnimationUtils.loadAnimation(activity,android.R.anim.slide_in_left)
--get object
lac = LayoutAnimationController(animation)
-- set order
lac.setOrder(LayoutAnimationController.ORDER_NORMAL)
lac.setDelay(0.2)--unit(s)
--set Animation on listview
list.setLayoutAnimation(lac)



back.onClick=function()
  activity.finish()
end



sr.setRefreshing(false);
sr.setColorSchemeColors({icon});
sr.setOnRefreshListener(SwipeRefreshLayout.OnRefreshListener{onRefresh=function()
    Refresh()
    list.setLayoutAnimation(lac)
    sr.setRefreshing(false);
  end})



--监听list是否到顶
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
          list.setLayoutAnimation(lac)
          sr.setRefreshing(false);
        end})

     else
      sr.setEnabled(false)

    end
  end}

back.onClick=function()
  activity.finish()
end

function Refresh()
  task(getTable,nil,function(key)
    adapter.clear()
    tab=getTable()
    loading.setVisibility(View.GONE)
    -- print(dump(tab))
    for i = 1,#tab do
      date=tab[i].title
      adapter.add({title=date})
    end
  end)

end

Refresh()
list.setLayoutAnimation(lac)
list.onItemLongClick=function(id,v,zero,one)
  data=getTable()
  pop=PopupMenu(activity,v)
  menu=pop.Menu
  menu.add("挂起到通知栏").onMenuItemClick=function()
    doctitle="待办"
    doccontent=data[one].title
    notice.send(doctitle,doccontent,"todo")
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
graph.Ripple(add,淡色强调波纹)
add.onClick=function()
  输入对话框("新建","标题",date,"创建","取消",function() onEditDialogCallback(edit:getText()) 关闭对话框(an) return edit.Text end,function() 关闭对话框(an) return nil end )

  function onEditDialogCallback(edit)
    cjson=import "cjson"
    title=edit
    path="/Android/data/"..activity.getPackageName().."/data/.todo/"
    name=".todo-"..title..os.time()
    testtable={['highLight']=false,['title']=title,["data"]={},['type']="StarVaseTODO",["ts"]=os.time(),["path"]=Environment.getExternalStorageDirectory().toString()..path..name}
    json=cjson.encode(testtable)
    con=json
    file.writeFile(Environment.getExternalStorageDirectory().toString()..path..name,con)
    Refresh()
  end
end
if add then
  AutoSetToolTip(add,"新建")
end

list.onItemClick=function(id,v,zero,one)
  data=getTable()
  sub("detailTODO",data[one].path,data[one].title)
  return true
end

function onResume()
  Refresh()
end
