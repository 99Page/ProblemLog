# MoreSangChu

상추 이미지를 더 작성해보자. 

@MetaData {
    @CallToAction(
                  purpose: link, 
                  url: "https://developer.apple.com/videos/play/wwdc2023/10244")
    @PageColor(blue)
}

## Overview

### Image Row Column 
상추 이미지와 Rouw Column을 활용해보자 

@Row {
    @Column(size: 2) {
        운전석을 차지하고 있는 상추의 사진이다. 
        size를 입력해서 Column의 비율을 설정할 수 있다. 
    }
    
    @Column {
        ![상추](상추2.png)
    }
}
    
@Row {
    @Column {
        ![상추](상추3.png)
    }
    @Column {
        침대에 누워있는 상추 사진이다.  
    }
}


### Image tabs 

상추 이미지와 DocC의 탭을 활용해보자. 

@TabNavigator {
    @Tab("운전석") {
        ![상추](상추2.png)
    }
    
    @Tab("침대") {
        ![상추](상추3.png)
    }
}
