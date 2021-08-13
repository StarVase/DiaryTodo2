return LuaDiffRecyclerAdapter(LuaDiffRecyclerAdapter.LuaInterface {
  getItemViewType=function()
    return int(0)
  end,
  onCreateViewHolder=function(parent,type)
    local tag={}
    local view=loadlayout(recycler_item,tag,parent.class)
    view.tag=tag
    return view
  end,
  areContentsTheSame=function(old,new)
    return old.title==new.title
  end,
  areItemsTheSame=function(old,new)
    return old.title==new.title
  end,
  onBindViewHolder=function(holder,position)
    local data=mainGrid.adapter.currentList.get(position)
    local tag=holder.itemView.tag
    tag.text.text=data.text
    tag.img.ImageResource=data.img
    tag.card.onClick=lambda -> data.onClick()
    --    tag.title.text=data.title
    --    tag.text.text=data.text
    headerParams = tag.CardParent.getLayoutParams()
    headerParams.height=(math.dp2int(math.random(200,280)))
    tag.CardParent.setLayoutParams(headerParams);
    graph.Ripple(tag.card,淡色强调波纹)
    --pic.setImageBitmap(loadbitmap(piclist[math.random(1,#piclist)]))
    imgPos=math.random(1,#piclist)
    Glide.with(this).load(piclist[imgPos]).into(tag.pic)
    table.remove(piclist,imgPos)

    --动画！
    import "android.view.animation.*"
    Translate_up_down=TranslateAnimation(mainGrid.getWidth(), 0, 0, 0)
    Translate_up_down.setDuration(500)
    Translate_up_down.setFillAfter(true)

    import "android.view.animation.Animation$AnimationListener"


    Alpha=AlphaAnimation(0,1)
    Alpha.setDuration(800)
    tag.CardParent.startAnimation(Alpha)
    Translate_up_down.setAnimationListener(AnimationListener{
      onAnimationStart =(lambda -> tag.CardParent.startAnimation(Alpha)),
      onAnimationEnd=(lambda -> nil),
      onAnimationRepeat=(lambda -> nil)})



  end
})