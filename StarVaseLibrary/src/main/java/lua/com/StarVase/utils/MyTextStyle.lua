module(...,package.seeall)
function TextColor(text,int0,int1,color)
  import "android.text.Spannable"
  import "android.text.SpannableString"
  import "android.text.style.ForegroundColorSpan"
  local spanString = SpannableString(text)
  local span = ForegroundColorSpan(color)
  spanString.setSpan(span, int0, int1, Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
  return spanString

end