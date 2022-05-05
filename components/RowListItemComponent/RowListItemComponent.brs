sub init()
    m.top.id = "rowList"
    m.itemposter = m.top.findNode("poster") 
    m.itemmask = m.top.findNode("itemMask")
    m.focuslabel = m.top.findNode("focusLabel")
    m.title = m.top.findNode("title")
  end sub
  


sub OnContentSet() 'invoked when item metadata retrived
    content=m.top.itemContent 
    if content<> invalid
        m.itemposter.uri = content.hdPosterUrl
        m.title.text=content.title
    end if
end sub

