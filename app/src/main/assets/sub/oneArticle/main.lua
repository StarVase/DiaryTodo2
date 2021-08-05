require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "StarVase"
import "androidx.swiperefreshlayout.widget.SwipeRefreshLayout"

import "com.StarVase.library.view.*"

layout=importFile('oneArticle',"layout")
activity.setSharedData("favoriteee",nil)
activity.setSharedData("pathhh",nil)

activity.setContentView(loadlayout(layout))
function setStarfalse()
  favorite=false
  activity.setSharedData("favoriteee",favorite)
  star.setImageBitmap(loadbitmap('images/star_outline.png'))
end
function setStarTrue(path)
  favorite=true
  activity.setSharedData("favoriteee",favorite)
  activity.setSharedData("pathhh",path)
  star.setImageBitmap(loadbitmap('images/star.png'))
end
function getStar()
  return activity.getSharedData("favoriteee")
end
function getPath()
  return activity.getSharedData("pathhh")
end
function getArticle()
  sr.setRefreshing(true);
  url="https://meiriyiwen.com/"
  Http.get(url,nil,"UTF-8",nil,function(code,content,cookie,header)

    setStarfalse()
    sr.setRefreshing(false);
    if(code==200 and content)then
      title=content:match([[<h2 class="articleTitle">%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s(.-)%s%s%s%s%s%s%s%s%s%s%s%s%s</h2>]])
      author=content:match([[<div class="articleAuthorName">%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s(.-)%s%s%s%s%s%s%s%s%s%s%s%s%s</div>]])
      artcon=content:match("%pdiv%sclass%p%particleContent%p%p%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s(.-)%p%pdiv%p")
      artcon=string.gsub(artcon,"%pp%p","")
      artcon=string.gsub(artcon,"%p%pp%p","")
      artcon=string.gsub(artcon,"%p","")
      Title.setText(title)
      Title.getPaint().setFakeBoldText(true)

      Author.setText(author)
      Author.getPaint().setFakeBoldText(true)
      star.setVisibility(View.VISIBLE)
      Content.setText(artcon)
      total.text="共"..tostring(utf8.len(artcon)).."字"
      return code,title,author,artcon
    end
  end)
end


star.onClick=function()
  if not getStar() then
    pcall(function()
      content=tostring(Title.getText()).."\n"..tostring(Author.getText()).."\n"..tostring(Content.getText())
      path=save_as_favorite(tostring(Title.getText()),content)
      setStarTrue(path)
    end)
   else
    pcall(function()
      path=getPath()
      pcall(function() os.remove(path) end)
      setStarfalse(path)
    end)
  end
end

back.onClick=function()
  activity.finish()
end
graph.Ripple(star,普通波纹)
graph.Ripple(back,普通波纹)

sr.setRefreshing(false);
sr.setColorSchemeColors({icon});
sr.setOnRefreshListener(SwipeRefreshLayout.OnRefreshListener{onRefresh=function()
    getArticle()
    sr.setRefreshing(false);
  end})



scroll.setOnScrollChangeListener({
  onScrollChange=function(v,scrollx,scrolly,lastscrollx,lastscrolly)
    if scrolly==0 then
      --到顶了
      sr.setEnabled(true)
      sr.setRefreshing(false);
      sr.setColorSchemeColors({icon});
      sr.setOnRefreshListener(SwipeRefreshLayout.OnRefreshListener{onRefresh=function()
          getArticle()
        end})
     else
      sr.setEnabled(false)
    end
  end,
})

getArticle()

function save_as_favorite(title,content)
  timestamp=os.time()
  path="/Android/data/"..activity.getPackageName().."/data/.favorite/"
  name=".favorite-"..os.time()..title
  con=[[<title>>]]..title..[[<</title>
<content>>]]..content..[[<</content>
<ts>>]]..timestamp..[[<</ts>
]]
  file.writeFile(Environment.getExternalStorageDirectory().toString()..path..name,con)
  return Environment.getExternalStorageDirectory().toString()..path..name
end

function addCard(text,src,gb)
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
          src=src,
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

addCard("朗读","icons/ic_tshirt_crew_outline.png",
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