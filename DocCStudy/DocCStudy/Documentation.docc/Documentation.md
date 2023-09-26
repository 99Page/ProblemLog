# ``DocCStudy``

WWDC를 보면서 DocC 사용법을 파악하는 중. 

## Overview

현재 보고 있는 영상은 [이곳](https://developer.apple.com/videos/play/wwdc2021/10167)인데 Xcode15를 사용하고 있다. 문서를 프리뷰할 수 있어서 좋다. REAMD는 프리뷰 안되는데 애플에서 제공하는 Article 파일은 프리뷰가 된다. 

DocC의 문서 종류는 세가지다 
* Reference 
* Article 
* Tutorial 


## 이미지 

연습을 위해서 귀여운 상추 사용해보자.

![상추](상추.png)

Documentation의 Resource를 보면 두가지 버전의 이미지가 있다. 
* 상추.png 
* 상추~dark.png 

뒤에 ~dark는 다크모드 사용할 때 자동으로 적용해준다. 
사용할 때는 신경쓰지 않고 (상추.png)만 입력해주자. 

## 그룹 

아래를 참고해서 그룹을 만들 수 있다.
일반 파일은 더블 백틱(\``)으로 감싸면 되고 DocC파일은 <doc:>로 접근하면 된다. 

그룹을 만들기 위해서는 반드시 `## Topics` 하위에 만들어야한다.  

## Topics

### 그룹 

- ``SimpleStruct``
- ``DocCStudyApp``
- <doc:HelloArticle>

### 다른 그룹 

- ``SimpleStruct``
