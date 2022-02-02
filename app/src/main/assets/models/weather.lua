
if activity.getSharedData("WeatherTip")==true then
  import "okhttp3.*"
  BASE_URL="https://www.tianqiapi.com/free/day?appid=55261352&appsecret=9cURW4VJ&unescape=1&cityid="

  cjson=require "cjson"
  request=Request.Builder()
  .url(BASE_URL)
  .build();

  call=OkHttpClient().newCall(request);
  call.enqueue(Callback{

    onFailure=function(call,e)
      Log.d("TAG",BASE_URL);
    end,


    onResponse=function(call,response)

      if(response.isSuccessful())then
        local result=response.body().string();
        activity.runOnUiThread(Runnable{
          run=function()
            result=cjson.decode(result)
            city=result.city
            updatetime=result.update_time
            wea=result.wea
            temmax=result.tem_day
            temmin=result.tem_night
            tem=result.tem
            temrange=temmin.."~"..temmax.."℃"
            win=result.win
            winspeed=result.win_speed
            winmeter=result.win_meter
            air=result.air
            focusing.addView(loadlayout(require"layouts.weather"))
            --graph.Ripple(wFream,淡色强调波纹)
            wFream.background=graph.Ripple(nil,淡色强调波纹,"方"),
            function AnimationLister(a,b)
              --动画状态监听
              import "android.animation.Animator$AnimatorListener"
              a.addListener(AnimatorListener{
                onAnimationEnd=function(m,z)
                  (b.onAnimationEnd or function()end) (m,z)
                end,
                onAnimationStart=function(m,z)
                  (b.onAnimationStart or function()end) (m,z)
                end,

              })
            end
            function openAnimation()
              --icon.setRotation(180)
              task(1,function()
                isShow=true


                --mtext.Text="is show"

                透明动画 = ObjectAnimator.ofFloat(weatherSub, "alpha", {0, 1})

                透明动画.setRepeatCount(0)--设置动画重复次数，这里-1代表无限
                透明动画.setDuration(500)

                ObjectAnimator.ofFloat(melse, "y", {mcard.getHeight(),weatherTopHeight+weatherSubHeight+dp2px(30)})
                .setDuration(300)
                .addUpdateListener{
                  onAnimationUpdate=function(a)
                    local x=a.getAnimatedValue()

                    local linearParams = mcard.getLayoutParams()
                    linearParams.height =x
                    mcard.setLayoutParams(linearParams)
                  end
                }.addListener({
                  onAnimationEnd=function()
                    weatherSub.setVisibility(0);
                    透明动画.start()
                  end
                }).start()

              end)
            end

            function closeAnimation(time)
              --icon.setRotation(0)Thread(Runnable({run=function()
              task(1,function()
                isShow=false

                透明动画 = ObjectAnimator.ofFloat(weatherSub, "alpha", {1, 0})

                透明动画.setRepeatCount(0)--设置动画重复次数，这里-1代表无限
                透明动画.setDuration(time or 500)
                weatherSub.Visibility=0
                ValueAnimator().ofFloat({mcard.getHeight(),weatherTopHeight+dp2px(30)})
                .setDuration(time or 300)
                .addUpdateListener{
                  onAnimationUpdate=function(a)
                    local x=a.getAnimatedValue()

                    local linearParams = mcard.getLayoutParams()
                    linearParams.height =x
                    mcard.setLayoutParams(linearParams)
                  end
                }.start()
                透明动画.addListener({
                  onAnimationEnd = lambda -> weatherSub.setVisibility(8)
                }).start()
              end)
            end


            import "android.view.animation.*"
            as= AnimationSet(true);

            Translate_up_down=TranslateAnimation(mcardparent.getWidth(), 0, 0, 0)
            Translate_up_down.setDuration(600)
            Translate_up_down.setFillAfter(true)
            --Translate_up_down.setInterpolator(AnimationUtils.loadInterpolator(this,android.R.anim.decelerate_interpolator));
            Alpha=AlphaAnimation(0,1)
            Alpha.setDuration(800)

            as.addAnimation(Translate_up_down)
            as.addAnimation(Alpha)

            mcardparent.setAnimation(as)
            as.start()

            temperature_text.getPaint().setFakeBoldText(true)
            --[[task(400,function()
              weatherSubHeight=weatherSub.getHeight()
              weatherTopHeight=weatherTop.getHeight()
              closeAnimation(100)
              --print(weatherSubHeight,weatherTopHeight)
            end)]]

            w = View.MeasureSpec.makeMeasureSpec(0,
            View.MeasureSpec.UNSPECIFIED);
            h = View.MeasureSpec.makeMeasureSpec(0,
            View.MeasureSpec.UNSPECIFIED);
            weatherSub.measure(w, h);
            weatherTop.measure(w, h);
            weatherSubHeight = weatherSub.getMeasuredHeight();
            weatherTopHeight = weatherTop.getMeasuredHeight()
            --mcardparentHeight = mcardparent.getMeasuredHeight()
            --mcardparentHeight = mcardparent.getMeasuredHeight()
            closeAnimation(0)
          end
        })
      end
    end,
  })


end

