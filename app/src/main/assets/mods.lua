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