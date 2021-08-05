--只是让Aide Lua能够识别，实际并无卵用
tool={
  version="1.1",
}
appName="DiaryTodo"--应用名称
packageName="com.StarVase.diaryTodo"--应用包名
include={"project:app","project:Androlua"}--导入，第一个为主程序
compileLua=true--编译Lua

--相对路径位于工程根目录下
icon={
  day="ic_launcher-aidelua.png",--图标
  night="ic_launcher_night-aidelua.png",--暗色模式图标
}
