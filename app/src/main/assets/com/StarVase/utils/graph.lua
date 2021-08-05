module(...,package.seeall)
function Ripple(id,color,t)
  local ripple
  if t=="圆" or t==nil then
    if not(RippleCircular) then
      RippleCircular=activity.obtainStyledAttributes({android.R.attr.selectableItemBackgroundBorderless}).getResourceId(0,0)
    end
    ripple=RippleCircular
   elseif t=="方" then
    if not(RippleSquare) then
      RippleSquare=activity.obtainStyledAttributes({android.R.attr.selectableItemBackground}).getResourceId(0,0)
    end
    ripple=RippleSquare
  end
  local Pretend=activity.Resources.getDrawable(ripple)
  if id then
    id.setBackground(Pretend.setColor(ColorStateList(int[0].class{int{}},int{color})))
   else
    return Pretend.setColor(ColorStateList(int[0].class{int{}},int{color}))
  end

end

function ButtonFrame(view,Thickness,FrameColor,InsideColor,radiu)
  import "android.graphics.drawable.GradientDrawable"
  local drawable = GradientDrawable()
  drawable.setShape(GradientDrawable.RECTANGLE)
  drawable.setStroke(Thickness, FrameColor)
  drawable.setColor(InsideColor)
  local radiu=radiu or 0
  drawable.setCornerRadii({radiu,radiu,radiu,radiu,radiu,radiu,radiu,radiu});
  if view then
    view.setBackgroundDrawable(drawable)
   else
    return drawable
  end
end


function 修改颜色强度(强度,颜色)--16进制
  return (tonumber("0x"..强度..string.sub(Integer.toHexString(颜色),3,8)))
end

function 上下渐变(color)
  return GradientDrawable(GradientDrawable.Orientation.TOP_BOTTOM,color)
end

function transColor(view,type,color,time)
  ObjectAnimator.ofInt(view,type,color)
  .setDuration(time)
  .setEvaluator(ArgbEvaluator())
  .start()
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

function getScreenshot(view)
  view.destroyDrawingCache();
  view.setDrawingCacheEnabled(true);
  view.buildDrawingCache();
  local bmp = view.getDrawingCache();
  return bmp
end