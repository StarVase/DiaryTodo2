require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "StarVase"

import "com.bumptech.glide.Glide"

importFile('collectionX',"UIHelper")



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
  tab={
    title="hello",
    content=""
    
    }
  createCollection(tab)
  Refresh()
end


list.onItemClick=function(id,v,zero,one)
  id=data[one].id
  sql="select * from collection WHERE id=?"

  raw(sql,{tostring(id)})
  if cursor.moveToFirst() then
    title = cursor.getString(1);--获取第二列的值

  end
  sub("notepad","collectionX",title,{
    id=id,
  })

end


function onResume()
  Refresh()
end

