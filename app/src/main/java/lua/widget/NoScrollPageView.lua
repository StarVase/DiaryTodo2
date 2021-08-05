return function()
  return luajava.override(luajava.bindClass("android.widget.PageView"),{
    onInterceptTouchEvent=function(super,event)
      return false
    end,
    onTouchEvent=function(super,event)
      return false
    end
  })
end