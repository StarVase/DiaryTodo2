require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "StarVase"
import "com.tencent.qq.widget.ReboundEffectsView"
item=importFile('detailTODO',"item")
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
import "androidx.swiperefreshlayout.widget.SwipeRefreshLayout"

importFile('detailTODO',"function")
layout=importFile('detailTODO',"layout")

filename,titlein=...
getTable(filename)

activity.setContentView(loadlayout(layout))
import"fab"
if title then
  title.setText(titlein)
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

back.onClick=function()
  activity.finish()
end



sr.setRefreshing(false);
sr.setColorSchemeColors({icon});
sr.setOnRefreshListener(SwipeRefreshLayout.OnRefreshListener{onRefresh=function()
    Refresh(filename)
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
          Refresh(filename)
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

data = {}

function Refresh(filename)
  task(getTable,filename,function(key)
    adapter.clear()

    tab=getTable(filename)
    loading.setVisibility(View.GONE)
    tab=tab.data
    for i = 1,#tab do
      date=TrueAndFalseColor(tab[i].highLight,tab[i].title)
      istrue=tab[i].istrue
      highLight=tab[i].highLight
      ts=math.ts2t(tonumber(tab[i].timestamp))
      adapter.add({title=date,status={Checked=Boolean.valueOf(istrue)}})
    end
  end)
end

Refresh(filename)
list.setLayoutAnimation(lac)
list.onItemLongClick=function(id,v,zero,one)


  function highLight(word)
    return MyTextStyle.TextColor(word,0,utf8.len(word),0xFFF44336)
    --return word
  end
  data=getTable()
  pop=PopupMenu(activity,v)
  menu=pop.Menu
  menu.add("编辑内容").onMenuItemClick=function()
    tab=getTable(filename)
    if not tab.data[one].content then
      tab.data[one].content="内容"
    end
    save_as_json(tab,filename)
    Refresh(filename)
    sub("notepad","todo",getTable(filename).data[one].title,one,nil,getTable(filename).data[one].content)
  end
  menu.add("重命名").onMenuItemClick=function()

    输入对话框("重命名","标题",getTable(filename).data[one].title,"确定","取消",function() onEditDialogCallback(edit.Text) 关闭对话框(an) return edit.Text end,function() 关闭对话框(an) return nil end )

    function onEditDialogCallback(edit)
      tab=getTable(filename)
      tab.data[one].title=edit
      save_as_json(tab,filename)
      Refresh(filename)
    end
  end
  menu.add("强调显示").onMenuItemClick=function()
    tab=getTable(filename)
    old=tab.data[one].highLight
    if old == true then new=false else new=true end
    tab.data[one].highLight=new
    save_as_json(tab,filename)
    Refresh(filename)

  end


  menu.add(highLight("删除")).onMenuItemClick=function()
    双按钮对话框('删除','删除之后不能恢复,你确定要删除吗？','确定','取消',function()
      tab=getTable(filename)
      table.remove(tab.data,one)
      save_as_json(tab,filename)
      Refresh(filename) 关闭对话框(an)
    end,function()
      关闭对话框(an)
    end)
  end

  pop.show()
  return true
end
if add then
  AutoSetToolTip(add,"新建")
end
graph.Ripple(add,淡色强调波纹)
add.onClick=function()
  输入对话框("新建","标题",date,"创建","取消",function() onEditDialogCallback(edit:getText()) 关闭对话框(an) return edit.Text end,function() 关闭对话框(an) return nil end )

  function onEditDialogCallback(edit)
    tab=getTable(filename)
    tosettable={}
    tosettable.title=edit
    tosettable.timestamp=os.time()
    tosettable.istrue=false
    tosettable.highLight=false
    table.insert(tab.data,tosettable)
    save_as_json(tab,filename)
    Refresh(filename)
  end
end


list.onItemClick=function(id,v,zero,one)

  if v.Tag.status ~= nil then
    if v.Tag.status.Checked then
      set_check_box(one,false,filename)
     else
      set_check_box(one,true,filename)
    end
   else

  end
  Refresh(filename)
end

function onResult(...)
  path,one,title,con=...
  if path == "sub/notepad/main" then
    tab=getTable(filename)
    tab.data[one].title=title
    tab.data[one].content=con
    save_as_json(tab,filename)
    Refresh(filename)
  end
end

function onResume()
  Refresh(filename)
end

function set_check_box(one,value,filename)
  tab=getTable(filename)
  tab.data[one].istrue=value
  save_as_json(tab,filename)
end
