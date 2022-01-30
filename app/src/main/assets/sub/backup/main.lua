require "import"
require "StarVase"(this,{enableTheme=true})
--import "com.tencent.qq.widget.ReboundEffectsView"
ReboundEffectsView=ListView
item=importFile('backup',"item")
import "android.support.v4.widget.*"
importFile('backup',"function")
layout=importFile('backup',"layout")



activity.setContentView(loadlayout(layout))
--import"fab"

if add then
  AutoSetToolTip(add,"新建")
end

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



sr.setRefreshing(false);
sr.setColorSchemeColors({icon});
sr.setOnRefreshListener(SwipeRefreshLayout.OnRefreshListener{onRefresh=function()
    Refresh()
    sr.setRefreshing(false);
    list.setLayoutAnimation(lac)
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
          sr.setRefreshing(false);
          list.setLayoutAnimation(lac)
        end})

     else
      sr.setEnabled(false)

    end
  end}
function Refresh()
  task(getTable,nil,function(key)
    adapter.clear()
    tab=getTable()
    loading.setVisibility(View.GONE)
    for i = 1,#tab do
      date=tab[i].title
      filename=tab[i].file_name
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


  menu.add(highLight("删除")).onMenuItemClick=function()
    双按钮对话框('删除','删除之后不能恢复,你确定要删除吗？','确定','取消',function()
      pcall(function() os.remove(data[one].path) end)
      Refresh()

      关闭对话框(an)
    end,function()
      关闭对话框(an)
      Refresh()

    end)
  end

  pop.show()
  return true
end
graph.Ripple(add,淡色强调波纹)
add.onClick=function()
  backup.backupnow()
  Refresh()
end


list.onItemClick=function(id,v,zero,one)
  data=getTable()
  双按钮对话框('恢复','确定恢复吗？','确定','取消',function()
    pcall(function()
      backup.backupnow()
      backup.unbackup(data[one].path)
    end)
    Refresh()
    关闭对话框(an)
  end)

  return true
end

function onResume()
  Refresh()
end