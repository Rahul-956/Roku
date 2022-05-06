function init()
    m.buttonArea = m.top.findNode("buttonArea")
    m.top.observeFieldScoped("buttonFocused", "printFocusButton")
    m.top.observeFieldScoped("buttonSelected", "printSelectedButtonAndClose")
    m.top.observeFieldScoped("wasClosed", "wasClosedChanged")
end function

sub printFocusButton()
    ?"m.buttonArea button ";m.buttonArea.getChild(m.top.buttonFocused).text;" focused"
end sub

sub printSelectedButtonAndClose()
    ?"m.buttonArea button ";m.buttonArea.getChild(m.top.buttonSelected).text;" selected"
    m.top.close = true
end sub

sub wasClosedChanged()
    ?"SideCardRightDialog Closed"
end sub