sub Init()
    m.top.backGroundColor="0x6f1bb1"  'set background colow for scene ,applied only when backgrounduri is null
    m.top.backGroundUri="pkg:/images/background.jpg"
    m.top.backgroundColor="#81B622"
    m.layoutTag=m.top.findNode("layoutTag")
    m.busyspinner = m.top.findNode("busySpinner")
    m.busyspinner.poster.observeField("loadStatus", "showspinner")
    m.busyspinner.poster.uri = "pkg:/images/busyspinner_hd.png"
    ShowWelcomeDialog()
    ' setMenuList()
        
    ' m.focusedMenu="home"

    ' InitScreenStack()
    ' ShowBaseScreen()
    ' RunContentTask()
end sub


sub showdialog()
    dialog = createObject("roSGNode", "Dialog")
    dialog.backgroundUri = "pkg:/images/rsgde_dlg_bg_hd.9.png"
    dialog.title = "Exit Dialog"
    dialog.optionsDialog = true
    dialog.message = "Do you Really want to exit app?"+ chr(10) +"Press OK to Quit"+chr(10) +"Press * To Dismiss"
    m.top.dialog = dialog
    dialog.buttons=["OK","Cancel"]
    dialog.observeField("buttonSelected","dialogButtonSelected")
end sub

sub dialogButtonSelected(event as object)

    ?"event---------"event.getData()
 index=event.getData()
 if index=0
    m.top.dialog.close=true
    m.top.exitApp=true
 else if index=1
    m.top.dialog.close=true
 end if
end sub

sub showspinner()
    if(m.busyspinner.poster.loadStatus = "ready")
      centerx = (1280 - m.busyspinner.poster.bitmapWidth) / 2
      centery = (720 - m.busyspinner.poster.bitmapHeight) / 2
      m.busyspinner.translation = [ centerx, centery ]
      m.busyspinner.visible = true     
    end if
end sub
  

  'OnKeyEvent() function receives remote control key events
'take two input one is key that receive the input and flag if it has been pressed

function OnKeyEvent(Key as String, press as Boolean) as Boolean
    result=false
    if press
        if key="back"
            numberOfScreens= m.screenStack.Count()
            if numberOfScreens>1
                CloseScreen(invalid)
                result=true
                
            else
                showdialog()
                result=true
            end if
        end if
        if key="up"
            menu = CreateObject("roSGNode","menu")
            ?"focused menu-------------------"m.focusedMenu
            menu.SetFocus(true)
            if m.focusedMenu="home"
                homeBtn =m.top.findNode("homeBtn")
                homeTab=m.top.findNode("homeTab")
                homeBtn.setFocus(true)
                 homeTab.color = "#000000"
                ?"Focus on ----hometab"
                result=true
            else if  m.focusedMenu="movie"
                MoviesBtn =m.top.findNode("MoviesBtn")
                movieTab=m.top.findNode("movieTab")
                MoviesBtn.setFocus(true)
                movieTab.color = "#000000"
                ?"Focus on ----Moviestab"
                result=true
            else if m.focusedMenu="shorts"
                shortsBtn =m.top.findNode("shortsBtn")
                shortsTab=m.top.findNode("shortsTab")
                shortsBtn.setFocus(true)
                shortsTab.color = "#000000"
                ?"Focus on ----shortTab"
           
            end if
        end if
           

        else if key="down"
            if  m.focusedMenu = "Home"
                rowlist= m.top.findNode("rowlist")
                rowlist.setFocus(true)
                result=true
            else if  m.focusedMenu = "movie"
                MarkupGrid= m.top.findNode("MarkupGrid")
                MarkupGrid.setFocus(true)
                result=true
            else if  m.focusedMenu ="shorts"
                
            end if  
        end if
        if key = "OK"
            
        end if

     return result

end function
'--------------------------------------------Welcome Dialog---------------------------------------------------

sub ShowWelcomeDialog()
    m.WelcomeDialog=createObject("rosgnode","WelcomeDialog")
    m.top.appendChild(m.WelcomeDialog)
    m.WelcomeDialog.observeField("buttonSelected", "WelcomeDalogSelected")
    m.WelcomeDialog.setFocus(true)
end sub

sub WelcomeDalogSelected(event as object)
    ?"event---------"event.getData()
    index=event.getData()
    if index=0
        setMenuList()
        
        m.focusedMenu="home"

        InitScreenStack()
        ShowBaseScreen()
        RunContentTask() 'retrieving content
        m.top.RemoveChild(m.WelcomeDialog)
    
    else if index=1
        m.top.RemoveChild(m.WelcomeDialog)
        m.top.exitApp=true
    end if
