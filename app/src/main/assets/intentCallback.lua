--intent回调处理
function onNewIntent(intent)
  local uriString = tostring(intent.getData())
  this.finish()
  if "diary"==uriString then
    sub('diaryX')
   elseif uriString=="todo" then
    sub("TODO")
   elseif uriString=="bulb" then
    sub("inspirationX")
   elseif uriString=="art" then
    sub("oneArticle")
   elseif uriString=="fav" then
    sub("collectionX")
  end
end