//
//  LikeTCAButton.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/30.
//

import SwiftUI
import ComposableArchitecture

struct LikeTCAButton: View {
    
    let store: StoreOf<LikeReducer>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                Button {
                    viewStore.send(.heartButtonTapped(viewStore.heartColor))
                } label: {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(viewStore.heartColor)
                }
            }
        }
    }
}

//struct LikeTCAButton_Previews: PreviewProvider {
//    static var previews: some View {
//        LikeTCAButton()
//    }
//}
