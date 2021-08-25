require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "StarVase"
import "android.graphics.Paint"
import "com.bumptech.glide.Glide"

importFile('todoX',"UIHelper")
--importFile('todoX',"UIHelper")


list.onItemLongClick=function(id,v,zero,one)
--print(dump(data))
  id=data[one].id

  pop=PopupMenu(activity,v)
  menu=pop.Menu
  menu.add("删除").onMenuItemClick=function()
    delete(id)
  end
  pop.show()
  return true
end


add.onClick=function()
  输入对话框("新建","标题",nil,"创建","取消",function() onEditDialogCallback(edit.getText()) 关闭对话框(an) return edit.Text end,function() 关闭对话框(an) return nil end )

  function onEditDialogCallback(edit)
    values = ContentValues();
    values.put("title",edit);
    values.put("isHighlight",true);
    values.put("data", cjson.encode{});
    values.put("timestamp",tostring(os.time()));
    values.put("noticeat",nil);
    db.insert("todo", nil, values);

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

