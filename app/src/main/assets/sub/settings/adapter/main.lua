return function(data)
  return LuaCustRecyclerAdapter(AdapterCreator {
    getItemCount=function()
      return int(#data)
    end,
    getItemViewType=function(position)
      --print(a,b,c,d,e)
      return int(data[position+1].__type)
    end,
    onCreateViewHolder=function(parent,type)
      local tag={}
      local view=loadlayout(import "layout.setlay"[type],tag)
      holder=LuaCustRecyclerHolder(view)
      view.tag=tag
      view.background=graph.Ripple(nil,普通波纹,"方")
      --print(parent)

      return holder
    end,
    --[[onCreateViewHolder=function(parent,viewType)
      local ids={}
      local view=loadlayout(itemsLay[viewType],ids)
      local holder=LuaCustRecyclerHolder(view)
      view.setTag(ids)
      if viewType~=1 then
        view.setFocusable(true)
        view.setBackground(ThemeUtil.getRippleDrawable(theme.color.rippleColorPrimary,true))
        view.onClick=function(view)
          local data=ids._data
          local key=data.key
          if not(onItemClick and onItemClick(view,ids,key,data)) then
            local statusView=ids.status
            if statusView then
              local checked=not(statusView.checked)
              statusView.setChecked(checked)
              if data.checked~=nil then
                data.checked=checked
               elseif data.key then
                setSharedData(data.key,checked)
              end
            end
          end
        end
      end
      return holder
    end]]
    onBindViewHolder=function(holder,position)
      --local data=recycler.adapter.currentList.get(position)
      --print(dump(data))
      local data=data[position+1]
      local tag=holder.view.tag
      --print(dump(tag))
      if data.__type == 1 then
        tag.title.text=data.title
       else
        tag.img.ImageResource=data.img.ImageResource
        tag.subtitle.text=data.subtitle
        if tag.message then
          tag.message.text=data.message
        end
        if tag.status then
          tag.status.Checked=data.status.Checked
        end
        if tag.p&& data.p then
          tag.p.Focusable=data.p.Focusable
        end
      end
      holder.itemView.onClick=lambda -> task(50,lambda ->onItemClick(position+1,tag.status))

      --[[  local tag=holder.itemView.tag
    tag.text.text=data.text
    tag.img.ImageResource=data.img
    tag.card.onClick=lambda -> task(50,lambda -> data.onClick())
    --    tag.title.text=data.title
    --    tag.text.text=data.text
    
    
    headerParams = tag.CardParent.getLayoutParams()
    headerParams.height=(math.dp2int(math.random(200,280)))
    tag.CardParent.setLayoutParams(headerParams);
    graph.Ripple(tag.card,淡色强调波纹)
    --pic.setImageBitmap(loadbitmap(piclist[math.random(1,#piclist)]))
    imgPos=math.random(1,#piclist)
    Glide.with(activity)
    .load(piclist[imgPos])
    .into(tag.pic);
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

]]

    end
  })
end
