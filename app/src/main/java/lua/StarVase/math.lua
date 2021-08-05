
function math.ts2t(t)
  return os.date("%m月%d日 %H:%M",t)
end

function math.dp2int(dpValue)
  import "android.util.TypedValue"
  return TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, dpValue, activity.getResources().getDisplayMetrics())
end

function math.hex2color(hex)
  hex=string.format("%#x",hex)
  var=string.match(hex,"0x(.+)")
  return "#"..var
end

function math.dp2px(dpValue)
  local scale = activity.getResources().getDisplayMetrics().scaledDensity
  return dpValue * scale + 0.5
end