import "android.graphics.Color"
import "android.animation.ObjectAnimator"
import "android.animation.ArgbEvaluator"
import "android.animation.ValueAnimator"
import "android.graphics.Typeface"
import "androidx.cardview.widget.CardView"
import "com.google.android.material.floatingactionbutton.FloatingActionButton"
bilu=
{
  FrameLayout;
  id="dr";
  backgroundColor=BGC;

  {
    RelativeLayout;
    layout_width="fill";
    layout_height="fill";


    {
      FlexibleScrollView;
      layout_width="fill";
      id="bit";
      OverScrollMode=2;
      -- verticalScrollBarEnabled=false;
      layout_height="fill";

      {
        LinearLayout;
        layout_width="fill";
        layout_height="fill";

        {
          LinearLayout;
          id="main";
          layout_width="fill";
          layout_height="fill";
        },


      };
    },
    {
      FrameLayout;
      layout_width="fill";
      id="menus";
      layout_alignParentTop="true";
      backgroundColor=BGC;
      layout_height="305dp";

      {
        FrameLayout,
        layout_width="fill",
        layout_height="305dp",

        {
          ImageView,
          layout_width="fill",
          layout_height="305dp";
          scaleType="centerCrop";
          id="mn",

        },
        {
          ImageView,
          layout_width="fill",
          layout_height="305dp";
          scaleType="centerCrop";
          alpha=0,
          id="mn2",
        },
      },
      {
        FrameLayout;
        layout_marginTop="24sp";
        layout_width="fill";
        id="gft";
        background="#00000000";
        layout_height="fill";
        {
          LinearLayout;
          layout_width="fill";
          id="reo";
          gravity="center";
          orientation="horizontal";
          layout_height="56dp";

          {
            View;
            layout_width="fill";
            layout_height="fill";
            layout_weight="1";
            layout_marginLeft="-15dp";
          };
          {
            CardView;
            layout_width="45dp";
            layout_height="45dp";
            background="#00000000";
            PreventCornerOverlap=false;
            CardElevation="0dp";
            radius="23dp";
            UseCompatPadding=false;
            {
              View;
              layout_width="fill";
              id="fg";
              layout_gravity="right",
              layout_height="0dp";
              layout_marginTop="55dp";
              layout_marginRight="4dp";
            };
            {
              ImageView;
              layout_width="fill";
              id="btn_sync";
              layout_height="fill";
              colorFilter=titleColor,
              background="#00000000";
              padding="10dp";
              src="images/sync.png";
            };
          };
          {
            CardView;
            layout_width="45dp";
            layout_height="45dp";
            background="#00000000";
            PreventCornerOverlap=false;
            CardElevation="0dp";
            radius="23dp";
            UseCompatPadding=false;
            {
              View;
              layout_width="fill";
              id="fg";
              layout_gravity="right",
              layout_height="0dp";
              layout_marginTop="55dp";
              layout_marginRight="4dp";
            };
            {
              ImageView;
              layout_width="fill";
              id="btn_menu";
              layout_height="fill";
              colorFilter=titleColor,
              background="#00000000";
              padding="10dp";
              src="images/menu.png";
            };
          };
        };
      };
      {
        View;
        background="#00000000";
        id="bhj",
        layout_width="fill";
        layout_height="24sp";
      };
    };
    {
      View;
      layout_height="224dp";
      id="mbys";
    };
    {
      View;
      layout_height="168dp";
      id="mby";
    };
    {
      LinearLayout;
      id="TitleParent";
      orientation="vertical";
      layout_width="fill",
      layout_height="wrap";
      layout_marginRight="100dp";
      layout_marginLeft="90dp";
      paddingBottom="22dp",
      layout_marginTop="252dp";

      {
        TextView;
        layout_width="fill";
        id="标题";
        gravity="center|left";
        ellipsize="end";
        text="Title";
        textColor="#FFFFFF";
        singleLine=true;
        textSize="18sp";
        layout_height="wrap";

      };
      {
        TextView;
        layout_width="fill";
        id="subTitle";
        gravity="center|left";
        ellipsize="end";
        text="Title";
        textColor="#FFFFFF";
        singleLine=true;
        textSize="12dp";
        --layout_height="24dp";

      };
    },
  };
  {
    LinearLayout;
    layout_width="fill";
    layout_height="fill";
    gravity="top|right";
    orientation="vertical";
    id="xu";
    {
      FloatingActionButton,
      id="tass",
      layout_marginTop="277dp";
      layout_height="56dp";
      layout_marginRight="20dp";
      layout_width="56dp";
      background="#ffffffff",
    }
  };
};

