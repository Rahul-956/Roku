sub init()
    m.top.functionName = "getcontent"
end sub

sub getcontent()
    content = createObject("roSGNode", "ContentNode")
    xerf = createObject("roUrlTransfer")
    xerf.SetCertificatesFile("common:/certs/ca-bundle.crt")
    xerf.setUrl("https://6274a50b345e1821b22dd487.mockapi.io/Allmovies")
    contentData=parseJSON(xerf.GetToString())

    if contentData<>invalid
      for each item in contentData
        itemcontent = content.createChild("ContentNode")
          itemcontent.description = item.shortDescription
          itemcontent.hdPosterURL=item.thumbnail
          itemcontent.title=item.title
          itemcontent.id = item.id
          itemcontent.url = item.url
          itemcontent.streamFormat = item.videoType
       
        
      end for


    end if

    m.top.content = content
    
  end sub