require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"

--import "muk"
--删掉“--”注释符号以使用中文函数






function getTable()
  
  function BubbleSort(arr)
  len=table.maxn(arr)
  for i=1,len do
    for j=i+1,len do
      if arr[i].file_name<arr[j].file_name then
        arr[i],arr[j]=arr[j],arr[i]
      end
    end
  end
  return arr
end
  
  data={}
  import("java.io.File")
  import "com.StarVase.app.path"

  import "com.StarVase.utils.string"
  xpcall(function()
    fileTable=((luajava.astable(File(tostring(path.backup)).listFiles())))
  end,function() fileTable={} end)
  if fileTable[1] then
    for i = 1,#fileTable do
      path=fileTable[i]
      name=File(tostring(path)).getName()
      if string.checkString(tostring(name),".dbk") then
        table.insert(data,{
          file_name=name,
          title=name,
          path=tostring(path),
        })
      end
    end
  end
  data = BubbleSort(data)
  -- print(dump(data))
  return data
end

function doubleButtonDialog(title,msg,pos,pas,poseve,paseve)
  task(100,function()

    import "com.google.android.material.bottomsheet.BottomSheetDialog"

    local dann={
      LinearLayout;
      orientation="vertical";
      layout_width="fill";
      --Elevation="1dp";
      backgroundDrawable=GradientDrawable()
      .setColor(BGC)
      .setCornerRadii({math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(16)})
      .setShape(0),
      {
        AppCompatTextView;
        layout_width="-1";
        layout_height="-2";
        textSize="20sp";
        layout_marginTop="24dp";
        layout_marginLeft="24dp";
        layout_marginRight="24dp";
        layout_marginBottom="8dp";
        text=title,
        --Text=AdapLan("删除","Delete");
        Typeface=Typeface.createFromAsset(activity.getAssets(),"res/fonts/product-Bold.ttf");
        textColor=forceColor;
      };
      {
        MaterialCardView,
        layout_height="wrap",
        layout_width="fill",
        layout_marginLeft="24dp";
        layout_marginRight="24dp";
        radius="4dp";
        CardBackgroundColor=0,
        Elevation="0";

        {
          AppCompatTextView;
          textColor=textColor,
          id='text',
          textSize="14dp",
          Typeface=Typeface.createFromAsset(activity.getAssets(),"res/fonts/product-Bold.ttf");
          text=msg,
          --Text=AdapLan("操作不可逆！你确定要删除吗？" ,"The operation is irreversible! Are you sure to delete? "),
          layout_width="fill";
          layout_height="wrap";
        };
      },


      {
        LinearLayout;
        orientation="horizontal";
        layout_width="-1";
        layout_height="-2";
        layout_marginTop="8dp";
        layout_marginLeft="8dp";
        layout_marginRight="24dp";
        layout_marginBottom="8dp";
        gravity="right|center";

        {
          TextButton,
          id="cancel",
          text=pas,
          --text=AdapLan("取消","Cancel"),
          textColor=forceColor;
          onClick=paseve,
          padding="2dp",
          layout_marginLeft="4dp";
          layout_marginRight="4dp";
        },
        {
          MaterialButton,
          id="okey",
          text=pos,
          onClick=poseve,
          --text=AdapLan("确定","OK"),
          padding="2dp",
          layout_marginLeft="4dp";
          layout_marginRight="4dp";
        },
      };
    };


    dl=BottomSheetDialog(activity)
    dl.setContentView(loadlayout(dann))
    an=dl.show()
    bottom = dl.findViewById(R.id.design_bottom_sheet);
    if (bottom != nil) then
      bottom
      .setBackgroundResource(android.R.color.transparent)
      .setPadding(math.dp2int(16),math.dp2int(16),math.dp2int(16),math.dp2int(32))
    end


  end)
end