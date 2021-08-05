package com.StarVase.library.view;


import android.graphics.Bitmap;
import android.graphics.drawable.Drawable;
import android.graphics.PixelFormat;
import android.graphics.Canvas;
import android.view.View;
import android.content.Context;
import android.util.AttributeSet;
import com.StarVase.library.view.BlurView.ViewCallBack;
import android.content.ContextWrapper;
import android.app.Activity;
import android.view.ViewTreeObserver;
import android.graphics.Rect;
import android.graphics.Paint;

//源码
public class BlurView extends View {
	public static final String TAG = "BlurView";

	private BlurView.ViewCallBack viewCallBack;
	private View mTargetView;
	private BlurView.BlurPreDrawListener mBlurPreDrawListener;

	private Bitmap mBlurredBitmap;
	private Bitmap mBlurringBitmap;
	private Canvas mBlurringCanvas;

	private float mBlurRadius = 8;
	private int mOverlayColor = 0x04000000;
	private float mScaleFractor = 12;
	private float mRoundCornerRadius = 0;

	private Rect mRectSrc;
	private Paint mPaint;
	private Rect mRectDst;
	public BlurView(Context context) {
		super(context);
		init();
	}
	public BlurView(Context context, AttributeSet attributeSet) {
		super(context, attributeSet);
		init();
	}
	public BlurView(Context context, AttributeSet attributeSet, int i) {
		super(context, attributeSet, i);
		init();
	}
	private void init() {
		mPaint = new Paint();
		mRectSrc = new Rect();
		mRectDst = new Rect();
		mPaint.setColor(mOverlayColor);
		mBlurPreDrawListener = new BlurPreDrawListener();
	}
	private View getTargetView() {
		try {
			return (View)getParent();
		} finally {
			Context ctx = getContext();
			for (int i = 0; i < 4 && ctx != null && !(ctx instanceof Activity) && ctx instanceof ContextWrapper; i++) {
				ctx = ((ContextWrapper) ctx).getBaseContext();
			}
			if (ctx instanceof Activity) {
				return ((Activity) ctx).getWindow().getDecorView();
			} else {
				return null;
			}
        }
	}
	protected void drawBlurredBitmap(Canvas canvas, Bitmap blurredBitmap, int overlayColor, float roundCornerRadius) {
        if (viewCallBack != null) {
            viewCallBack.onDraw(this, canvas, mPaint, blurredBitmap, overlayColor, roundCornerRadius);
		} else {
            if (blurredBitmap != null) {
                mRectSrc.right = blurredBitmap.getWidth();
                mRectSrc.bottom = blurredBitmap.getHeight();
                mRectDst.right = getWidth();
                mRectDst.bottom = getHeight();
                canvas.drawBitmap(blurredBitmap, mRectSrc, mRectDst, null);
			}
			mPaint.setColor(overlayColor);
			canvas.drawRect(mRectDst, mPaint);
		}
	}
	public void start(){
		if (mBlurPreDrawListener != null && mTargetView != null) {
			mTargetView.getViewTreeObserver().addOnPreDrawListener(mBlurPreDrawListener);
		}
	}
	public void stop(){
		if (mBlurPreDrawListener != null && mTargetView != null) {
			mTargetView.getViewTreeObserver().removeOnPreDrawListener(mBlurPreDrawListener);
		}
	}
	@Override
	protected void onAttachedToWindow() {
		mTargetView = getTargetView();
		super.onAttachedToWindow();
		if (mBlurPreDrawListener != null && mTargetView != null) {
			mTargetView.getViewTreeObserver().addOnPreDrawListener(mBlurPreDrawListener);
		}
	}
	@Override
	protected void onDetachedFromWindow() {
		super.onDetachedFromWindow();
		if (mBlurPreDrawListener != null && mTargetView != null) {
			mTargetView.getViewTreeObserver().removeOnPreDrawListener(mBlurPreDrawListener);
		}
	}
	@Override
	protected void onDraw(Canvas c) {
		super.onDraw(c);
		if (mBlurredBitmap == null) {
			return;
		}
		drawBlurredBitmap(c, mBlurredBitmap, mOverlayColor, mRoundCornerRadius);
	}
	@Override
	protected void onLayout(boolean z, int i2, int i3, int i4, int i5) {
		super.onLayout(z, i2, i3, i4, i5);
		mTargetView.getViewTreeObserver().addOnPreDrawListener(mBlurPreDrawListener);
	}
	private boolean prepare() {//实时更新关键代码，可参考上面错误代码
		if (mBlurRadius == 0) {
			return false;
		}
		if (mBlurringBitmap == null) {
			mBlurringBitmap = Bitmap.createBitmap((int) (getMeasuredWidth() / mScaleFractor),
												  (int) (getMeasuredHeight() / mScaleFractor), Bitmap.Config.RGB_565);
		}
		if (mBlurringBitmap == null) {
			return false;
		}
		if (mBlurringCanvas == null) {
			mBlurringCanvas = new Canvas(mBlurringBitmap);
		}
		if (mBlurredBitmap == null) {
			mBlurredBitmap = Bitmap.createBitmap((int) (getMeasuredWidth() / mScaleFractor),
												 (int) (getMeasuredHeight() / mScaleFractor), Bitmap.Config.RGB_565);
		}
		if (mBlurredBitmap == null) {
			return false;
		}
		return true;
	}
	private class BlurPreDrawListener implements ViewTreeObserver.OnPreDrawListener {
		@Override
		public boolean onPreDraw() {
			if (prepare()) {
				int[] targetLocation = new int[2];
				getLocationOnScreen(targetLocation);
				int saveC = mBlurringCanvas.save();//少了这个判断不出效果
				try {
					mBlurringCanvas.scale(1 / mScaleFractor, 1 / mScaleFractor);
					mBlurringCanvas.translate(-targetLocation[0], -targetLocation[1]);
					mTargetView.draw(mBlurringCanvas);
				} finally {
					mBlurringCanvas.restoreToCount(saveC);//少了这个判断不出效果
				}
				mBlurredBitmap = doBlur(mBlurringBitmap, (int) mBlurRadius, true);
			}
			return true;
		}
	}
	public BlurView setColor(int i) {
		mOverlayColor = i;
		return this;
	}
	public BlurView setRoundCorner(float i) {
		mRoundCornerRadius = i;
		return this;
	}
	public BlurView setScaleFractor(float i) {
		mScaleFractor = i;
		return this;
	}
	public BlurView setRadius(float i) {
		mBlurRadius = i;
		return this;
	}
	public BlurView setViewCallBack(ViewCallBack c) {
		viewCallBack = c;
		return this;
	}
	public interface ViewCallBack {
		void onDraw(BlurView view, Canvas canvas, Paint paint, Bitmap blurredBitmap, int overlayColor, float roundCornerRadius);
	}
	public static Bitmap doBlur(Drawable drawable, int r, boolean b) {//drawable转Bitmap并模糊
		Bitmap bitmap = Bitmap.createBitmap(
			drawable.getIntrinsicWidth(),
			drawable.getIntrinsicHeight(),
			drawable.getOpacity() != PixelFormat.OPAQUE ? Bitmap.Config.ARGB_8888
			: Bitmap.Config.RGB_565);
		Canvas canvas = new Canvas(bitmap);
		drawable.setBounds(0, 0, drawable.getIntrinsicWidth(), drawable.getIntrinsicHeight());
		drawable.draw(canvas);
		return doBlur(bitmap, r, b);
	}
	public static Bitmap doBlur(Bitmap sentBitmap, int radius, boolean canReuseInBitmap) {//模糊Bitmap
		Bitmap bitmap;
		if (canReuseInBitmap) {
			bitmap = sentBitmap;
		} else {
			bitmap = sentBitmap.copy(sentBitmap.getConfig(), true);
		}

		if (radius < 1) {
			return (null);
		}

		int w = bitmap.getWidth();
		int h = bitmap.getHeight();

		int[] pix = new int[w * h];
		bitmap.getPixels(pix, 0, w, 0, 0, w, h);

		int wm = w - 1;
		int hm = h - 1;
		int wh = w * h;
		int div = radius + radius + 1;

		int r[] = new int[wh];
		int g[] = new int[wh];
		int b[] = new int[wh];
		int rsum, gsum, bsum, x, y, i, p, yp, yi, yw;
		int vmin[] = new int[Math.max(w, h)];

		int divsum = (div + 1) >> 1;
		divsum *= divsum;
		int dv[] = new int[256 * divsum];
		for (i = 0; i < 256 * divsum; i++) {
			dv[i] = (i / divsum);
		}

		yw = yi = 0;

		int[][] stack = new int[div][3];
		int stackpointer;
		int stackstart;
		int[] sir;
		int rbs;
		int r1 = radius + 1;
		int routsum, goutsum, boutsum;
		int rinsum, ginsum, binsum;

		for (y = 0; y < h; y++) {
			rinsum = ginsum = binsum = routsum = goutsum = boutsum = rsum = gsum = bsum = 0;
			for (i = -radius; i <= radius; i++) {
				p = pix[yi + Math.min(wm, Math.max(i, 0))];
				sir = stack[i + radius];
				sir[0] = (p & 0xff0000) >> 16;
				sir[1] = (p & 0x00ff00) >> 8;
				sir[2] = (p & 0x0000ff);
				rbs = r1 - Math.abs(i);
				rsum += sir[0] * rbs;
				gsum += sir[1] * rbs;
				bsum += sir[2] * rbs;
				if (i > 0) {
					rinsum += sir[0];
					ginsum += sir[1];
					binsum += sir[2];
				} else {
					routsum += sir[0];
					goutsum += sir[1];
					boutsum += sir[2];
				}
			}
			stackpointer = radius;

			for (x = 0; x < w; x++) {

				r[yi] = dv[rsum];
				g[yi] = dv[gsum];
				b[yi] = dv[bsum];

				rsum -= routsum;
				gsum -= goutsum;
				bsum -= boutsum;

				stackstart = stackpointer - radius + div;
				sir = stack[stackstart % div];

				routsum -= sir[0];
				goutsum -= sir[1];
				boutsum -= sir[2];

				if (y == 0) {
					vmin[x] = Math.min(x + radius + 1, wm);
				}
				p = pix[yw + vmin[x]];

				sir[0] = (p & 0xff0000) >> 16;
				sir[1] = (p & 0x00ff00) >> 8;
				sir[2] = (p & 0x0000ff);

				rinsum += sir[0];
				ginsum += sir[1];
				binsum += sir[2];

				rsum += rinsum;
				gsum += ginsum;
				bsum += binsum;

				stackpointer = (stackpointer + 1) % div;
				sir = stack[(stackpointer) % div];

				routsum += sir[0];
				goutsum += sir[1];
				boutsum += sir[2];

				rinsum -= sir[0];
				ginsum -= sir[1];
				binsum -= sir[2];

				yi++;
			}
			yw += w;
		}
		for (x = 0; x < w; x++) {
			rinsum = ginsum = binsum = routsum = goutsum = boutsum = rsum = gsum = bsum = 0;
			yp = -radius * w;
			for (i = -radius; i <= radius; i++) {
				yi = Math.max(0, yp) + x;

				sir = stack[i + radius];

				sir[0] = r[yi];
				sir[1] = g[yi];
				sir[2] = b[yi];

				rbs = r1 - Math.abs(i);

				rsum += r[yi] * rbs;
				gsum += g[yi] * rbs;
				bsum += b[yi] * rbs;

				if (i > 0) {
					rinsum += sir[0];
					ginsum += sir[1];
					binsum += sir[2];
				} else {
					routsum += sir[0];
					goutsum += sir[1];
					boutsum += sir[2];
				}

				if (i < hm) {
					yp += w;
				}
			}
			yi = x;
			stackpointer = radius;
			for (y = 0; y < h; y++) {
				// Preserve alpha channel: ( 0xff000000 & pix[yi] )
				pix[yi] = (0xff000000 & pix[yi]) | (dv[rsum] << 16) | (dv[gsum] << 8) | dv[bsum];

				rsum -= routsum;
				gsum -= goutsum;
				bsum -= boutsum;

				stackstart = stackpointer - radius + div;
				sir = stack[stackstart % div];

				routsum -= sir[0];
				goutsum -= sir[1];
				boutsum -= sir[2];

				if (x == 0) {
					vmin[y] = Math.min(y + r1, hm) * w;
				}
				p = x + vmin[y];

				sir[0] = r[p];
				sir[1] = g[p];
				sir[2] = b[p];

				rinsum += sir[0];
				ginsum += sir[1];
				binsum += sir[2];

				rsum += rinsum;
				gsum += ginsum;
				bsum += binsum;

				stackpointer = (stackpointer + 1) % div;
				sir = stack[stackpointer];

				routsum += sir[0];
				goutsum += sir[1];
				boutsum += sir[2];

				rinsum -= sir[0];
				ginsum -= sir[1];
				binsum -= sir[2];

				yi += w;
			}
		}
		bitmap.setPixels(pix, 0, w, 0, 0, w, h);
		return (bitmap);
	}
}

