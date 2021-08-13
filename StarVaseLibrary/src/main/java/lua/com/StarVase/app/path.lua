path={}
import "android.os.Environment"
path.data=Environment.getExternalStorageDirectory().toString().. "/Android/data/"..activity.getPackageName().."/data/"
path.app=Environment.getExternalStorageDirectory().toString().. "/Android/data/"..activity.getPackageName().."/"

path.diary=path.data..".diary/"
path.todo=path.data..".todo/"
path.favorote=path.data..".favorite/"
path.backup=Environment.getExternalStorageDirectory().toString().."/StarVase/diary&todo/backup/"
path.dustbin=Environment.getExternalStorageDirectory().toString().."/StarVase/diary&todo/.dustbin/"
path.StarVase=Environment.getExternalStorageDirectory().toString().."/StarVase/"
path.picture=Environment.getExternalStorageDirectory().toString().."/Picture/DiaryTodo/"
return path