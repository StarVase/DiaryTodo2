module(...,package.seeall)
import "android.view.animation.AlphaAnimation"
function 透明动画(id,时间,开始透明度,结束透明度)
  id.startAnimation(AlphaAnimation(开始透明度,结束透明度).setDuration(时间))
end