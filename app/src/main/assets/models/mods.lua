ripple = activity.obtainStyledAttributes({android.R.attr.selectableItemBackgroundBorderless}).getResourceId(0,0)
ripples = activity.obtainStyledAttributes({android.R.attr.selectableItemBackground}).getResourceId(0,0)


function setImage(front,behind)
  Log.v("setImage",dump({tostring(front),tostring(behind)}))
  MyToolbar.setImageBitmap(front)
  MyToolbar.setSubImageBitmap(behind)
end


function getWallPaper()
  wallpaperManager = WallpaperManager.getInstance(activity);
  wallpaperDrawable = wallpaperManager.getDrawable();
  bm = (wallpaperDrawable).getBitmap();
  return bm
end

function 高斯模糊(id,tp,radius1,radius2)
  import "android.net.Uri"
  pcall(function()
    import "android.graphics.Matrix"
    import "android.graphics.Bitmap"
    import "android.renderscript.RenderScript"
    import "android.renderscript.ScriptIntrinsicBlur"
    import "android.renderscript.Element"
    import "android.renderscript.Allocation"
  end)
  function blur( context, bitmap, blurRadius)
    renderScript = RenderScript.create(context);
    blurScript = ScriptIntrinsicBlur.create(renderScript, Element.U8_4(renderScript));
    inAllocation = Allocation.createFromBitmap(renderScript, bitmap);
    outputBitmap = bitmap;
    outAllocation = Allocation.createTyped(renderScript, inAllocation.getType());
    blurScript.setRadius(blurRadius);
    blurScript.setInput(inAllocation);
    blurScript.forEach(outAllocation);
    outAllocation.copyTo(outputBitmap);
    inAllocation.destroy();
    outAllocation.destroy();
    renderScript.destroy();
    blurScript.destroy();
    return outputBitmap;
  end

  bitmap=tp

  function blurAndZoom(context,bitmap,blurRadius,scale)
    return zoomBitmap(blur(context,zoomBitmap(bitmap, 1 / scale), blurRadius), scale);
  end

  function zoomBitmap(bitmap,scale)
    w = bitmap.getWidth();
    h = bitmap.getHeight();
    matrix = Matrix();
    matrix.postScale(scale, scale);
    bitmap = Bitmap.createBitmap(bitmap, 0, 0, w, h, matrix, true);
    return bitmap;
  end
  加深后的图片=blurAndZoom(activity,bitmap,radius1,radius2)

  xpcall(function()加深后的图片=blurAndZoom(activity,bitmap,radius1,radius2)end,
  function()加深后的图片=bitmap end)

  if id then
    id.setImageBitmap(加深后的图片)
   else
    return 加深后的图片
  end


end


--函数：刷新一言(无返回值)
function refreshYiyan()
  if activity.getSharedData("YiyanEnabled") then
    Thread(Runnable({
      run=function()
        sentences=yiyan.getRandomSentence(activity.getSharedData("YiyanType"))
        activity.setSharedData("thisYiyan",dump(sentences))
        MyToolbar.setSubtitle(sentences.sentence)
      end
    })).run()
   else
    MyToolbar.setSubtitle(nil)
    activity.setSharedData("thisYiyan",nil)
  end
end

function dump2table(str)
  return load(table.concat({"return ",str},""))()
end

piclist={
  "http://image.coolapk.com/picture/2019/0120/10/1118425_1547952433_2893@1080x1919.jpg.m.jpg", --吊饰
  "http://image.coolapk.com/picture/2019/0130/11/1058369_1548818235_8891@1080x1920.jpg.m.jpg"; --饮料机旁猫和人
  "http://image.coolapk.com/picture/2019/0122/10/2080075_1548123255_6404@720x1280.jpg.m.jpg"; --天空下竹竿吊饰
  "http://image.coolapk.com/picture/2019/0119/00/2129136_1547830299_2528@1080x2160.jpg.m.jpg"; --未上色的建筑建模
  "http://image.coolapk.com/picture/2019/0103/18/1625219_1546509870_1319@1080x1920.jpg.m.jpg"; --粉紫的山峦
  "http://image.coolapk.com/picture/2019/0103/18/1625219_1546509873_0732@1080x1920.jpg.m.jpg"; --蓝山峦
  "http://image.coolapk.com/picture/2018/1230/19/1118425_1546167826_5698@1080x1920.jpg.m.jpg";--天与海中一艘船
  "http://image.coolapk.com/picture/2018/1230/19/1118425_1546167841_0472@1080x1920.jpg.m.jpg"; --海滩
  "http://image.coolapk.com/picture/2018/1223/16/1865879_1545552135_2609@1080x2280.png.m.jpg";--一只猫躺着
  "http://image.coolapk.com/picture/2019/0130/08/615966_1548807965_0339@1080x1920.jpg.m.jpg";--秋天树林
  "http://image.coolapk.com/picture/2019/0129/19/750329_1548762294_5761@1080x2160.jpg.m.jpg";--柴柴顶面包
  "http://image.coolapk.com/picture/2019/0129/19/750329_1548762297_3927@1080x2160.jpg.m.jpg";--柴柴睡了
  "http://image.coolapk.com/picture/2019/0129/19/750329_1548762305_8528@1080x2160.jpg.m.jpg";--柴柴顶树叶
  "http://image.coolapk.com/picture/2019/0126/12/898597_1548477241_721@720x1280.jpg.m.jpg";--屋里花与猫
  "http://image.coolapk.com/picture/2018/1104/08/945857_1541291868_7698@1200x2133.png.m.jpg";--树枝下果子和猫
}

function 上下渐变(color)
  return GradientDrawable(GradientDrawable.Orientation.TOP_BOTTOM,color)
end
function 左右渐变(color)
  return GradientDrawable(GradientDrawable.Orientation.LEFT_RIGHT,color)
end
function getMaskColor()
  if AppTheme.isDarkTheme() then
    return 0x88000000,0x00000000
   else
    return 0xbbFFFFFF,0x22FFFFFF
  end
end