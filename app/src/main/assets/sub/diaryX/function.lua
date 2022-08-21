import "android.database.sqlite.*"

--打开数据库(没有自动创建)
db = CreateFileUtil.getDatabase()
--execSQL()方法可以执行insert、delete、update和CREATE TABLE之类有更改行为的SQL语句
function exec(sql)
  db.execSQL(sql);
end

--rawQuery()方法用于执行select语句。
function raw(sql,text)
  cursor=db.rawQuery(sql,text)
end

function toBoolean(int)
  if int==1 then
    return true
   else
    return false
  end
end


--初始化创建数据库
--id integer
--title text,
--creatTimestamp integer,
--year integer,
--month integer,
--day integer,
--isEmp boolean
--key text,
--content text


function Refresh(dateConf)
  nodata.setVisibility(View.GONE)
  adapter.clear()
  condition=""
  if dateConf && dateConf.year && dateConf.month && dateConf.day then
    condition=" where year = "..tostring(dateConf.year)
    .." and month = "..tostring(dateConf.month)
    .." and day = "..tostring(dateConf.day)
    date.text=tostring(dateConf.year).."/"..tostring(dateConf.month).."/"..tostring(dateConf.day)
   else
    date.text=AdapLan("全部","All")
  end
  sql="select * from diary"..condition.." order by id desc"

  if pcall(raw,sql,nil) then
    while (cursor.moveToNext()) do


      id = cursor.getInt(0); --获取第一列的值,第一列的索引从0开始
      title = cursor.getString(1);--获取第二列的值
      year = cursor.getInt(3);--获取第三列的值
      month = cursor.getInt(4);
      day = cursor.getInt(5);
      isEmp = cursor.getInt(6);
      key = cursor.getString(7);
      datestr=tostring(year)..tostring(month)..tostring(day)
      if toBoolean(isEmp) then
        img=R.drawable.ic_lock_outline
        alpha=0.32
       else
        img=R.drawable.ic_lock_open_variant_outline
        alpha=1
      end
      adapter.add(
      {
        title={
          Text=title,
        },
        image={
          ImageResource=img,
          alpha=alpha,
        },
        sub={
          Text=tostring(year).."/"..tostring(month).."/"..tostring(day),
        },
        id=id,
        date={y=year,m=month,d=day},
        isEmp=toBoolean(isEmp)
      })
    end
    cursor.close()
    if #data == 0 then
      nodata.setVisibility(View.VISIBLE)
    end
  end
  loading.setVisibility(View.GONE)
  sr.setRefreshing(false);
end

function delete(id)
  db.delete("diary", "id=?", {tostring(id)});
  Refresh()
end

function clickToUnlock(psk,id)
  Thread(Runnable({run=function()
      local ErrCount=0
      if (id == nil) then
        sql="select * from diary where isEmp=1 order by id desc"
       else
        sql=string.format("select * from diary where isEmp=1 and id=%s order by id desc",tostring(id))
      end
      if pcall(function()cursor=CreateFileUtil.raw(sql,nil)end) then
        while (cursor.moveToNext()) do
          id = cursor.getInt(0); --获取第一列的值,第一列的索引从0开始
          isEmp = cursor.getInt(6);
          key = cursor.getString(7);
          content = cursor.getString(8);
          import "rc4"
          trueKey=minicrypto.decrypt(key,"Diaryenced")
          if psk != trueKey then
            ErrCount=ErrCount+1
           else
            content=minicrypto.decrypt(content,trueKey)
            values = ContentValues();
            values.put("isEmp",false);
            values.put("key", nil);
            values.put("content",content)
            CreateFileUtil.getDatabase().update("diary", values, "id=?", {tostring(id)});
          end
        end
        cursor.close()
      end
      MyToast.showSnackBar(string.format(AdapLan("解密完成，共%s个错误","Decryption finished, and occurred %s error(s) in total."),ErrCount))
      Refresh()
    end})).run()
end



function clickToLock(id)
  Thread(Runnable({run=function()
      local SucCount = 0
      local DiaryPassword = activity.getSharedData("DiaryPassword")
      if DiaryPassword != nil && DiaryPassword != "" && activity.getSharedData("EncryptDiary") then
        if (id == nil) then
          sql="select * from diary where isEmp=0 order by id desc"
         else
          sql=string.format("select * from diary where isEmp=0 and id=%s order by id desc",tostring(id))
        end

        if pcall(function()cursor=CreateFileUtil.raw(sql,nil)end) then
          while (cursor.moveToNext()) do
            id = cursor.getInt(0); --获取第一列的值,第一列的索引从0开始
            isEmp = cursor.getInt(6);
            --key = cursor.getString(7);
            content = cursor.getString(8);
            import "rc4"
            key=minicrypto.encrypt(DiaryPassword,"Diaryenced")


            content=minicrypto.encrypt(content,DiaryPassword)
            values = ContentValues();
            values.put("isEmp",true);
            values.put("key", key);
            values.put("content",content)
            CreateFileUtil.getDatabase().update("diary", values, "id=?", {tostring(id)});
            SucCount=SucCount+1
          end
          cursor.close()
        end
        MyToast.showSnackBar(string.format(AdapLan("加密完成，共%s个成功","Encryption finished, and %s task(s) succeeded."),tostring(SucCount)))
        Refresh()
      end
    end})).run()
end
