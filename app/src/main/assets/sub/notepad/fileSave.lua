function saveDiary(id,title,content)
  Thread(Runnable({
    run=function()
      if __EMP then
        if _TRUEKEY then
          content=minicrypto.encrypt(content,usrKey)
          values = ContentValues();
          values.put("title",title);
          values.put("content", content);
          db.update("diary", values, "id=?", {tostring(id)});
         else
          --如果密码错误只保存标题
          values = ContentValues();
          values.put("title",title);
          db.update("diary", values, "id=?", {tostring(id)});

        end
       else
        values = ContentValues();
        values.put("title",title);
        values.put("content", content);
        db.update("diary", values, "id=?", {tostring(id)});
      end
    end
  })).run()
end


function saveInspiration(id,title,content)
  Thread(Runnable({
    run=function()
      values = ContentValues();
      values.put("title",title);
      values.put("content", content);
      values.put("updated",tostring(os.time()));
      db.update("inspiration", values, "id=?", {tostring(id)});
    end
  })).run()
end

function saveCollection(id,title,content)
  Thread(Runnable({
    run=function()
      values = ContentValues();
      values.put("title",tostring(title));
      values.put("content", tostring(content));
      values.put("updated",tostring(os.time()));
      db.update("collection", values, "id=?", {tostring(id)});
    end
  })).run()
end


function saveNormalFile(title,content)
  Thread(Runnable({run=function()
      filepath=details.path
      newpath=File(filepath).getParent().."/"..tostring(title)
      file.writeFile(newpath,tostring(content))
    end})).run()
end

function saveTodoDetail(title,contet)
  Thread(Runnable({run=function()
      filepath=path.data.."temp/temp_"..tostring(title)
      newpath=File(filepath).toString().."/"..tostring(os.date)
      file.writeFile(newpath,tostring(content))
    end})).run()
end


function save()
  if (_INITCONTENT!=Widgetcontent.text) then
    Thread(Runnable({
      run=function()
        switch doctype
         case "diaryX" then
          saveDiary(details.id,Widgettitle.Text,Widgetcontent.text)
         case "inspirationX" then
          saveInspiration(details.id,Widgettitle.Text,Widgetcontent.text)
         case "collectionX" then
          saveCollection(details.id,Widgettitle.Text,Widgetcontent.text)
          case "markdownX" then
          saveNormalFile(Widgettitle.Text,Widgetcontent.text)
          case "todoDetail" then
          saveTodoDetail(Widgettitle.Text,Widgetcontent.text)
        end
      end
    })).run()
  end
end