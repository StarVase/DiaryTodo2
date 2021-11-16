module(...,package.seeall)
import "me.imid.swipebacklayout.lib.SwipeBackLayout"

function initActivity(initTable)
  if activity && initTable.SwipeBack then
    activity.setSwipeBackEnable(true)
    mSwipeBackLayout = activity.getSwipeBackLayout()
    mSwipeBackLayout.setEdgeTrackingEnabled(SwipeBackLayout.EDGE_LEFT)
    if initTable.SwipeBackEdge then
      mSwipeBackLayout.setEdgeSize(initTable.SwipeBackEdge)
     else
      mSwipeBackLayout.setEdgeSize(100)
    end
   else
    activity.setSwipeBackEnable(false)
  end
end
