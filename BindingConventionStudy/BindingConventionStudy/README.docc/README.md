# ``BindingConventionStudy``

SwiftUI에서 바인딩을 하는 방법을 정리합니다. 

## Overview

SwiftUI에서 바인딩을 통해 상위 뷰와 하위 뷰가 데이터를 공유할 수 있습니다. 하위 뷰에서 바인딩으로 전달된 값이 변경되면 변경 사항이 상위 뷰에도 반영됩니다.

```swift
TextField("Title", text: $viewModel.model.text)
```

위 코드처럼 사용하는 것이 가장 간단한 방법입니다. 그러나 이렇게 뷰에 직접 바인딩을 하면 문제가 발생할 수 있습니다. 아래에 있는 모델을 살펴보겠습니다.

```swift
struct SimpleTypeModel {
    var value: Int = 0
    var text: String = "" 
}
```

모델에는 TextField에 바인딩되어야 하는 text 외에도 다른 프로퍼티가 존재합니다. 또한, 뷰모델에 정의된 모델이 뷰에 바인딩되려면 setter의 접근 제어자(access control)가 internal 이상이어야 합니다. 따라서 SimpleModelType에 있는 다른 프로퍼티도 뷰에서 직접 변경 가능한 값이 됩니다.

모델에 있는 값을 모델, 뷰모델, 뷰 모든 곳에서 변경 가능하다면 디버깅이 어려워집니다.

## Binding in ViewModel

```swift 
class SimpleTypingViewModel {

    // 1 
    @Published private(set) var description: String = ""

    // 2 
    var descriptionBinding: Binding<String> {
        .init {
            self.description
        } set: {
            self.description = $0
        }
    }
}

TextField("Description", text: viewModel.descriptionBinding)
```

뷰에서는 모델 값을 변경할 수 없도록 하려면 다음 두 가지 처리를 해야합니다.

모델의 setter를 private으로 변경합니다.
뷰에서 모델을 변경하기 위한 방법을 함수를 제공합니다.
2번을 수행하기 위해, 뷰모델에서 뷰가 사용할 수 있는 Binding을 제공할 수 있습니다

### 문제점 

다만 이렇게 뷰모델에서 값을 제공했을 때 문제점이 있습니다. `descirptionBinding`의 출력을 통해 확인해보겠습니다. 

![디버깅 이미지](ViewModelBinding.png)

두가지 문제점이 보입니다. 
1. 값이 변경되지 않았고 TextField가 포커스됐을 뿐인데 값이 변경됩니다. 
2. 한번 값이 변경되면 두번 변경됩니다.

두번쨰 문제를 해결하기 위해서는 이전값과 새로운 값을 비교하면 됩니다. 하지만 첫번째 문제는 여전히 남아있습니다. 

## Comparison between Binding setter and onChageOf 

뷰모델에서 바인딩을 제공하는 방식과 기존의 방식을 더 비교해보겠습니다. 코드는 ``SimpleTypingViewModel``와 ``SimpleTypingView``를 참고하면 됩니다.

바인딩된 텍스트 값이 변경될 때마다 뷰모델의 어떤 함수를 호출하려고 합니다. 기존에 할 수 있는 방식은 명확합니다. onChange(of:perform:)를 사용하면 됩니다.

바인딩을 제공하는 방식은 선택지가 생깁니다. 기존과 같이 onChange(of:perform:)를 사용할 수도 있고, 바인딩의 setter에서 수행하는 방법도 있습니다.

실제 코드를 작성하다 보면 선택지가 많아서 코드가 어디서 실행되는지 파악하기 어려워집니다. 이 경우에는 기존의 방식이 더 편리합니다.

## Consistency Limits

뷰모델에서 바인딩을 만드는 것은 뷰에서 모델 값을 직접 변경하지 못하게 하는 것이 목적입니다. 그러나 개발을 하다 보면 종종 뷰에서 값을 변경해야하는 경우가 생깁니다. 이러한 변경은 의도적으로 수행되거나 문법적인 한계로 인해 발생할 수 있습니다. 이러한 상황을 모두 살펴보겠습니다.

### Protocol use  

```swift
protocol ChildViewModel: ObservableObject {
    var value: Int { get set }
}

extension ChildViewModel {
    func onButtonTapped() {
        value = 0
    }
}
``` 

재사용을 위해 뷰모델을 만들고 함수의 기본 동작을 정의하려면 프로퍼티의 get과 set이 정의되어야 합니다. 프로토콜에서 get과 set으로 정의되었기 때문에 뷰에서도 set이 가능해집니다.

뷰모델의 기본 동작을 정의하는 경우는 매우 일반적이며, 이로 인해 뷰에서의 읽기 전용이 불가능해집니다.

### FocusState sync 

```swift
func syncBinding<T>(model: Binding<T>, focusState: FocusState<T>.Binding) -> some View {
    self
        .onChange(of: model.wrappedValue) { newValue in
            focusState.wrappedValue = newValue
        }
        .onChange(of: focusState.wrappedValue) { newValue in
            model.wrappedValue = newValue
        }
}
```
모든 값을 모델에 정의해주면 좋지만, FocusState를 사용하려면 이 값은 뷰에서 정의해야 합니다. 모델에서 관리하려면 같은 타입을 프로퍼티로 정의해주고 양쪽의 데이터를 동기화할 수 있습니다.

그리고 모델에 있는 값과 뷰에 있는 값을 동기화하는 코드를 재사용하려면 modifier를 만들어주는 것이 편리한 방법이고, 이러한 경우에는 로직이 뷰 단에서 실행되어야 합니다.

## Conclusion 

바인딩을 뷰모델에서 만드는 것은 뷰에서 모델 값을 변경하지 못하게 하는 것이 주된 목적이었습니다. 그러나 이러한 목적을 완벽하게 해결할 수 없을 뿐만 아니라 다른 문제도 존재합니다.

뷰에서의 값 변경은 코드 컨벤션으로 해결하는 것이 더 나은 방법이며, settable하게 공개하는 것이 바람직해 보입니다.

## Topics

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
