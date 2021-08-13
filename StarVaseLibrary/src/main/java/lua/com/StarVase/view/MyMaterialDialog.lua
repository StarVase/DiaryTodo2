require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"


import "com.google.android.material.bottomsheet.BottomSheetDialog"

local bsd=BottomSheetDialog(this)


bottom = bsd.findViewById(R.id.design_bottom_sheet);
if (bottom != null) then
  bottom.setBackgroundResource(android.R.color.transparent)
  .setPadding(math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(32))
end


return bsd