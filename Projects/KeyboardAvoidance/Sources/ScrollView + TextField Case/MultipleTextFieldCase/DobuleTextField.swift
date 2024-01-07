//
//  DobuleTextField.swift
//  KeyboardAvoidance
//
//  Created by 노우영 on 1/7/24.
//  Copyright © 2024 page. All rights reserved.
//

import SwiftUI

struct DoubleTextCaseView: View {
    
    @State private var topText: String = ""
    @State private var bottomText: String = """
                                            Baby (baby), got me looking so crazy (crazy)
                                            빠져버리는 daydream (daydream)
                                            Got me feeling you 너도 말해줄래?
                                            누가 내게 뭐래던 남들과는 달라 넌
                                            Maybe you could be the one (one)
                                            날 믿어봐 한번 I'm not looking for just fun
                                            Maybe I could be the one
                                            Oh, baby (baby)
                                            예민하대 나 lately (lately)
                                            너 없이는 매일 매일이 yeah (매일이 yeah)
                                            재미없어, 어쩌지?
                                            I just want you call my phone right now
                                            I just wanna hear, "You're mine"
                                            'Cause I know what you like boy (ah-ah)
                                            You're my chemical hype boy (ah-ah)
                                            내 지난날들은 눈 뜨면 잊는 꿈
                                            Hype boy 너만 원해
                                            Hype boy 내가 전해
                                            """
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                TextField("", text: $topText, axis: .vertical)
                
                Rectangle()
                    .foregroundStyle(.clear)
                    .frame(height: 1)
                    .id("top")
                
                TextField("", text: $bottomText, axis: .vertical)
                
                Rectangle()
                    .foregroundStyle(.clear)
                    .frame(height: 1)
                    .id("bottom")
            }
            .onChange(of: topText) { oldValue, newValue in
                let checker = LastCharacterModificationChecker.shared
                guard checker.checkLastCharacterModification(first: oldValue, second: newValue) else { return }
                proxy.scrollTo("top")
            }
            .onChange(of: bottomText) { oldValue, newValue in
                let checker = LastCharacterModificationChecker.shared
                guard checker.checkLastCharacterModification(first: oldValue, second: newValue) else { return }
                proxy.scrollTo("bottom")
            }
        }
    }
}

#Preview {
    DoubleTextCaseView()
}
