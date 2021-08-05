require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "StarVase"

import "com.bumptech.glide.Glide"

importFile('inspirationX',"UIHelper")



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




--[[add.onClick=function()

  values = ContentValues();
  values.put("title",'灵感');
  values.put("content", "");
  values.put("timestamp",tostring(os.time()));
  db.insert("inspiration", nil, values);

  Refresh()
end]]
add.onClick=function()
  输入对话框("新建","标题",nil,"创建","取消",function() onEditDialogCallback(edit.getText()) 关闭对话框(an) return edit.Text end,function() 关闭对话框(an) return nil end )

  function onEditDialogCallback(edit)
    values = ContentValues();
    values.put("title",tostring(edit));
    values.put("content", "创建成功");
    values.put("timestamp",tostring(os.time()));
    db.insert("inspiration", nil, values);

    Refresh()
  end
end



list.onItemClick=function(id,v,zero,one)
  id=data[one].id
  sql="select * from inspiration WHERE id=?"

  raw(sql,{tostring(id)})
  if cursor.moveToFirst() then
    title = cursor.getString(1);--获取第二列的值

  end
  sub("notepad","inspirationX",title,{
    id=id,
  })

end


function onResume()
  Refresh()
end

