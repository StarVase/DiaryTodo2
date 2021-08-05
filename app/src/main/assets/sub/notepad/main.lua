require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "StarVase"
import "com.google.android.material.floatingactionbutton.FloatingActionButton"
import "android.animation.LayoutTransition"
import "android.webkit.*"
import "android.support.v4.widget.*"
import "java.io.*"
import "ren.qinc.edit.*"
import "com.jsdroid.editor.HVScrollView"
import "androidx.appcompat.widget.AppCompatEditText"
layout=importFile("notepad","layout")

doctype,title,details=...
pcall(function()activity.setSwipeBackEnable(false);end)
--activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(mainColor);

importFile("notepad","UIHelper")
importFile("notepad","fileSave")
importFile("notepad","fileLoader")


if title then
  Widgettitle.Text=title
end


if cannotSetTitle then
  Widgettitle.setFocusable(false)
 else
  Widgettitle.setFocusable(true)
end





if not content then
  --Widgetcontent.text=io.open(path):read("*a")
end

mPerformEdit.clearHistory()

arg=0
function AUTO_SWITCH_OR_FINISH()
  save()
  if page.getCurrentItem()~=0 then
    page.showPage(0)
   else
    if arg+2 > tonumber(os.time()) then
      activity.finish()
     else
      MyToast.showSnackBar("已保存，再按一次后关闭")

      arg=tonumber(os.time())
    end
  end
end



function onPause()
  save()
end

function MarkText(text)
  content=string.gsub(text,"\n", "\\n")
  content=string.gsub(content,"\"", "\\\"")
  content=string.gsub(content,"'", "\\'")
  if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) then
    webView.evaluateJavascript("javascript:MarkText(\"" ..content .."\");", nil);
   else
    webView.loadUrl("javascript:MarkText(\"" ..content.. "\");");
  end
end


--[[Widgetcontent.addTextChangedListener({
  --onTextChange()
  })]]






function onKeyDown(code,event)
  save()
  if string.find(tostring(event),"KEYCODE_BACK") then
    AUTO_SWITCH_OR_FINISH()
    return true
  end
