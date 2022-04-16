function TouchEffect(view,startscale,endscale,time)
  local animatorSetsuofang = AnimatorSet()
  local scaleX=ObjectAnimator.ofFloat(view,"scaleX",{startscale,endscale})
  local scaleY=ObjectAnimator.ofFloat(view,"scaleY",{startscale,endscale})
  animatorSetsuofang.setDuration(time)
  animatorSetsuofang.setInterpolator(DecelerateInterpolator())
  animatorSetsuofang.play(scaleX).with(scaleY);
  animatorSetsuofang.start()
end


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
    tag.CardParent.onClick=lambda -> task(1,lambda -> data.onClick())
    --    tag.title.text=data.title
    --    tag.text.text=data.text

    TouchEffectHelper().setClickEffect(tag.CardParent,0.9,150)

    headerParams = tag.CardParent.getLayoutParams()
    --headerParams.height=math.dp2int(120)
    --headerParams.height=(math.dp2int(math.random(200,280)))
    tag.CardParent.setLayoutParams(headerParams);
    graph.Ripple(tag.card,淡色强调波纹)
    --tag.frame.foreground=graph.Ripple(nil,淡色强调波纹,"方")

    --pic.setImageBitmap(loadbitmap(piclist[math.random(1,#piclist)]))
    imgPos=math.random(1,#piclist)
    import "com.bumptech.glide.request.RequestOptions";
    import "com.bumptech.glide.request.target.SimpleTarget"
    import "com.StarVase.library.util.BlurTransformation"
    import "com.bumptech.glide.load.resource.drawable.DrawableTransitionOptions"
    Glide.with(activity)
    .load(piclist[imgPos])
    .transition(DrawableTransitionOptions.withCrossFade())
    .apply(RequestOptions.bitmapTransform(BlurTransformation(activity,18)))
   -- .into(tag.pic)
    --[[.into(SimpleTarget({
      onResoureReady=function(resource, Transititransition)
        --viewGroup.setBackground(resource);
        print(resource)
        tag.pic.setImageBitmap(resource)
      end
    }))]]
    --Glide.with(activity.getContext()).into(tag.pic).get(piclist[imgPos])
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



