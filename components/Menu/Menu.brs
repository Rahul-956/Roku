Sub Init()
    m.homeTab= m.top.findNode("homeTab")
    m.HomeBtn=m.top.FindNode("HomeBtn")

    m.movieTab= m.top.findNode("movieTab")
    m.MoviesBtn=m.top.FindNode("MoviesBtn")

    m.shortsTab= m.top.findNode("shortsTab")
    m.ShortsBtn=m.top.FindNode("ShortsBtn")

   
    m.buttons=m.top.FindNode("buttons")
    m.selectedTab=m.top.FindNode("selectedTab")
   
    m.homeBTn.setFocus(true)

    m.top.selectedTab="home"
    
end sub



function onKeyEvent(key as String, press as Boolean) as Boolean
    result = false
    
    if press then
        if key="down"
           m.top.downMenuClick="true"
           result=true

		else if key="up" 
            onLabelFocus()
        else if key = "right"
             rightKeyPress()  
        else if key="left"   
            leftKeyPress()
         
               
       end if
    end if
    return result
end function

sub onLabelFocus()
    
    if  m.selectedTab="home"
        m.homeBtn.setFocus(true)
        m.homeTab.color = "#000000"
        m.movieTab.color = "00FFFFFF"
        m.shortsTab.color = "00FFFFFF"
        ?" up button pressed  --------- hometab"
    else if m.selectedTab="movie"
        m.moviesBtn.setFocus(true)
        m.movieTab.color="#000000" ' making focus color black
        m.homeTab.color = "00FFFFFF" ' making the unfocused tab tranparent
        m.shortsTab.color="00FFFFFF"
        ?" up button pressed  --------- movietab"
    else if  m.selectedTab="shorts"
        m.shortsBtn.setFocus(true)
        m.shortsTab.color="#000000"
        m.movieTab.color="00FFFFFF"
        m.homeTab.color = "00FFFFFF"
        ?" up button pressed  --------- shortstab"
    end if
end sub 

sub rightKeyPress()
    if m.homeBtn.hasFocus()
        m.moviesBtn.setFocus(true)
        m.top.selectedTab="movie"
        ?"menuTab selected------" m.top.selectedTab
       
        m.movieTab.color="#000000" ' making focus color black
        m.homeTab.color = "00FFFFFF" ' making the unfocused tab transparent
        m.shortsTab.color="00FFFFFF"
        ?"Focus on ----MovieTab"

    else if m.moviesBtn.hasFocus()
        m.shortsBtn.setFocus(true)
        m.top.selectedTab= "shorts"
        ?"menuTab selected------" m.top.selectedTab
        m.shortsTab.color="#000000"
        m.movieTab.color="00FFFFFF"
        m.homeTab.color = "00FFFFFF"
        ?"Focus on ----ShortsTab"
       
     end if
end sub    

sub leftKeyPress()
    if m.moviesBtn.hasFocus()
      m.homeBtn.setFocus(true)
      m.top.selectedTab="home"
      ?"menuTab selected------" m.top.selectedTab
      m.homeTab.color = "#000000"
      m.movieTab.color = "00FFFFFF"
      m.shortsTab.color = "00FFFFFF"
      ?"Focus on ----HomeTab"

    else if m.shortsBtn.hasFocus()
      m.moviesBtn.setFocus(true)
      m.top.selectedTab= "movie"
      ?"menuTab selected------"m.top.selectedTab
      m.movieTab.color="#000000"
      m.shortsTab.color="00FFFFFF"
      m.homeTab.color = "00FFFFFF"
      ?"Focus on ----MovieTab"
    end if
end sub

