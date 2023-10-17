# ``TransactionStudy``

Transaction에 대해서 알아봅니다.

## Overview

Dropdown을 개발하는 도중 Transaction이 오동작 하는 것을 확인했습니다. 원하는 동작은 fullScreenCover가 애니메이션 효과 없이 올라오는 것이었는데 해당 동작을 한 이후에 Navigate를 할 때도 애니메이션 없이 이동했습니다. 따라서 Transaction에 대해서 파악해봅니다. 

개발 목표는 간단히 합니다. 
1. fullScreenCover를 애니메이션 없이 불러옵니다. 
2. 이후 Navigate는 애니메이션 있는 상태로 이동합니다. 

iOS 17 버전에서는 원하는 동작을 정상적으로 하고 16 버전에서 문제가 컸습니다. 두 가지 버전을 모두 확인해봅니다. 

## Topics

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
