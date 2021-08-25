if activity.getSharedData("WeatherTip")==true then
  GetWeatherUrl="https://m.tianqi.com/"
  Http.get(GetWeatherUrl,nil,"utf8",nil,function(code,content,cookie,header)
    print(code)
    if(code==403 and content)then
      cityName=content:match("<text>(.-)</text>") or ""
      water=content:match('<span class="b2"><i></i>湿度(.-)</span') or ""
      --pz=content:match('<div class="info"><span class="b1"><i></i>(.-)</span')
      wind_level=content:match('<span class="b3"><i></i>(.-)</span>') or ""
      wind=wind_level:match("(.+) ") or ""
      level=wind_level:match(" (.+)") or ""
      temperature=content:match('<dd class="now">(.-)<i>') or ""
      quility_aqi=content:match('<div class="info"><a href="/air/zhumadian/" class="b1"><i></i>(.-)</a>') or ""
      quility=quility_aqi:match("(.+) ") or ""
      aqi=quility_aqi:match(" (.+)") or ""
      state_tem=content:match('<dd class="txt">(.-)</dd>') or ""
      state=state_tem:match("(.+) ") or ""
      tem=state_tem:match(" (.+)") or ""
      weatherImage=content:match('<dt><img src="(.-)"></dt>')
      gx=content:match('<text id="nowHour">(.-)</text>')
      --print(weatherImage)



      weather.addView(loadlayout({
        LinearLayout,
        layout_width="fill",
        orientation="vertical";
        id="mcardparent",
        {
          MaterialCardView;--卡片控件
          --layout_margin='3%w';--卡片边距
          layout_gravity='center';--重力属性
          elevation=0;--阴影属性
          layout_width='fill';--卡片宽度
          StrokeColor=lightForceColor,
          StrokeWidth=math.dp2int(2),
          --CardBackgroundColor=graph.修改颜色强度(5,mainColor);--卡片背景颜色
          layout_height='wrap';--卡片高度
          radius='16dp';--卡片圆角
          id="mcard",
          {
            LinearLayout;--线性布局
            layout_margin=dp2px(15);
            orientation='vertical';--重力属性
            layout_width='fill';--布局宽度
            layout_height='fill';--布局高度
            id="wFream",
            --background=graph.Ripple(nil,rippleColor),
            onClick=function()
              if not isShow then
                openAnimation()
               else
                closeAnimation()
              end
            end,
            {
              LinearLayout;--线性布局
              orientation='horizontal';--重力属性
              layout_width='fill';--布局宽度
              layout_height='wrap';--布局高度
              background='';--布局背景颜色(或者图片路径)
              id="weatherTop",
              {
                ImageView;--图片控
                id="weatherImg",
                --src='https://m.tianqi.com/'..weatherImage;--图片路径
                scaleType='fitXY';--图片显示类型
                ColorFilter=icon;--图片着色
              };
              {
                TextView;--文本控件
                id="temperature_text";
                layout_marginLeft="15dp";
                layout_gravity="center";
                textColor=icon;--文字颜色
                text=temperature.."°";--显示的文字
                textSize='40sp';--文字大小
              };
              {
                LinearLayout;--线性布局
                layout_marginLeft="15dp";
                layout_gravity="center";
                orientation='vertical';--重力属性

                {
                  TextView;--文本控件
                  textColor=textColor;--文字颜色
                  text=state;--显示的文字
                  textSize='20sp';--文字大小
                };
                {
                  TextView;--文本控件
                  textColor=textColor-0x77000000;--文字颜色
                  text=cityName;--显示的文字
                  textSize='15sp';--文字大小
                };
              };
            };
            {
              LinearLayout,
              layout_height='wrap',
              layout_width='fill',
              id="weatherSub",
              padding="2dp",
              --
              orientation="horizontal";
              Gravity="center",
              --paddingBottom="10dp",
              {
                TextView;--文本控件
                paddingTop="15dp";
                padding="1dp",
                layout_weight='1';--文本宽度
                textColor=textColor;--文字颜色
                text='温度 \n'..tem,
                Gravity="center",
                textSize='14sp';--文字大小
              },
              {
                TextView;--文本控件
                paddingTop="15dp";
                layout_weight='1';
                padding="1dp",
                textColor=textColor;--文字颜色
                text="湿度 \n"..water,--显示的文字
                Gravity="center",
                textSize='14sp';--文字大小
              },
              {
                TextView;--文本控件
                paddingTop="15dp";
                padding="1dp",
                layout_weight='1';--文本宽度
                textColor=textColor;--文字颜色
                text="风向 \n"..wind,
                Gravity="center",
                textSize='14sp';--文字大小
              },
              {
                TextView;--文本控件
                paddingTop="15dp";
                padding="1dp",
                layout_weight='1';--文本宽度
                textColor=textColor;--文字颜色
                text="风力 \n"..level,
                Gravity="center",
                textSize='14sp';--文字大小
              },
            };
          };
        };
      }
      ))
      --
      graph.Ripple(wFream,淡色强调波纹)


      --loadGlideBitmap('https://m.tianqi.com/'..weatherImage,weatherImg)
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

          ObjectAnimator.ofFloat(melse, "y", {mcardparent.getHeight(),weatherTopHeight+weatherSubHeight+dp2px(30)})
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
          ValueAnimator().ofFloat({mcardparent.getHeight(),weatherTopHeight+dp2px(30)})
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

      Translate_up_down=TranslateAnimation(weather.getWidth(), 0, 0, 0)
      Translate_up_down.setDuration(600)
      Translate_up_down.setFillAfter(true)
      Translate_up_down.setInterpolator(AnimationUtils.loadInterpolator(this,android.R.anim.decelerate_interpolator));
      Alpha=AlphaAnimation(0,1)
      Alpha.setDuration(800)

      as.addAnimation(Translate_up_down)
      as.addAnimation(Alpha)

      weather.setAnimation(as)
      as.start()

      temperature_text.getPaint().setFakeBoldText(true)
      task(400,function()
        weatherSubHeight=weatherSub.getHeight()
        weatherTopHeight=weatherTop.getHeight()
        closeAnimation(100)
        --print(weatherSubHeight,weatherTopHeight)
      end)
     else
    end
  end)
end