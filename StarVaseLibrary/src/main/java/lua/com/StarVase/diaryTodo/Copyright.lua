copyright=luajava.bindClass("com.StarVase.diaryTodo.app.DtdCopyright")(this)

if (copyright.isDebugModeEnabled()) then
  task(1,function()activity.getWindow().getDecorView().addView(copyright.getCopyrightTextView())end)
end