end
webView.setWebViewClient({
  shouldOverrideUrlLoading=function(view,url)
    --Url即将跳转
  end,
  onPageStarted=function(view,url,favicon)
    --网页加载
    if AppTheme.isDarkTheme() then
      webView.evaluateJavascript([[javascript:/*
 * @name: 野径云俱黑，江船火独明
 * @Author: 谷花泰
 * @version: 5.1
 * @description: 让你的网页随风潜入夜
 * @include: *
 * @createTime: 2019-10-19 01:09:24
 * @updateTime: 2019-10-20 02:36:48
 */
(function () {
  /* 判断是否该执行 */
  /* 网址黑名单制，遇到这些域名不执行 */
  const blackList = ['example.com'];

  const hostname = window.location.hostname;
  const key = encodeURIComponent('谷花泰:野径云俱黑，江船火独明:执行判断');
  const isBlack = blackList.some(keyword => {
    if (hostname.match(keyword)) {
      return true;
    };
    return false;
  });

  if (isBlack || window[key]) {
    return;
  };
  window[key] = true;

  /* 开始执行代码 */
  class ChangeBackground {
    constructor() {
      this.init();
    };
    init() {
      this.addStyle(`
        html, body {
          background-color: #000 !important;
        }
        * {
          color: #CCD1D9 !important;
          box-shadow: none !important;
        }
        *:after, *:before {
          border-color: #1e1e1e !important;
          color: #CCD1D9 !important;
          box-shadow: none !important;
          background-color: transparent !important;
        }
        a, a > *{
          color: #409B9B !important;
        }
        [data-change-border-color][data-change-border-color-important] {
          border-color: #1e1e1e !important;
        }
        [data-change-background-color][data-change-background-color-important] {
          background-color: #000 !important;
        }
      `);
      this.selectAllNodes(node => {
        if (node.nodeType !== 1) {
          return;
        };
        const style = window.getComputedStyle(node, null);
        const whiteList = ['rgba(0, 0, 0, 0)', 'transparent'];
        const backgroundColor = style.getPropertyValue('background-color');
        const borderColor = style.getPropertyValue('border-color');
        if (whiteList.indexOf(backgroundColor) < 0) {
          if (this.isWhiteToBlack(backgroundColor)) {
            node.dataset.changeBackgroundColor = '';
            node.dataset.changeBackgroundColorImportant = '';
          } else {
            delete node.dataset.changeBackgroundColor;
            delete node.dataset.changeBackgroundColorImportant;
          };
        };
        if (whiteList.indexOf(borderColor) < 0) {
          if (this.isWhiteToBlack(borderColor)) {
            node.dataset.changeBorderColor = '';
            node.dataset.changeBorderColorImportant = '';
          } else {
            delete node.dataset.changeBorderColor;
            delete node.dataset.changeBorderColorImportant;
          };
        };
        if (borderColor.indexOf('rgb(255, 255, 255)') >= 0) {
          delete node.dataset.changeBorderColor;
          delete node.dataset.changeBorderColorImportant;
          node.style.borderColor = 'transparent';
        };
      });
    };
    addStyle(style = '') {
      const styleElm = document.createElement('style');
      styleElm.innerHTML = style;
      document.head.appendChild(styleElm);
    };
    /* 是否为灰白黑 */
    isWhiteToBlack(colorStr = '') {
      let hasWhiteToBlack = false;
      const colorArr = colorStr.match(/rgb.+?\)/g);
      if (!colorArr || colorArr.length === 0) {
        return true;
      };
      colorArr.forEach(color => {
        const reg = /rgb[a]*?\(([0-9]+),.*?([0-9]+),.*?([0-9]+).*?\)/g;
        const result = reg.exec(color);
        const red = result[1];
        const green = result[2];
        const blue = result[3];
        const deviation = 20;
        const max = Math.max(red, green, blue);
        const min = Math.min(red, green, blue);
        if (max - min <= deviation) {
          hasWhiteToBlack = true;
        };
      });
      return hasWhiteToBlack;
    };
    selectAllNodes(callback = () => { }) {
      const allNodes = document.querySelectorAll('*');
      Array.from(allNodes, node => {
        callback(node);
      });
      this.observe({
        targetNode: document.documentElement,
        config: {
          attributes: false
        },
        callback(mutations, observer) {
          const allNodes = document.querySelectorAll('*');
          Array.from(allNodes, node => {
            callback(node);
          });
        }
      });
    };
    observe({ targetNode, config = {}, callback = () => { } }) {
      if (!targetNode) {
        return;
      };

      config = Object.assign({
        attributes: true,
        childList: true,
        subtree: true
      }, config);

      const observer = new MutationObserver(callback);
      observer.observe(targetNode, config);
    };
  };
  new ChangeBackground();
})();]],nil)
    end
  end,
  onPageFinished=function(view,url)
    --网页加载完成
  end}
)
page.setOnPageChangeListener(PageView.OnPageChangeListener{
  --页面状态改变监听
  onPageScrolled=function(a,b,c)

  end,
  onPageSelected=function(v)
    --页面选中时（停止滚动时）
    MarkText(Widgetcontent.text)
    --text=activity.get("Widgetcontent.text")

  end
})
function onKeyShortcut(keyCode, event)
  local filteredMetaState = event.getMetaState() & ~KeyEvent.META_CTRL_MASK;
  if (KeyEvent.metaStateHasNoModifiers(filteredMetaState)) then
    switch(keyCode)
     case
      KeyEvent.KEYCODE_O

      return true;
     case
      KeyEvent.KEYCODE_P
      --预览
      page.showPage(1)
      return true;
     case
      KeyEvent.KEYCODE_S
      save();
      return true;
     case
      KeyEvent.KEYCODE_E
      --编辑
      page.showPage(0)
      return true;
     case
      KeyEvent.KEYCODE_R
      mPerformEdit.redo();
      return true;
     case
      KeyEvent.KEYCODE_N

      return true;
     case
      KeyEvent.KEYCODE_U
      mPerformEdit.undo();
      return true;
     case
      KeyEvent.KEYCODE_I

      return true;
     case
      KeyEvent.KEYCODE_M
      MarkText(Widgetcontent.text)
    end
  end
  return false;
end