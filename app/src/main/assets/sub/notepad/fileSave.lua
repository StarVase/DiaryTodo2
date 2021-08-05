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
      db.update("inspiration", values, "id=?", {tostring(id)});
    end
  })).run()
end

function saveCollection(id,title,content)
  Thread(Runnable({
    run=function()
      values = ContentValues();
      values.put("title",title);
      values.put("content", content);
      db.update("collection", values, "id=?", {tostring(id)});
    end
  })).run()
end




function save()
  Thread(Runnable({
    run=function()
      switch doctype
       case "diaryX" then
        saveDiary(details.id,Widgettitle.Text,Widgetcontent.text)
       case "inspirationX" then
        saveInspiration(details.id,Widgettitle.Text,Widgetcontent.text)
       case "collectionX" then
        saveCollection(details.id,Widgettitle.Text,Widgetcontent.text)
      end
    end
  })).run()
end