return function(data)
  return LuaCustRecyclerAdapter(AdapterCreator {
    getItemCount=function()
      return int(#data)
    end,
    getItemViewType=function(position)
      return 0
    end,
    onCreateViewHolder=function(parent,type)
      local tag={}
      local view=loadlayout(import "item",tag)

      holder=LuaCustRecyclerHolder(view)
      
      view.tag=tag

      view.background=graph.Ripple(nil,普通波纹,"方")
      --print(parent)

      return holder
    end,
    onBindViewHolder=function(holder,position)
      --local data=recycler.adapter.currentList.get(position)
      
      local data=data[position+1]
      local tag=holder.view.tag
      
        tag.content.text=data.content
       
      --holder.itemView.onClick=lambda -> task(50,lambda ->onItemClick(position+1,tag.status))


    end
  })
end
