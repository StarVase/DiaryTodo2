require "import"
require "StarVase"(this,{enableTheme=true})
import "UiHelper"
todoid=...


list.onItemLongClick=function(id,v,zero,one)
  id=data[one].id

  pop=PopupMenu(activity,v)
  menu=pop.Menu
  menu.add("删除").onMenuItemClick=function()
    delete(id)
  end
  pop.show()
  return true
end



fab.onClick=function()
  task(1,function()

    import "com.google.android.material.bottomsheet.BottomSheetDialog"

    local dann=import "layout.add_dialog"

    dl=BottomSheetDialog(activity)
    dl.setContentView(loadlayout(dann))
    an=dl.show()
    bottom = dl.findViewById(R.id.design_bottom_sheet);
    if (bottom != nil) then
      bottom
      .setBackgroundResource(android.R.color.transparent)
      .setPadding(math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(32))
    end

    okey.onClick=function()
      if edit.getText() then
        --tab=getTable(content)
        tosettable={}
        tosettable.title=tostring(edit.getText())
        tosettable.timestamp=os.time()
        tosettable.istrue=false
        tosettable.highLight=false
        tosettable.highLightColor=0
        table.insert(tab,tosettable)

        save_as_json(tab,todoid)
        task(1,lambda->Refresh(todoid))
        MyToast.showSnackBar("Done")
      end
      dl.dismiss()
    end
    cancel.onClick=lambda -> dl.dismiss()
    --新建对话框(bt,nr,text,qd,qx,qdnr,qxnr,gb)
  end)
end



list.onItemClick=function(id,v,zero,one)
  id=data[one].id
  sql="select * from inspiration WHERE id=?"

  raw(sql,{tostring(id)})
  if cursor.moveToFirst() then
    title = cursor.getString(1);--获取第二列的值

  end
  subed("notepad","inspirationX",title,{
    id=id,
  })

end

list.onItemClick=function(id,v,zero,one)

  if v.Tag.status ~= nil then
    if v.Tag.status.Checked then
      set_check_box(one,false,todoid)
     else
      set_check_box(one,true,todoid)
    end
   else

  end
  task(1,lambda->Refresh(todoid))
end



function onResume()
  task(1,lambda->Refresh(todoid))
end


list.onItemLongClick=function(id,v,zero,one)


  function highLight(word)
    return MyTextStyle.TextColor(word,0,utf8.len(word),0xFFF44336)
  end
  data=getTable()
  import "androidx.appcompat.widget.PopupMenu"
  pop=PopupMenu(activity,v)
  menu=pop.Menu
  menu.add("编辑内容").onMenuItemClick=function()
    tab=getTable(content)
    if not tab[one].content then
      tab[one].content="内容"
    end
    save_as_json(tab,todoid)
    Refresh(filename)
    subed("notepad","todoDetail",getTable(content)[one].title,{content=getTable(content)[one].content})
    nowOne=one
  end
  menu.add("强调显示").onMenuItemClick=function()
    tab=getTable(content)
    old=tab[one].highLight
    if old == true then new=false else new=true end
    tab[one].highLight=new
    save_as_json(tab,todoid)
    Refresh(todoid)

  end


  menu.add(highLight("删除")).onMenuItemClick=function()
    task(100,function()

      import "com.google.android.material.bottomsheet.BottomSheetDialog"

      local dann=import("layout.delete_dialog")

      dl=BottomSheetDialog(activity)
      dl.setContentView(loadlayout(dann))
      an=dl.show()
      bottom = dl.findViewById(R.id.design_bottom_sheet);
      if (bottom != nil) then
        bottom
        .setBackgroundResource(android.R.color.transparent)
        .setPadding(math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(32))
      end

      okey.onClick=function()
        delete(one,todoid)
        dl.dismiss()
      end
      cancel.onClick=lambda -> dl.dismiss()
    end)

    pop.show()

  end

  pop.show()
  return true
end


function onResult(...)
  path,title,con=...
  if string.find(path,"sub/notepad/main") then
    tab=getTable(content)
    tab[nowOne].title=title
    tab[nowOne].content=con
    save_as_json(tab,todoid)
    task(1,lambda->Refresh(todoid))
  end
end