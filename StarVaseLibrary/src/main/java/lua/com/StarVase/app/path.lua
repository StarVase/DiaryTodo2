path={}
import "android.os.Environment"

envdir=Environment.getExternalStorageDirectory().toString()
pkgname=activity.getPackageName()
path.envdir=envdir
path.data=envdir.. "/Android/data/"..pkgname.."/data/"
path.app=envdir.. "/Android/data/"..pkgname.."/"

path.diary=path.data..".diary/"
path.todo=path.data..".todo/"
path.favorote=path.data..".favorite/"
path.backup=envdir.."/StarVase/DiaryTodo/backup/"
path.dustbin=envdir.."/StarVase/DiaryTodo/.dustbin/"
path.StarVase=envdir.."/StarVase/"
path.picture=envdir.."/Pictures/DiaryTodo/"
return path
