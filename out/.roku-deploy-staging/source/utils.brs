'function convert AA to Node
function ContentListToSimpleNode(contentList as Object, nodeType = "ContentNode" as String) as Object
    result = CreateObject("roSGNode", nodeType) ' create node instance based on specified nodeType
    if result <> invalid
        ' go through contentList and create node instance for each item of list
        for each itemAA in contentList
            item = CreateObject("roSGNode", nodeType)
            item.SetFields(itemAA)
            result.AppendChild(item) 
        end for
    end if
    return result
end function



'converts seconds to mm:ss format
function GetTime(length as integer) as String
    minutes=(length\60).toStr()
    seconds=length MOD 60
    if seconds<10
        seconds="0" +seconds.toStr()
    else
        seconds=seconds.toStr()
    end if
    return minutes + ":" + seconds
end function