require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "StarVase"
--import "muk"
--删掉“--”注释符号以使用中文函数

if activity.getSharedData("diaryRC4PSK")==nil then
  输入对话框("设置秘钥","秘钥",date,"确定","取消",function() onEditDialogCallback(edit:getText()) 关闭对话框(an) return edit.Text end,function() 关闭对话框(an) return nil end ,nil,'numberPassword')

  function onEditDialogCallback(edit)
    task(500,function()
      activity.setSharedData("diaryRC4PSK",edit)
      println("设置成功")
      activity.result{'true'}
      pcall(function()
        oneKeyEncodeDiary(activity.getSharedData("diaryRC4PSK"))
      end)

    end)
  end
 else
  println('已经设置过秘钥')
  activity.finish()
end