mainParent=bilu[2][2][2][2]

table.insert(mainParent,main_layout)
activity.setContentView(loadlayout(bilu))
--graph.Ripple(TitleParent,淡色强调波纹)
hsn=this.getResources().getDimensionPixelSize( luajava.bindClass("com.android.internal.R$dimen")().status_bar_height )--获取状态栏高
ns=tass
color1 = 0xffe71e62;
color2 = 0x00000000;

function vgy(view,color1,color2,times)
  ObjectAnimator.ofInt(view,"backgroundColor",{color1,color2}).setDuration(times).setEvaluator(ArgbEvaluator()).start()
  ObjectAnimator.ofFloat(ns,"alpha",{0,1}).setDuration(500).start()
end

function vgys(view,color1,color2,times)
  ObjectAnimator.ofInt(view,"backgroundColor",{color1,color2}).setDuration(times).setEvaluator(ArgbEvaluator()).start()
  ObjectAnimator.ofFloat(ns,"alpha",{1,0}).setDuration(500).start()
end

function vgys1(view,color1,color2,times)
  ObjectAnimator.ofInt(view,"backgroundColor",{color1,color2}).setDuration(times).setEvaluator(ArgbEvaluator()).start()
end

function vgys2(view,color1,color2,times)
  ObjectAnimator.ofInt(view,"backgroundColor",{color1,color2}).setDuration(times).setEvaluator(ArgbEvaluator()).start()
end

function sdry(e,i)
  ObjectAnimator().ofFloat(ns,"ScaleY",{e,i}).setDuration(300).start()
  ObjectAnimator().ofFloat(ns,"ScaleX",{e,i}).setDuration(300).start()
end

function refreshV7()
  task(10,function()
    ades=menus.getHeight()
    mainHeight=main.getHeight()
    drHeight=dr.getHeight()
    main.paddingBottom=drHeight-mainHeight-ades
    mbt=TitleParent.getY()
    TitleParent.setScaleY(1.6)
    TitleParent.setScaleX(1.6)
    layoutParams = main.getLayoutParams();
    layoutParams.setMargins(0,ades,0,0);--4个参数按顺序分别是左上右下
    main.setLayoutParams(layoutParams);
  end)
end
refreshV7()
ase=true

version_sdk = Build.VERSION.SDK
if tonumber(version_sdk)>=21 then
  menus.setTranslationZ(16)
  TitleParent.setTranslationZ(16)
end
--LayoutParams.MATCH_PARENT

