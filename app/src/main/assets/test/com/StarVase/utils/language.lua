import "java.util.Locale"
NowLanguage = Locale.getDefault().getLanguage();

function AdaptationLanguage(zh,el)
  if NowLanguage=="zh" then
    return zh
   else
    return el
  end
end
AdapLan=AdaptationLanguage