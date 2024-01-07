//
//  ScrollViewAvoidance.swift
//  KeyboardAvoidance
//
//  Created by 노우영 on 1/6/24.
//  Copyright © 2024 page. All rights reserved.
//

import SwiftUI


/**
 스크롤 뷰에서 TextField를 vertical로 사용했을 때, 줄이 바뀌었는데 스크롤이 마지막으로 내려가지 않는 문제를 해결합니다.
 
 # 방법
 
 스크롤 뷰의 마지막에 줄바꿈 시 이동하기 위한 뷰를 한개 숨겨놓습니다. 조건에 따라서 이 뷰로 이동을 시킵니다.
 
 ScrollViewReader의 proxy를 이용한 이동은, 뷰에만 적용되는 것으로 TextField의 '라인'을 기준으로 이동 시킬 수 없습니다.
 
 # 이동 조건
 
 문자열의 마지막이 수정되었다는 것을 판단해야합니다
 
 1. 라인이 추가되었을 때 이동하면 안됩니다. 메모의 중간에도 라인이 추가될 수 있습니다.
 2. 마지막 캐릭터가 달라졌을 때 이동하는 것은 불충분합니다. 동일한 캐릭터가 반복적으로 추가되면 이동하지 않습니다.
 
 ## Brute force
 O(n)만에 해결할 수 있는 방법은 역순으로 문자열을 계속 조회하는 것입니다.
 
 precondition: aaaa
 1. aaaba로 바뀐 경우:  확인하기까지 1회 필요
 2. baaaa로 바뀐 경우: 확인하기까지 4번 필요
 
 ## Brute force, DP, 구현, Greedy, Backtracking, Divide & Conquer
 */
struct SingleTextCaseView: View {
    
    @State private var text: String = ""
    @FocusState private var focus: Bool
    
    @State private var lastContinuousEqualCharacterCount: Int = 0
    
    var body: some View {
        ScrollView {
            TextField("place holder", text: $text, axis: .vertical)
                .focused($focus)
            
            Rectangle()
                .fill(Color.clear)
                .frame(height: 1)
                .id("bottom view")
        }
        .detectlastCharacterModification(text: $text, lastViewid: "bottom view")
        .frame(height: 300, alignment: .top)
        .background(Color.gray.opacity(0.1))
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button {
                    focus = false
                } label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                }
            }
        }
    }
}

#Preview {
    SingleTextCaseView()
}
