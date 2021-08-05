require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "StarVase"
import "com.bumptech.glide.Glide"
import "androidx.swiperefreshlayout.widget.SwipeRefreshLayout"

importFile('diaryX',"UIHelper")



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





add.onClick=function()
  输入对话框("新建","标题",date,"创建","取消",function() onEditDialogCallback(edit.getText()) 关闭对话框(an) return edit.Text end,function() 关闭对话框(an) return nil end )

  function onEditDialogCallback(edit)
    import "rc4"
    activity.setSharedData('diaryRC4PSK',"1234")
    content=minicrypto.encrypt("日记新建成功",activity.getSharedData('diaryRC4PSK'))
    key=minicrypto.encrypt("1234","Diaryenced")
print(edit)
    values = ContentValues();
    values.put("title",edit);
    values.put("year", "2021");
    values.put("month", "03");
    values.put("day", "21");
    values.put("isEmp", "1");
    values.put("key", "");
    values.put("content", "");
    db.insert("diary", nil, values);

    Refresh()

  end
end



list.onItemClick=function(id,v,zero,one)
  id=data[one].id
  sql="select * from diary WHERE id=?"

  raw(sql,{tostring(id)})
  if cursor.moveToFirst() then
    title = cursor.getString(1);--获取第二列的值
    isEmp = cursor.getInt(6);
    key = cursor.getString(7);
  end
  sub("notepad","diaryX",title,{
    id=id,
    isEmp=isEmp,
    key=key
  })

end


function onResume()
  Refresh()
end

