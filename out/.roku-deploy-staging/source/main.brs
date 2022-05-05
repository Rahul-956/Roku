sub main()
    showChannelSGSrceen()
end sub

sub showChannelSGSrceen()
    screen= CreateObject("roSGScreen")
    m.port= CreateObject("roMessagePort")
    screen.setMessageport(m.port)
    scene= screen.CreateScene("MainScene")
    screen.show()
    scene.Observefield("exitApp",m.port)
    
    while(true)
        msg=wait(0,m.port)
        msgType=type(msg)
        if msgType= "roSGScreenEvent"
            if msg.isScreenClosed() then return

        else if msgType= "roSGNodeEvent" and msg.getField()="exitApp"
            ?"msg.getField()----"msg.getField()
            ?"scene.exitApp-----"scene.exitApp
            if scene.exitApp=true
                exit while
            end if
        end if
    end while
end sub

