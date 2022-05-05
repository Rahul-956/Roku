sub Init()
    m.rowlist=m.top.FindNode("rowList")
    m.rowList.setFocus(true)
    ' m.descriptionLabel=m.top.FindNode("descriptionLabel") 'Label with item desccription
    m.top.ObserveField("visible","OnVisibleChange")'observe visiblr field so we can see GRidscreen change visiblity
    m.rowList.ObserveField("rowItemFocused","OnItemFocused") 
    'observe reservedItemFocus so we can know when another item of row will be focused
end sub

sub OnVisibleChange() ' invoked when GridScreen change visibility
    if m.top.visible = true
        m.rowList.SetFocus(true) ' set focus to rowList if GridScreen visible
    end if
end sub


sub downClicked()
    m.rowList.SetFocus(true) 
    m.rowList.focusXOffset=[(0)]
end sub