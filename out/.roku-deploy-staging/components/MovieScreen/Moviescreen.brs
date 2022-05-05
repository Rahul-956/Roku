sub Init()
   
    m.MarkupGrid=m.top.FindNode("MarkupGrid")
    m.markupGrid.setFocus(true)
    ' m.descriptionLabel=m.top.FindNode("descriptionLabel") 'Label with item desccription
    m.titleLabel=m.top.FindNode("titleLabel")
    m.titleLabel=m.top.FindNode("titleLabel") 'Label with item title

    m.busyspinner = m.top.findNode("loadingIcon")
    m.busyspinner.poster.observeField("loadStatus", "showspinner")
    m.busyspinner.poster.uri = "pkg:/images/busyspinner.png"
    
end sub



sub showspinner()
    if(m.busyspinner.poster.loadStatus = "ready")
      centerx = (1280 - m.busyspinner.poster.bitmapWidth) / 2
      centery = (720 - m.busyspinner.poster.bitmapHeight) / 2
      m.busyspinner.translation = [ centerx, centery ]
    end if
end sub



function onKeyEvent(key as string, press as boolean) as boolean
  result=false
      if press
      
          if key="up"
             
            

          end if
      end if

  return result  
end function

sub downClicked()
  m.MarkupGrid.SetFocus(true) 
  m.MarkupGrid.focusXOffset=[(0)]
end sub