function bit.onScrollChange(a,b,j,y,u)
  if j==0 then
    --置底
    TitleParent.setTranslationY(-hsn)
    mn2.alpha=0

    TitleParent.setTranslationY(0)
    TitleParent.setScaleY(1.6)
    TitleParent.setScaleX(1.6)
    linearParams = menus.getLayoutParams()
    linearParams.height =mbys.getHeight()+((mby.getHeight()/3)+hsn)

    menus.setLayoutParams(linearParams)
    mn.setTranslationY(0)
    mn2.setTranslationY(0)
    xu.setTranslationY(0)
    TitleParent.setTranslationX(0)

    if not ase then
      ase=true
      background = gft.getBackground();
      backgrounds1 = bhj.getBackground();
      vgy(gft,background.getColor(),color2,500)
      vgys1(bhj,backgrounds1.getColor(),color2,500)
      sdry(0,1)
    end

   elseif j > 0 and j <= mbys.getHeight() then
    --滑动中
    scale = j / mbys.getHeight();
    alpha = (255 * scale);
    if OnSwipe~=nil then
      OnSwipe(scale)
    end
    TitleParent.setTranslationY(-scale*mbys.getHeight())
    xu.setTranslationY(-scale*mbys.getHeight())
    mn.setTranslationY((-j/3))
    mn2.setTranslationY((-j/3))
    TitleParent.setTranslationX(-(scale*(mby.getHeight()/2.5)))
    TitleParent.setScaleY(1+(0.6*(1-scale)))
    TitleParent.setScaleX(1+(0.6*(1-scale)))
    linearParams = menus.getLayoutParams()
    linearParams.height =((mbys.getHeight()/4)+hsn)+(mbys.getHeight()-((j/mbys.getHeight())*mbys.getHeight()))
    menus.setLayoutParams(linearParams)

    if j<=mby.getHeight() then
      if not ase then
        --向下滑到变色
        if onSwipeDown~=nil then
          onSwipeDown()
        end
        ase=true
        background = gft.getBackground();
        backgroundsy1 = bhj.getBackground();
        vgy(gft,background.getColor(),color2,500)
        vgys1(bhj,backgroundsy1.getColor(),color2,500)
        sdry(0,1)
      end
     else
      if ase then
        if onSwipeUp~=nil then
          onSwipeUp()
        end
        ase=false
        backgrounds = gft.getBackground();
        backgroundsg1 = bhj.getBackground();
        vgys(gft,backgrounds.getColor(),color1,600)
        vgys2(bhj,backgroundsg1.getColor(),color1,600)
        sdry(1,0)
      end
    end

   else


    if ase then
      ase=false
      backgrounds = gft.getBackground();
      backgroundss1 = bhj.getBackground();
      vgys(gft,backgrounds.getColor(),color1,600)
      vgys2(bhj,backgroundss1.getColor(),color1,600)
      sdry(1,0)
    end
    TitleParent.setTranslationY(-(mby.getHeight()+(mbys.getHeight()/4)))
    TitleParent.setScaleY(1)
    TitleParent.setScaleX(1)
    mn.setTranslationY(-((mbys.getHeight())/3))
    mn2.setTranslationY(-((mbys.getHeight())/3))
    TitleParent.setTranslationX(-((mby.getHeight()/2.5)))

    xu.setTranslationY(-mbys.getHeight())
    linearParams = menus.getLayoutParams()
    linearParams.height =(mbys.getHeight()/4)+hsn
    menus.setLayoutParams(linearParams)
    if SwipeTop~=nil then
      SwipeTop()
    end

  end
end

标题.getPaint().setTypeface(Typeface.DEFAULT_BOLD)


function setTitle(string)
  if string~=nil then
    标题.Text=string
  end
end
function setSubTitle(string)
  if string~=nil then
    subTitle.setText(string)
  end
end

function setImage(mbt,mh)
  if mbt~=nil and mh~=nil then
    mn.setImageBitmap((mbt))
    mn2.setImageBitmap((mh))
  end
end


function FabImage(mbt)
  if mbt~=nil then
    tass.setImageBitmap(loadbitmap(mbt))
  end
end
import "android.content.res.ColorStateList"
function setFabColor(color)
  if color~=nil then
    tass.setSupportBackgroundTintList(ColorStateList.valueOf(color))
  end
end
function setTitleColor(color)
  if color~=nil then
    标题.setTextColor(color)
  end
end



function setFabImageColor(color)
  if color~=nil then
    tass.setColorFilter(color)
  end
end

function mcmd(func,...)
  if func~=nil then
    func(...)
  end
end
graph.Ripple(btn_menu,普通波纹)
graph.Ripple(btn_sync,普通波纹)

tass.setRippleColor(ColorStateList.valueOf(淡色强调波纹))
AutoSetToolTip(tass,"新建")

TitleParent.onClick=function()
  bitmap=mn.getDrawable().getBitmap()
  MyDialog.bitmapShow(bitmap)
end
btn_menu.onClick=function()
  mcmd(onMenuButtonClick)
end
btn_sync.onClick=function()
  mcmd(onSyncButtonClick)
end
tass.onClick=function()
  mcmd(onFabClick)
end
tass.onLongClick=function()
  mcmd(onFabLongClick)
end

function setMenuColor(mct)
  if mct~=nil then
    btn_menu.setColorFilter(mct)
  end
end
