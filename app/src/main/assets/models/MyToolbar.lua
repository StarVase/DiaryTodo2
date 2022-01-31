MyToolbar={}
import "com.google.android.material.appbar.CollapsingToolbarLayout$LayoutParams"
import "android.graphics.PorterDuff"
import "android.graphics.Color"
import "android.content.res.ColorStateList"

--作者：StarVase
--日记与待办开源模块
--本示例未经允许禁止转发


import "layouts.toolbar_layout"
activity.setContentView(loadlayout(toolbar_layout))
pcall(function()activity.setSupportActionBar(toolBar)end)

layoutParams=imageFrame.getLayoutParams();
layoutParams.setParallaxMultiplier(0.6)
layoutParams.setCollapseMode(CollapsingToolbarLayout.LayoutParams.COLLAPSE_MODE_PARALLAX);
imageFrame.setLayoutParams(layoutParams);

layoutParams=toolBar.getLayoutParams();
layoutParams.setCollapseMode(LayoutParams.COLLAPSE_MODE_PIN)
toolBar.setLayoutParams(layoutParams);
collapsingToolbarLayout.getLayoutParams().setScrollFlags(AppBarLayout.LayoutParams.SCROLL_FLAG_SCROLL|AppBarLayout.LayoutParams.SCROLL_FLAG_EXIT_UNTIL_COLLAPSED);

params = nestedScrollView.getLayoutParams()
params.setBehavior(AppBarLayout.ScrollingViewBehavior())
nestedScrollView.setLayoutParams(params)


params2 = fab.getLayoutParams()
params2.setAnchorId(appBarLayout.getId())
params2.anchorGravity = Gravity.BOTTOM|Gravity.END;
fab.setLayoutParams(params2)


--appBarLayout.getChildAt(0).getChildAt(1).getChildAt(0).setTypeface(Typeface.defaultFromStyle(Typeface.BOLD))
collapsingToolbarLayout.setCollapsedTitleTypeface(Typeface.defaultFromStyle(Typeface.BOLD))
collapsingToolbarLayout.setExpandedTitleTypeface(Typeface.defaultFromStyle(Typeface.BOLD))

--l设置布局
function MyToolbar.setContentView(view)
  nestedScrollView.addView(view)
end
--折叠后标题栏颜色
function MyToolbar.setCollapsedToolbarBackgroundColor(color)
  collapsingToolbarLayout.setContentScrimColor(color)
end

--fab背景颜色
function MyToolbar.setFabColor(color)
  fab.setSupportBackgroundTintList(ColorStateList.valueOf(color))
end

--fab图标颜色
function MyToolbar.setFabImageColor(color)
  fab.setColorFilter(color)
end

--fab图标bitmap
function MyToolbar.setFabImageBitmap(bitmap)
  fab.setImageBitmap(bitmap)
end

--
function MyToolbar.setFabImageResource(int)
  fab.setImageResource(int)
end

--fab波纹颜色
function MyToolbar.setFabRippleColor(color)
  fab.setRippleColor(ColorStateList.valueOf(color))
end

--设置标题
function MyToolbar.setTitle(title)
  collapsingToolbarLayout.setTitle(title);
end

--设置副标题
function MyToolbar.setSubtitle(subtitle)
  collapsingToolbarLayout.setSubtitle(subtitle);
end

--设置主图片bitmap
function MyToolbar.setImageBitmap(bitmap)
  mainAppCompatImageView.setImageBitmap(bitmap)
end

--设置后衬图片bitmap
function MyToolbar.setSubImageBitmap(bitmap)
  subAppCompatImageView.setImageBitmap(bitmap);
end

--设置折叠时标题颜色
function MyToolbar.setCollapsedTitleColor(color)
  collapsingToolbarLayout.setCollapsedTitleTextColor(color)
  collapsingToolbarLayout.setCollapsedSubtitleTextColor(color)
end

--展开时标题颜色
function MyToolbar.setExpandedTitleColor(color)
  collapsingToolbarLayout.setExpandedTitleTextColor(color)
  collapsingToolbarLayout.setExpandedSubtitleTextColor(color)
end

--标题栏点击事件
function MyToolbar.setCollapsedOnClick(func)
  toolBar.onClick=func
end