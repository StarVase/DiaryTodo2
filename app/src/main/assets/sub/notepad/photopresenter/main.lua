require "StarVase"(this,{enableTheme=true})
import "com.bumptech.glide.request.RequestOptions";
import "com.bumptech.glide.request.target.SimpleTarget"
import "com.StarVase.library.util.BlurTransformation"
import "com.bumptech.glide.load.resource.drawable.DrawableTransitionOptions"


photourl=...
activity.getSupportActionBar().hide()
activity.setContentView(loadlayout(require"layout"))
Glide.with(activity)
.load(photourl)
.transition(DrawableTransitionOptions.withCrossFade())
--.apply(RequestOptions.bitmapTransform(BlurTransformation(activity,18)))
.into(photo)