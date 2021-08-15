require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "StarVase"

import "com.bumptech.glide.Glide"

import "UIHelper"



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




--没注释，不解释不抱怨
function fab.onClick()
  task(1,function()
    import "android.icu.util.Calendar"
    calendar = Calendar.getInstance();
    year = calendar.get(Calendar.YEAR);
    month = calendar.get(Calendar.MONTH)+1;
    day = calendar.get(Calendar.DAY_OF_MONTH);

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
        CreateFileUtil.collection({
          title=edit.getText(),
          timestamp=os.time()
        })
        MyToast.showSnackBar("Done")
      end
      dl.dismiss()
      Refresh()
    end
    cancel.onClick=lambda -> dl.dismiss()
    --新建对话框(bt,nr,text,qd,qx,qdnr,qxnr,gb)
  end)
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

