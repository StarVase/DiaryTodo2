import "android.animation.LayoutTransition"
import "androidx.swiperefreshlayout.widget.SwipeRefreshLayout"
import "com.google.android.material.tabs.TabLayout"
import "com.StarVase.library.view.*"
import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.text.Spannable"
import "layout"

activity.setContentView(loadlayout(layout))
Content.setLineSpacing(2,1.5)

spTitle = SpannableString(activity.getString(R.string.func_one_article))
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

function createColorStateList(pressed,normal)
  colorList = DynamicUtil.createColorStateList(pressed, normal);
  return colorList;
end


sr.setRefreshing(false);
sr.setColorSchemeColors({icon});
sr.setOnRefreshListener(SwipeRefreshLayout.OnRefreshListener{onRefresh=function()
    getArticle()
    sr.setRefreshing(false);
  end})


scroll.setOnScrollChangeListener({
  onScrollChange=function(v,scrollx,scrolly,lastscrollx,lastscrolly)
    if scrolly==0 then
      sr.setEnabled(true)
     else
      sr.setEnabled(false)
    end
  end,
})

--tablay.addTab()

function addCard(text,src,gb)
  local tmp = {}
  tablay.addView(loadlayout({
    Chip;
    onClick=gb;
    text=text;
    gravity="center";
    layout_height="wrap";
    --padding="8dp";
    typeface=Typeface.DEFAULT_BOLD;
    paddingLeft="8dp";
    paddingRight="8dp";
    chipIconTint=createColorStateList(icon,icon),
    chipIconResource=src;
    id="chip";
    minWidth="40dp";
    focusable=true;
    textColor=icon;
  },tmp))
  --print(dump(tmp))
  --print(tmp.chip)
  --graph.ButtonFrame(mytab,math.dp2px(1),icon,0,math.dp2px(16))
  --pcall(function()mytab.foreground=graph.Ripple(nil,????????????)end)
end

addCard("??????",R.drawable.ic_text_to_speech,
function()import "android.speech.tts.*"
  if mTextSpeech then
    mTextSpeech.speak((artcon), TextToSpeech.QUEUE_FLUSH, nil);
   else
    mTextSpeech = TextToSpeech(activity, TextToSpeech.OnInitListener{
      onInit=function(status)
        mTextSpeech.setPitch(1);
        mTextSpeech.setSpeechRate(1);
        mTextSpeech.speak((artcon), TextToSpeech.QUEUE_FLUSH, nil);
      end
    });
  end
end)
