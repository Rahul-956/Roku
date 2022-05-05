function Init()
    m.top.ObserveField("visible","OnVisibleChange") 'observe vissible os we can know visiblity change in detail screen
    m.top.ObserveField("itemFocused","OnItemFocusedChanged") ' to know which item in focus
    m.top.ObserveField("buttonSelected","BackButton")


    'save a referene to  the detail screen child component in the m varible
     'so we can access thrm in other function
    m.buttons=m.top.FindNode("buttons")
    m.back=m.top.FindNode("back")
    m.poster=m.top.FindNode("poster")
    m.description=m.top.FindNode("descriptionLabel")
    m.timeLabel=m.top.FindNode("timeLabel")
    m.titleLabel=m.top.FindNode("titleLabel")
    m.releaseLabel=m.top.FindNode("releaseLabel")

    'create button
    result=[]

    for each button in ["Play", "Back"]
        result.Push ({title:button})
    end for

    m.buttons.content= ContentListToSimpleNode(result)

    
    
end function

sub OnVisibleChange() 'when details screen visiblity changed
   ' set focus for button list when detail sceen is visible
    if m.top.visible=true
        m.buttons.setFocus(true)
        m.top.ItemFocused=m.top.jumpToItem
    end if
end sub

sub SetDetailsContent(content as Object)
     m.description.text = content.description
    m.poster.uri = content.hdPosterUrl 
    m.timeLabel.text = GetTime(content.length) 
    ?"content.length"content.length
    m.titleLabel.text = content.title 
    m.releaseLabel.text = content.releaseDate 

    ' if content.length= 0
    '     m.timeLabel.visibility="false"
    ' end if
end sub

sub OnJumpToItem() ' invoked when jumpToItem field is populated
    content = m.top.content
    ' check if jumpToItem field has valid value
    ' it should be set within interval from 0 to content.Getchildcount()
    if content <> invalid and m.top.jumpToItem >= 0 and content.GetChildCount() > m.top.jumpToItem
        m.top.itemFocused = m.top.jumpToItem
    end if
end sub

sub OnItemFocusedChanged(event as Object)' invoked when another item is focused
    focusedItem = event.GetData() ' get position of focused item
    content = m.top.content.GetChild(focusedItem) ' get metadata of focused item
    SetDetailsContent(content) ' populate DetailsScreen with item metadata
end sub



' The OnKeyEvent() function receives remote control key events
function OnkeyEvent(key as String, press as Boolean) as Boolean
    result = false
    if press
        currentItem = m.top.itemFocused ' position of currently focused item
        ' handle "left" button keypress
        if key = "left"
            ' navigate to the left item in case of "left" keypress
            m.top.jumpToItem = currentItem - 1 
            result = true
        ' handle "right" button keypress
        else if key = "right" 
            ' navigate to the right item in case of "right" keypress
            m.top.jumpToItem = currentItem + 1 
            result = true
        end if
    end if
    return result
end function