end sub

'----------------------------------------ScreeenStack-------------------------------------------------------------
sub InitScreenStack()
    m.screenStack = []
end sub

sub ShowScreen(node as Object)
    prev= m.screenStack.Peek() ' take current screen from screen stack but don't delete it
    ?"Screenstack before pushing screen--------" m.screenStack.Count()
    if prev <> invalid
        prev.visible = false ' hide current screen if it exist
    end if
    m.top.AppendChild(node) ' add new screen to scene
    ' show new screen
    node.visible = true
    node.SetFocus(true)
    m.screenStack.Push(node) ' add new screen to the screen stack
    after=m.screenStack.Peek() ' take current screen from screen stack after appending
    ?"Screenstack after pushing screen--------" m.screenStack.Count()
    if m.screenStack.Count() >1
        m.menu.visible="false"
      ?"Navigation  not visible"
    end if
end sub

sub CloseScreen(node as Object)
    if node = invalid OR (m.screenStack.Peek() <> invalid AND m.screenStack.Peek().IsSameNode(node))
        last = m.screenStack.Pop() ' remove screen from screenStack
        last.visible = false ' hide screen
        m.top.RemoveChild(last) ' remove screen from scene

        ' take previous screen and make it visible
        prev = m.screenStack.Peek()
        ?"Screenstack after poping screen--------"m.screenStack.Count()
        if prev <> invalid
            prev.visible = true
            prev.SetFocus(true)
        end if
        if m.screenStack.Count() <=1
            m.menu.visible="true"
            ?"Navigation visible"
          end if
    end if
end sub

function GetCurrentScreen()
    return m.screenStack.Peek()
end function



'---------------------------------------- Base-GridScreen Logic-------------------------------------------------------------
sub ShowBaseScreen()
    m.BaseScreen= CreateObject("roSGNode", "BaseScreen")
    m.top.AppendChild(m.Menu) 
    m.BaseScreen.ObserveField("rowItemSelected","OnBaseScreenItemSelected")
   
    ShowScreen(m.BaseScreen) 'show GridScreen
    ?"Basescreen intialized"
end sub

sub OnBaseScreenItemSelected(event as object) 'invoked when Greidscreen item is selected
    grid=event.GetRoSGNode()
    'extract the row and column indexes of the item the user selected
    m.selectedIndex=event.GetData()
    'the entire row from the rowlist will be used by the Video Node
    rowContent=grid.content.GetChild(m.selectedIndex[0])
    ?"selectedIndex-----------"m.selectedIndex[1]
   
    ShowDetailsScreen(rowContent,m.selectedIndex[1])
    
end SUb

'---------------------------------------- MovieScreen Logic-------------------------------------------------------------
sub ShowMovieScreen()
    ' try
    m.MovieScreen= CreateObject("roSGNode", "MovieScreen")
  
    m.MovieScreen.observeField("itemSelected","OnMovieItemSelected")
    ShowScreen(m.MovieScreen) 'show GridScreen
    RunMovieTask()
    ?"Moviescreen intialized"
    ' CATCH e     
    '   ?"mESSAGE: "e.message
    ' END TRY
end sub

sub OnMovieItemSelected(event as object) 'invoked when moviescreen item is selected
    grid=event.GetRoSGNode()
    'extract the row and column indexes of the item the user selected
    m.selectedIndex=event.GetData()
    'the entire row from the rowlist will be used by the Video Node
    rowContent=grid.content
    ?"selectedIndex-----------"m.selectedIndex
    ShowDetailsScreen(rowContent,m.selectedIndex)
    
end SUb


'----------------------------------------Movie Task Logic-------------------------------------------------------------
sub RunMovieTask()
    m.contentTask=  CreateObject("roSGNode","MovieTask")   'create task for feed retrieving
    m.contentTask.ObserveField("content","OnMovieContentLoaded") 'observe content so we can know when feed content will be parsed
    m.contentTask.control="run" 'GetContent(see MainLoader.brs) method is executed
    m.busySpinner.visible=true 'show loading indicator while content is loading
end sub

sub OnMovieContentLoaded() ' invoked when cotent is ready to use
    m.MovieScreen.SetFocus(true) ' set focus to grid screen
    m.busySpinner.visible=false 'hiding loading indicator
    m.MovieScreen.content=m.contentTask.content 'populate grid screen with content
end sub

'----------------------------------------Content Task Logic-------------------------------------------------------------
sub RunContentTask()
    m.contentTask=  CreateObject("roSGNode","MainLoaderTasks")   'create task for feed retrieving
    m.contentTask.ObserveField("content","OnMainContentLoaded") 'observe content so we can know when feed content will be parsed
    m.contentTask.control="run" 'GetContent(see MainLoader.brs) method is executed
    m.busySpinner.visible=true 'show loading indicator while content is loading
