import "com.StarVase.view.StyleWidget"
import "android.text.SpannableString"
import "android.text.Spannable"
import "android.text.style.ForegroundColorSpan"
spTitle = SpannableString("字体")
spTitle.setSpan(ForegroundColorSpan(titleColor),0,#spTitle,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
activity.getSupportActionBar().setTitle(spTitle)
activity.getSupportActionBar().setDisplayShowCustomEnabled(true)
activity.getSupportActionBar().setCustomView(editTitle)
activity.getSupportActionBar().setDisplayHomeAsUpEnabled(true)
function onOptionsItemSelected(item)
  local id=item.getItemId()
  if id==android.R.id.home then
    activity.finish()
  end
end

activity.setContentView(loadlayout(require("layout")))

function progress2sp(progress)
  return tointeger(progress/(1000/45)+8)
end

function sp2progress(sp)
  return tointeger((sp-8)*(1000/45))
end

seekbar.setOnSeekBarChangeListener{
  onStartTrackingTouch=function()
    --开始拖动
  end,
  onStopTrackingTouch=function()
    --停止拖动
  end,
  onProgressChanged=function()
    size=progress2sp(seekbar.progress)
    activity.setSharedData("FontSize",size)
    labelSize.text="字体大小(sp)："..tostring(size)
    demo.textSize=size
  end}

import "android.graphics.Typeface"
font=nil
function ChooseFile()
  import "android.content.Intent"
  import "android.net.Uri"
  import "java.net.URLDecoder"
  import "java.io.File"
  import "com.StarVase.diaryTodo.util.UriUtils"
  intent = Intent(Intent.ACTION_GET_CONTENT)
  intent.setType("*/*");
  intent.addCategory(Intent.CATEGORY_OPENABLE)
  activity.startActivityForResult(intent,1);
  function onActivityResult(requestCode,resultCode,data)
    if resultCode == Activity.RESULT_OK then
      local uri = data.getData()
      path=UriUtils.getFileAbsolutePath(activity,uri)
      if "ttf"==file.getExtensionName(path) or "ttc"==file.getExtensionName(path) then
        font=Typeface.createFromFile(File(path))
        demo.setTypeface(font)
        activity.setSharedData("TTFPath",path)
        labelTtf.text="From TrueTypeface File:"..tostring(path)
      end
    end
  end
end