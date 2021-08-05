MyRecyclerAdapter={}
function MyRecyclerAdapter.diary()
  return LuaRecyclerAdapter(AdapterCreator({

    getItemCount=function()
      return #data
    end,

    getItemViewType=function(position)
      return 0
    end,

    onCreateViewHolder=function(parent,viewType)
      local views={}
      holder=LuaRecyclerHolder(loadlayout(item,views))
      holder.view.setTag(views)
      return holder
    end,

    onBindViewHolder=function(holder,position)
      view=holder.view.getTag()

      if data[position+1].content then
        view.content.Text=data[position+1].content
      end

      view.yyyy.Text="-"..data[position+1].year
      view.mmdd.Text=data[position+1].month.."/"..data[position+1].day
      if data[position+1].enc then
        view.lock.setImageBitmap(loadbitmap("images/lock.png"))
       else
        view.lock.setImageBitmap(loadbitmap("images/unlock.png"))
      end
      --[[ Glide.with(this)
    .load(url)
    .dontTransform()
    --.override(Target.SIZE_ORIGINAL, Target.SIZE_ORIGINAL)
    .into(view.img);

]]

      --子项目点击事件
      view.parent.onClick=function(v)
        print()
        return true
      end

      --子项目里面的控件长按事件
      view.parent.onLongClick=function(v)
        print()
        return true
      end



    end,
  }))
end

return MyRecyclerAdapter