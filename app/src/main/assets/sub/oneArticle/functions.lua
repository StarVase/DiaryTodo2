require "import"
import "android.widget.*"
import "android.view.*"
import "com.StarVase.diaryTodo.CreateFileUtil"
activity.setSharedData("favoriteee",nil)
activity.setSharedData("pathhh",nil)

function getArticle()
  sr.setRefreshing(true);
  url="https://www.dushu.com/meiwen/random/"
  Http.get(url,nil,"UTF-8",nil,function(code,content,cookie,header)
    setStarfalse()
    sr.setRefreshing(false);
    if(code==200 and content)then
      import "org.jsoup.Jsoup"
      document=Jsoup.parse(content)
      element=document.select("div[class=container margin-top]")[1]
        .select("div[class=news-left]")
        .select("div[class=article-detail]")
      title=element.select("h1").text()
      author=element.select("span").text()
      original_content=element.select("div[class=text]").select ("p")
      content=""
      for index=0,original_content.size()-1 do
        content = content .. original_content[index].text() .. "\n\n"
      end
      artcon=content
      Title.setText(title)
      Title.getPaint().setFakeBoldText(true)

      Author.setText(author)
      Author.getPaint().setFakeBoldText(true)
      star.setVisibility(View.VISIBLE)
      Content.setText(artcon)
      total.text="共"..tostring(EasyEditorHelper.getMSWordsCount(artcon)).."字"
      import "android.text.format.Time"
      time=Time().setToNow()
      conf={}
      conf.year=time.year
      conf.month=time.month+1
      conf.day=time.monthDay
      activity.setSharedData("LastReadArticleDate",tointeger(tostring(conf.year)..tostring(conf.month)..tostring(conf.day)))
      return code,title,author,artcon
    end
  end)
end

function setStarfalse()
  favorite=false
  activity.setSharedData("favoriteee",favorite)
  star.setImageResource(R.drawable.ic_star_outline)
end

function setStarTrue(path)
  favorite=true
  activity.setSharedData("favoriteee",favorite)
  activity.setSharedData("pathhh",path)
  star.setImageResource(R.drawable.ic_star)
end

function getStar()
  return activity.getSharedData("favoriteee")
end

function getPath()
  return activity.getSharedData("pathhh")
end