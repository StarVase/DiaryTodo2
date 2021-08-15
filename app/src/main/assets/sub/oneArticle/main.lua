require "import"
import "StarVase"
import "androidx.swiperefreshlayout.widget.SwipeRefreshLayout"
import "com.StarVase.library.view.*"
import "UiHelper"
import "functions"






star.onClick=function()
  if not getStar() then
    --pcall(function()
      content=tostring("# "..Title.getText()).."  \n## "..tostring(Author.getText()).."\n"..tostring(Content.getText())
      local index=save_as_favorite(tostring(Title.getText()),content)
      print(index)
      setStarTrue(index)
   -- end)
   else
    --pcall(function()
      local index=getPath()
      print(index)
      CreateFileUtil.delete("collection",index)
      setStarfalse(index)
    --end)
  end
end






getArticle()

function save_as_favorite(title,content)
  local config={}
  config.title=title
  config.content=content
  config.timestamp=os.time()
  result=CreateFileUtil.collection(config)
  return result
end

















--[[function addCard(text,src,gb)
  toolbar.addView(loadlayout({
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
          ImageView;
          layout_height="22dp";
          layout_marginRight="1dp";
          ImageResource=src,
          layout_marginLeft="0dp";
          ColorFilter=icon,
        };

        {
          TextView;
          layout_marginRight="16dp";
          text=text;
          layout_marginLeft="1dp";
          textColor=textColor,
        };
      };
    };
  }))
  graph.ButtonFrame(mytab,math.dp2px(1),icon,0,math.dp2px(16))
  pcall(function()mytab.foreground=graph.Ripple(nil,普通波纹)end)
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
end)]]