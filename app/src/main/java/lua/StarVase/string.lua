
function string.checkString(parentS,childS)
  local callback
  if string.find(tostring(parentS),tostring(childS)) ~= nil then
    callback=true
   else
    callback=false
  end
  return callback
end

function string.StringToTable(s)
  local tb = {}
  for utfChar in string.gmatch(s, "[%z\1-\127\194-\244][\128-\191]*") do
    table.insert(tb, utfChar)
  end
  return tb
end