require "import"
module(...,package.seeall)
types=require "sentences.version"


--[===============================[
$ Author : StarVase @ Coolapk
$ Date : 2021 Mar. 20th 11:22
$ Coolapk : StarVase
$ E-mail : lxz2102141297@163.com
$ Override from github project.
]===============================]


function getRandomType()
  val=math.random(1,#types.sentences)
  return types.sentences[val].key
end

function getRandomSentence(type)
  if type && type != "undefined" then
    yiyanTable=require("sentences."..type)
   else
    yiyanTable=require("sentences."..getRandomType())
  end
  length=#yiyanTable
  id=math.random(1,length)
  tab={
    sentence=yiyanTable[id].hitokoto,
    from=yiyanTable[id].from
  }
  return tab
end

function listYiyanType(arg)
  local data={}
  if arg == "key" then
    data[1]="undefined"
    for key,value in pairs(types.sentences) do
      table.insert(data,value.key)
    end
   elseif arg == "name" then
    data[1]="随机"
    for key,value in pairs(types.sentences) do
      table.insert(data,value.name)
    end
   elseif arg == "id" then
    data["undefined"]=1
    for key,value in pairs(types.sentences) do
      data[value.key]=key+1
    end
   else
    for key,value in pairs(types.sentences) do
      table.insert(data,{
        key=value.key,
        id=key,
        name=value.name
      })
    end
  end
  return data
end
