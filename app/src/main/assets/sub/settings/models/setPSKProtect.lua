require "import"

import "StarVase"
--import "muk"
--删掉“--”注释符号以使用中文函数

if activity.getSharedData("pskproask")==nil and activity.getSharedData("pskproword")==nil then
  输入对话框("设置密保问题","问题",date,"确定","取消",function() onEditDialogCallback(edit:getText()) 关闭对话框(an) return edit.Text end,function() 关闭对话框(an) return nil end )

  function onEditDialogCallback(edit)
    task(500,function()
      activity.setSharedData("pskproask",edit)
      输入对话框("设置密保答案","答案",date,"确定","取消",function() onEditDialogCallbackAgain(edit.Text) 关闭对话框(an) return edit.Text end,function() 关闭对话框(an) return nil end )
      function onEditDialogCallbackAgain(edit)
        activity.setSharedData("pskproword",edit)
        println("设置成功")
        activity.finish()
      end
    end)
  end
 else
  输入对话框("找回密码","输入'"..activity.getSharedData("pskproask",edit).."'的答案",date,"确定","取消",function() onEditDialogCallbackAgain(edit:getText()) 关闭对话框(an) return edit.Text end,function() 关闭对话框(an) return nil end )
  function onEditDialogCallbackAgain(edit)
    if edit==activity.getSharedData("pskproask") then
      if pcall(function()
          oneKeyDecodeDiary(activity.getSharedData('diarypsk'))
           end) then
        println('解密成功')
       else
        println("解密失败")
      end
      activity.finish()
     else println("错误") activity.finish()
    end
  end
end





















