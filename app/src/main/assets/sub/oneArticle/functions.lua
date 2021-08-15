require "import"
import "android.widget.*"
import "android.view.*"
import "com.StarVase.diaryTodo.CreateFileUtil"
activity.setSharedData("favoriteee",nil)
activity.setSharedData("pathhh",nil)

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