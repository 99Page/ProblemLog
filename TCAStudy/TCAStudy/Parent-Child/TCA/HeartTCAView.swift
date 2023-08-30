//
//  HeartTCAView.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/30.
//

import SwiftUI
import ComposableArchitecture

struct HeartReducer: Reducer {
    struct State: Equatable {
        var yellowHeart = LikeReducer.State(heartColor: .yellow)
        var redHeart = LikeReducer.State(heartColor: .red)
    }
    
    enum Action: Equatable {
        case yellowButtonTapped(LikeReducer.Action)
        case redButtonTapped(LikeReducer.Action)
    }
    
    var body: some Reducer<State, Action> {
        //  Scope는 Reducer보다 먼저 위치해야한다.
        
        Scope(state: \.redHeart, action: /Action.redButtonTapped) {
            LikeReducer()
        }
        
        Scope(state: \.yellowHeart, action: /Action.yellowButtonTapped) {
            LikeReducer()
        }
        
        Reduce { state, action in
            switch action {
                
            // TCA에서 Delegate는 이런식으로 작성
            // 자식 리듀서의 Action와 그 때 실행할 기능을 연결
            case .yellowButtonTapped(.heartButtonTapped(let color)):
                debugPrint("wonderful \(color) button tapped")
                return .none
            case .redButtonTapped(.heartButtonTapped(let color)):
                debugPrint("cool \(color) button tapped")
                return .none
            default:
                return .none 
            }
        }
    }
}

struct HeartTCAView: View {
    
    let store: StoreOf<HeartReducer>
    var body: some View {
    
        VStack {
            LikeTCAButton(store: store.scope(state: \.redHeart,
                                             action: HeartReducer.Action.redButtonTapped))
            
            LikeTCAButton(store: store.scope(state: \.yellowHeart,
                                             action: HeartReducer.Action.yellowButtonTapped))
        }
    }
}

//struct HeartTCAView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeartTCAView()
//    }
//}
