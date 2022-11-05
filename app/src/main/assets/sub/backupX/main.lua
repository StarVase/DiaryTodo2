require "import"
require "StarVase"(this,{enableTheme=true})
import "UiHelper"
sr.setRefreshing(true);
loading.setVisibility(View.VISIBLE)



list.onItemLongClick=function(id,v,zero,one)
  id=data[one].id

  pop=PopupMenu(activity,v)
  menu=pop.Menu
  menu.add("删除").onMenuItemClick=function()
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
        deleteBak(data[one].path)
        dl.dismiss()
        Refresh()
      end
      cancel.onClick=lambda -> dl.dismiss()
    end)
  end
  pop.show()
  return true
end




--没注释，不解释不抱怨
function fab.onClick()
  task(1,function()
    backupNow()
    Refresh()
  end)
end


list.onItemClick=function(id,v,zero,one)
  backupNow()
  restoreBak(data[one].path)
Refresh()
end


onResume= lambda -> Refresh()
