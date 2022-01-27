require "StarVase"(this,{enableTheme=true})
require "UiHelper"
import "android.widget.ArrayPageAdapter"
import "android.widget.CircleImageView"
import "android.widget.*"
pages={}
pagesFiles=luajava.astable(File(activity.getLuaDir("pages")).listFiles())
table.sort(pagesFiles,function(a,b)
  return string.upper(a.Name)<string.upper(b.Name)
end)
for index,index in ipairs(pagesFiles) do
  local func,err=loadfile(tostring(index))
  if func then
    table.insert(pages,func())
   else
    error(err)
  end
end
maxPage=table.size(pages)-1
progressBar.setMax((maxPage+1)*1000)

adp=ArrayPageAdapter()
pageView.setAdapter(adp)
for index,content in ipairs(pages) do
  adp.add(loadlayout(content.layout,content))
  if content.onInitLayout then
    content:onInitLayout()
  end
end

pageView.setOnPageChangeListener(PageView.OnPageChangeListener{
  onPageScrolled=function(arg0,arg1,arg2)
    --print(arg0,arg1,arg2)
    progressBar.setProgress((arg0+arg1+1)*1000)
    if nextButton.Visibility==View.GONE then
      --pageView.showPage(pageView.getCurrentItem())
    end
  end,
  onPageChange=function(view,page)
    local pageTable=pages[page+1]
    if page==0 then
      backButton.setVisibility(View.GONE)
     else
      backButton.setVisibility(View.VISIBLE)
    end
    nextButton.text=pageTable.NextButtonText or "下一步"
    nextButton.setVisibility(View.VISIBLE)
    if pageTable.onPageChange then
      pageTable:onPageChange(view,page)

    end

  end
})


nextButton.onClick=function()
  local pageTable=pages[pageView.getCurrentItem()+1]
  local nowPage=pageView.getCurrentItem()
  if pageTable.onNextButtonClick then
    pageTable:onNextButtonClick(view,page)

  end
  if nowPage<maxPage then
    pageView.showPage(nowPage+1)
   elseif nowPage==maxPage then
    --activity.setSharedData("Already welcome",true)
    -- newActivity("../../main")
    activity.finish()
  end
end
backButton.onClick=function()
  local nowPage=pageView.getCurrentItem()
  if nowPage>0 then
    pageView.showPage(nowPage-1)
  end
end