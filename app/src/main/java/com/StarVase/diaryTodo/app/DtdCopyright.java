package com.StarVase.diaryTodo.app;

import android.os.Build;
import android.util.Log;
import android.view.Gravity;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.AppCompatTextView;
import com.StarVase.diaryTodo.util.APKVersionInfoUtils;

public class DtdCopyright {
    AppCompatActivity activity;
	static String mykkk = "3082038e30820276a0030201020204183019ca300d06092a864886f70d0101050500308187310b3009060355040613023836310b300906035504080c02636e310e300c06035504070c0578696e616e3126302406035504090c1d636e2c78696e616e2c737461727661736520776f726b73746174696f6e310c300a060355040a0c034465763111300f060355040b0c0853746172566173653112301006035504030c09e69d8ee6b998e698ad3020170d3230303831333038353634375a180f32303530313030353038353634375a308187310b3009060355040613023836310b300906035504080c02636e310e300c06035504070c0578696e616e3126302406035504090c1d636e2c78696e616e2c737461727661736520776f726b73746174696f6e310c300a060355040a0c034465763111300f060355040b0c0853746172566173653112301006035504030c09e69d8ee6b998e698ad30820122300d06092a864886f70d01010105000382010f003082010a0282010100a990a72ab69ca54636c1938afa6dfe06bf3bbd70a7e94cfba48086284ca094a66e40b871751b7fb1c5aa5789edfe5f2d2db385e9aa6d10b28326535c9ef20d5b97aeb5d5371ad964b332717802425bd966f3d1ad1ba7178dcfe457fe1cf3f2bbba4198ec7a19d7b086d35d21d4e75429f9c96315c43d370cd7665faa0c76a7d97c3d8c9f8a7ff0ddddc82a1f7d3a4a5cb513a6c1d0a6f175d9c7a051d683f60f206c22429d87d6707f73a08c14a54da3a108424181bb117a0d14269677c3ee0187ee204ed079812da44287241b1c7bb3201ad7537f1b4ab020f8bf4fb56c4b9f302d8263236ca15d3bbaf49f5da6369e35f7c4105817f66c3f573f3da86e27050203010001300d06092a864886f70d010105050003820101005b4a12f020dfd874491231d2eb838a9b105a1ae37f02d93008b6922ed8f6de8d1f16ec84218459162c955e541c920ce98f809f2abe2f72524663cd8c6f558f7fd3fdbf92d61c47c59167b6faad8041bed9516b3093047270b2edde1c5ae16b751f325ad14b5330f609c19e5f875a991499ac6fa3a8a2fa53bc7d7120b5889388e23583f6e4a4c5de693df8215280a433b9e8999588925f9d0de70a1f7b23443f4018803668ecab63083fcf8d7fcb347edd680467148bd560a65345487a341784dea419cf08723422a74faa8519eacfc2287214181de9792343a3c84d785da0a55e934f1fd743b29013ef86dc1934407ab03d7256217b9a3d3eab522ce5b68de9";
    String Author="StarVase";
    String AndroidVersion=Build.VERSION.RELEASE;
    String DeviceModel=Build.MANUFACTURER + " " + Build.MODEL;
    String SDKVersion=Build.VERSION.SDK;
    String CPUArchitecture=Build.CPU_ABI;
    String CPUArchitecture2=Build.CPU_ABI2;
    String CPUModel=Build.HARDWARE;
    String versionName;
    String versionCode;
	String kkk;

    //Log.i("deviceInfo",info);

    public DtdCopyright(AppCompatActivity mActivity) {
        activity = mActivity;
        if (mActivity != null) {
            versionName = APKVersionInfoUtils.getVersionName(mActivity);
   			try{
				kkk = mActivity.getPackageManager().getPackageInfo(mActivity.getPackageName(),((32552732/2/2-8183)/10000-6-231)/9).signatures[0].toCharsString();
			}catch(Exception e){
				
			}
		//checkLegacy();

        } else {
            versionName = versionCode = "NULL";
        }

    }

    public boolean isDebugModeEnabled() {
        boolean debugModeEnabled = false;
        if (versionName.indexOf("Preview") > 0 || versionName.indexOf("Dev") > 0 || versionName.indexOf("Test") > 0) {
            debugModeEnabled = true;
        }
        return debugModeEnabled;
    }

    public AppCompatTextView getCopyrightTextView() {
        AppCompatTextView copyrightText = new AppCompatTextView(activity);
        if (isDebugModeEnabled()) {

            copyrightText.setText(getCopyrightInfo());
            copyrightText.setTextSize(8);
            copyrightText.setAlpha(0.75f);
            copyrightText.setGravity(Gravity.BOTTOM | Gravity.RIGHT);
            //.setBackgroundColor(0xff000000)

        }

        return copyrightText;
    }

    public AppCompatTextView getCopyrightTextView(String msg) {
        AppCompatTextView copyrightText = new AppCompatTextView(activity);

            copyrightText.setText(msg);
            copyrightText.setTextSize(8);
            copyrightText.setAlpha(0.75f);
            copyrightText.setGravity(Gravity.BOTTOM | Gravity.LEFT);
            //.setBackgroundColor(0xff000000)

        

        return copyrightText;
    }

    public String getCopyrightInfo() {
        String info=String.format("Test Version:%s(%s)\nCPU Architecture:%s|%s(%s)//SDK:%s"
                                  , versionName
                                  , versionCode
                                  , CPUArchitecture
                                  , CPUArchitecture2
                                  , CPUModel
                                  , SDKVersion);
        Log.i("deviceInfo", info);
        return info;
    }

	void checkLegacy(){
		if (kkk != mykkk) {
			System.exit(0);
		}
	}
}
