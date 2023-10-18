# ``TransactionStudy``

Transaction에 대해서 알아봅니다.

## Overview

Dropdown을 개발하는 도중 Transaction이 오동작 하는 것을 확인했습니다. 원하는 동작은 fullScreenCover가 애니메이션 효과 없이 올라오는 것이었는데 해당 동작을 한 이후에 Navigate를 할 때도 애니메이션 없이 이동했습니다. 버그가 발생한 원인을 파악해봅니다. 

개발 목표는 다음과 같습니다. 
1. fullScreenCover를 애니메이션 없이 불러옵니다. 
2. 이후 Navigate는 애니메이션 있는 상태로 이동합니다. 

iOS 17 버전에서는 원하는 동작을 정상적으로 하고 16 버전에서 버그가 발생했습니다. 두 가지 버전을 모두 확인해봅니다. 

## Problem 

예상치 못한 코드가 Transaction의 버그를 만들었습니다. Transaction 애니메이션을 없애면서 Fullscreen을 불러오는 뷰는 ``IssuedFullScreenButtonView``입니다. 핵심 코드는 아래와 같습니다.  

```swift 
var transaction = Transaction()
transaction.disablesAnimations = true
withTransaction(transaction) {
    viewModel.isFullScreenPresented = true
}
```
 
그리고 화면 이동(navigate)애니메이션은 NavigationStack에 path 바인딩이 존재할 때 사라집니다. NavigationStack은 ``ContentView`` 에서 관리하고 있습니다. 코드는 다음과 같습니다. 

```swift 
NavigationStack(path: $path.paths) {
    List {
        Button(action: {
            path.paths.append(10)
        }, label: {
            Text("Next view")
        })
    }
    .toolbar(content: {
        ToolbarItem(placement: .navigationBarLeading) {
            FullScreenButtonView(viewModel: viewModel)
        }
    })
    .navigationDestination(for: Int.self) { value in
        Text("\(value) view")
    }
}
```

위 코드를 보면 path 바인딩이 있습니다. path 바인딩을 없애고 NavigationLink를 사용하면 애니메이션이 정상적으로 동작합니다. 


## Solution 

``UnissuedFullScreenButtonView`` 와 `transaction(_:)`을 이용해서 문제를 해결합니다. ``UnissuedFullScreenButtonView``에서는 action 내부에서 `Transaction`을 사용하지 않습니다. 일반적인 기능 호출처럼 동작합니다. FullScreenCover의 애니메이션을 없애기위해 `transaction(_:)` modifier를 사용합니다. 

modifier의 선언 위치는 주의해야합니다. 버튼 하나만 사용하고 있으면 버튼 하위에 선언해도 되는데 HStack, VStack같은 다른 컨테이너에 감싸져 있으면 해당 컨테이너에 modifier를 사용해야합니다. ``ContentView``를 보면 HStack에 modifier가 사용되었습ㄴ디ㅏ. 
