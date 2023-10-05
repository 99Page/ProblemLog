# ``FocusStateStudy``

FocusState 시 키보드 바운스 문제를 해결하기 위한 내용 정리 

## Overview
iOS 15버전에서는 정상적으로 동작하는데 16버전 이상에서는 바운스 문제가 해결되지 않는다. 두 가지 방법을 사용해보았다

1. UIKit 
2. 버튼 사용 

UIKit의 responder를 사용하는 방식도 키보드는 바운스 됐다. 버튼을 사용하면 바운스되지 않는다. 

## Anoter apps 

세가지 앱을 확인해보았다. 

1. 네이버
2. 넷플릭스
3. 인스타그램 

네이버와 넷플릭스는 웹뷰를 사용해서 적절하지 않은 참고자료였다. 인스타그램은 네이티브로 만들어지긴 했으나 텍스트를 입력할 곳을 다른 화면으로 분리시켰고 적절한 자료가 아니었다. 

## Reference 

* https://stackoverflow.com/questions/74097562/keyboard-bouncing-with-focusstate-and-onsubmit

## Topics

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
