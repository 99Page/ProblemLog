# ``ViewmodelDelegateStudy``

Viewmodel과 Delegate 방식의 차이를 비교합니다. 

## Overview

뷰를 재사용하기 위해서 ViewModel을 프로토콜로 정의할 수 있습니다. 
ViewModel은 Delegate의 역할을 하지만 모델을 갖는 점에서 다릅니다. 
하위 뷰에 기능을 전달하기 위해 언제 ViewModel을 사용하고 언제 Delegate를 사용할지 알아봅니다. 

하위 뷰가 상위 뷰와 공유하지 않는 모델을 갖는다면 Delegate를, 하위 뷰의 모든 모델이 상위 뷰와 공유된다면 ViewModel을 사용합니다.   
## ViewModel 

``ViewModel-Case`` 폴더에 관련 내용이 정리되었습니다. 핵심 코드만 살펴보겠습니다. 

```swift
protocol CountChildViewModel: ObservableObject {
    var childModel: CountChildModel{ get set }
    func onButtonTapped()
}
```

재사용하기 위한 View의 ViewModel은 프로토콜로 선언합니다. 

```swift
final class CountParentViewModel: CountChildViewModel
```
해당 뷰를 재사용하기 위한 곳에서 아까 선언한 프로토콜을 채택합니다. 이곳에서 하위 뷰의 기능을 정의하여 하나의 액션을 통해 상위 뷰의 모델, 하위 뷰의 모델에 모두 변경을 적용할 수 있습니다. 

즉, 상위-하위 뷰에 공통된 값이 필요할 때 사용하기 적절합니다. 

## Delegate 

``Delegate-Case`` 폴더에 관련 내용이 정리되었습니다. 

Delegate는 하위 뷰의 값을 상위 뷰와 공유하고 싶지 않을 때 사용합니다. 
혹은 sheet, fullScreenCover 등을 이용해 화면을 불러올 때 계속 값이 초기화되어야 할 때(StateObject) 사용합니다. 

핵심 코드를 살펴보겠습니다.

```swift
final class UpdateCountViewModel: ObservableObject {
    @Published var model = UpdateCountModel()
    
    private let delegate: UpdateCountDelegate
    
    init(delegate: UpdateCountDelegate) {
        self.delegate = delegate
    }
    
    func onUpdateButtonTapped() {
        model.count += 1 
        delegate.didTapUpdateButton()
    }
}
```

``UpdateCountView``는 내부에서 버튼이 탭된 횟수를 알려줍니다. 이 값은 상위 뷰가 알 필요는 없지만 업데이트의 내용은 상위 뷰의 무엇입니다. 따라서 Delegate 패턴이 활용됩니다. 

```swift
extension ColorCircleViewModel: UpdateCountDelegate {
    internal func didTapUpdateButton() {
        let colors: [Color] = [.blue, .green, .yellow, .orange, .purple, .pink]
        model.color = colors.randomElement() ?? .brown
    }
}
```

이런식으로 상위 뷰에서 어떤 것을 업데이트할지 정의해야합니다. 
함수를 보시면 on~ 형식이 아니라 did~ 형식으로 선언되었습니다. ViewModel에 정의된 함수는 View에 모두 공개되어 Delegate에 정의된 함수를 숨길 수 없습니다. 네이밍 컨벤션을 통해 사용되어선 안되는 함수임을 알려야 합니다. 

```swift
Button {
    viewModel.onPresentUpdateCountButtonTapped()
} label: {
    Text("Show update count view")
}
.sheet(isPresented: $viewModel.model.isUpdateCountViewPresented) {
    UpdateCountView(updateCountDelegate: viewModel)
}
```

``UpdateCountView``를 호출할 때마다 count 값이 초기화됩니다. 하지만 프로토콜 ViewModel을 사용하면 count 값이 유지됩니다.

따라서, 값의 초기화 여부와 데이터 공유의 필요성에 따라 ViewModel과 Delegate를 선택할 수 있습니다.

## Topics 

### ViewModel 

- ``CountChildModel``
- ``CountChildView``
- ``CountChildViewModel``
- ``CountParentView``
- ``CountParentViewModel``

### Delegate 

- ``ColorCircleView``
- ``ColorCircleModel``
- ``ColorCircleViewModel``

- ``UpdateCountView``
- ``UpdateCountModel``
- ``UpdateCountViewModel``
- ``UpdateCountDelegate``

