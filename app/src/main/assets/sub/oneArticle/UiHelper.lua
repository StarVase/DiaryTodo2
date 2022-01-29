
import "androidx.swiperefreshlayout.widget.SwipeRefreshLayout"
import "com.google.android.material.tabs.TabLayout"
import "com.StarVase.library.view.*"
import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.text.Spannable"
import "layout"

activity.setContentView(loadlayout(layout))


spTitle = SpannableString("一文")
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
  tablay.addView(loadlayout({
    LinearLayout;
    layout_height="48dp";
    gravity="center";
    {
      CardView;
      radius="16dp";
      layout_margin="8dp";
      layout_height="32dp";
      elevation="0dp";
      BackgroundColor=0;

      onClick=gb,
      {
        LinearLayout;
        gravity="center";
        layout_height="fill";
        orientation="horizontal",
        id="mytab";
        {
          AppCompatImageView;
          layout_height="22dp";
          layout_marginRight="1dp";
          ImageResource=src,
          layout_marginLeft="0dp";
          ColorFilter=icon,
        };

        {
          AppCompatTextView;
          layout_marginRight="16dp";
          text=text;
          layout_marginLeft="1dp";
          textColor=textColor,
        };
      };
    };
  }))
  --graph.ButtonFrame(mytab,math.dp2px(1),icon,0,math.dp2px(16))
  --pcall(function()mytab.foreground=graph.Ripple(nil,普通波纹)end)
end

addCard("朗读",R.drawable.ic_text_to_speech,
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