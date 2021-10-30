require "import"
module(...,package.seeall)
function TTS(T)
  import "android.speech.tts.*"
  mTextSpeech = TextToSpeech(activity, TextToSpeech.OnInitListener{
    onInit=function(status)
      --如果装载TTS成功
      if (status == TextToSpeech.SUCCESS)
        then result = mTextSpeech.setLanguage(Locale.CHINESE);
        --[[LANG_MISSING_DATA-->语言的数据丢失
          LANG_NOT_SUPPORTED-->语言不支持]]
        if (result == TextToSpeech.LANG_MISSING_DATA or result == TextToSpeech.LANG_NOT_SUPPORTED)
          then --不支持中文
          MyToast("您的手机不支持中文语音播报功能。安装谷歌语音转文本解决。");
          result = mTextSpeech.setLanguage(Locale.ENGLISH);
          if (result == TextToSpeech.LANG_MISSING_DATA or result == TextToSpeech.LANG_NOT_SUPPORTED)
            then --不支持中文和英文
            MyToast("您的手机不支持语音播报功能。安装谷歌语音转文本解决。");
           else
            --不支持中文但支持英文
            --语调,1.0默认
            mTextSpeech.setPitch(1);
            --语速,1.0默认
            mTextSpeech.setSpeechRate(1);
            mTextSpeech.speak("Your device may be cannot speak Chinese."..T, TextToSpeech.QUEUE_FLUSH, nil);
          end
         else
          --支持中文
          --语调,1.0默认
          mTextSpeech.setPitch(1);
          --语速,1.0默认
          mTextSpeech.setSpeechRate(1);
          mTextSpeech.speak(T, TextToSpeech.QUEUE_FLUSH, nil);
        end
      end
    end
  });
end