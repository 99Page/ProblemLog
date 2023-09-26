//
//  ContentView.swift
//  DocCStudy
//
//  Created by wooyoung on 2023/09/26.
//

import SwiftUI

struct SimpleStruct {
    
    /**
     
     Parameter와 Return은 특수한 키워드로 취급합니다.
     
     - parameters:
        - value: 아무 숫자나 들어오면 됩니다
     - returns:
     항상 true만 반환 합니다. 백틱 두개를 사용하면 이런 식으로(``SimpleStrucy``) 필요한 문서로 이동할 수 있는 링크를 만들 수 있습니다.
     */
    func simpleMethod(_ vaue: Int) -> Bool {
        return true
    }
}