end sub

sub OnMainContentLoaded() ' invoked when cotent is ready to use
    m.BaseScreen.SetFocus(true) ' set focus to grid screen
    m.busySpinner.visible=false 'hiding loading indicator
    m.BaseScreen.content=m.contentTask.content 'populate grid screen with content
end sub


'----------------------------------------DetailsScreen Logic-------------------------------------------------------------

sub ShowDetailsScreen(content as Object, selectedItem as Integer)
    ' create new instance of details screen
    
    detailsScreen = CreateObject("roSGNode", "DetailsScreen")
    detailsScreen.content =content
    ?"SelectedItem--------------"SelectedItem
    detailsScreen.jumpToItem = selectedItem ' set index of item which should be focused
    detailsScreen.ObserveField("buttonSelected", "OnButtonSelected")
    ShowScreen(detailsScreen)
    ?"Detail screen intialized"
end sub

sub OnButtonSelected(event) ' invoked when button in DetailsScreen is pressed
    details = event.GetRoSGNode()
    content = details.content
    buttonIndex = event.getData() ' index of selected button
    selectedItem = details.itemFocused
    if buttonIndex = 0 ' check if "Play" button is pressed
        ' create Video node and start playback
        ShowVideoScreen(content, selectedItem) 
        ?"Video player  intialized"
    else
        CloseScreen(invalid)
        ?"Detail screen closed"
    end if
end sub


'----------------------------------------Video Player Logic------------------------------------------------------------


sub ShowVideoScreen(content as Object, itemIndex as Integer)
    m.videoPlayer = CreateObject("roSGNode", "Video") ' create new instance of video node for each playback
    videoContent=content.GetChild(itemIndex)
    m.videoPlayer.content=videoContent
    ?"content--------------"m.videoPlayer.content
   ShowScreen(m.videoPlayer) ' show video screen
   m.videoPlayer.control = "play" ' start playback
   ?"Video Player state-------"m.videoPlayer.state
   m.videoPlayer.ObserveField("state", "OnVideoPlayerStateChange")
   m.videoPlayer.ObserveField("visible", "OnVideoVisibleChange")
  
end sub

sub OnVideoPlayerStateChange() ' invoked when video state is changed
   state = m.videoPlayer.state
   ' close video screen in case of error or end of playback
   ?"Video Player state-------"m.videoPlayer.state
   if state = "error" or state = "finished"
       CloseScreen(m.videoPlayer)
       ?"Video Player Closed"
   end if
end sub

sub OnVideoVisibleChange() ' invoked when video node visibility is changed
    if m.videoPlayer.visible = false and m.top.visible = true
        ' the index of the video in the video playlist that is currently playing.
        currentIndex = m.videoPlayer.contentIndex
        m.videoPlayer.control = "stop" ' stop playback
        'clear video player content, for proper start of next video player
        m.videoPlayer.content = invalid
        screen=GetCurrentScreen()' return focus to grid screen
        ' navigate to the last played item
    end if
 end sub
'----------------------------------------Menu Logic------------------------------------------------------------

sub setMenuList()
    m.menu = CreateObject("roSGNode","menu")
    m.menu.ObserveField("downMenuClick","passDown")
    m.menu.ObserveField("selectedTab","onSelectedTab")
    m.focusedMenu="home"
    m.Top.appendChild(m.menu)
    
end sub

sub passDown()
    m.BaseScreen.downClick="true"
end Sub

sub onSelectedTab(node as Object)
    ?"On select tab "
    m.menuselected=node.getData()
    ?"menuselected------------"m.menuselected
    
    if m.menuselected="home"
        m.focusedMenu="home"
      ?"Home tab selected"
      CloseScreen(invalid)
      showscreen(m.basescreen)
    else if m.menuselected="movie"
        m.focusedMenu="movie"
        ?"zrfzttz-----"
      if m.MovieScreen=invalid
        CloseScreen(invalid)
        ShowMovieScreen()
      else
        ?"Show Movie tab"
        CloseScreen(invalid)
        showscreen(m.MovieScreen)
        
      end if
    else if m.menuselected="shorts"
        m.focusedMenu="shorts"
      if m.reelPage=invalid
        ?"Show shorts tab"
        ' showReelgrid()
        CloseScreen(invalid)
        showscreen(m.basescreen)
      else
        CloseScreen(invalid)
        showscreen(m.basescreen)
      end if
    end if
end sub
