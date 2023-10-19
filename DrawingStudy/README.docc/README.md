# ``DrawingStudy``

원하는 선, 도형들을 그리는 방법을 알아봅니다. 

## Overview

커스텀하기에 앞서서 애플에서 제공하는 튜토리얼을 먼저 따라합니다.
1. [Drawing paths and shaped](https://developer.apple.com/tutorials/swiftui/drawing-paths-and-shapes)
2. [Animating views and transitions](https://developer.apple.com/tutorials/swiftui/animating-views-and-transitions)

이후 원하는 방식으로 커스텀합니다. 구현 목표는 다음과 같습니다. 
1. View 사이에 연결되는 선들을 표시하기

## Issue 

View를 선으로 연결하기 위해서 View들의 위치인 CGPoint를 알아야합니다. 특정 뷰는 이 값이 정상적으로 얻어지지 않습니다.
이 문제를 해결하기 위해서 ``ViewPoint``에서 확인을 했습니다.

확인 결과 뷰의 위치를 제대로 얻지 못하는 것은 View 종류에서 오는 문제가 아니라 GeometryReader 자체의 버그로 판단합니다.
geometry의 영역을 global이 아닌 named로 설정했더니 위치를 정상적으로 얻을 수 있었습니다. 

다음은 global인 경우와 named인 경우에 얻는 CGPoint 값을 비교한 값입니다.


* named: [(330.875, 529.0919596354167), (300.75, 466.36637369791674), (300.75, 366.1163736979167), (300.75, 265.8663736979167), (200.5, 379.5)]

* global: [(330.875, 588.0919596354167), (300.75, 525.3663736979167), (300.75, 425.1163736979167), (300.75, 324.8663736979167), (200.5, 438.5)]

global인 경우 기본적으로 y값이 더 큰 것을 확인할 수 있습니다. global인 경우에는 SafeArea까지 포함해서 영역이 더 크게 잡힙니다.
Path가 그려지는 것이 중요한데 Path에서 사용되는 CGPoint는 Global 기준이 아닌 해당 named가 기준이 되어 named를 사용하는 것이 정확합니다. 


## Topics

### 튜토리얼 

- ``HexagonParameters``
- ``BadgeBackground``

### 커스텀 
- ``PathCurvePractiveView``
- ``CustomDrawingView``
