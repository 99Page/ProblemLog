//
//  HeartView.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/30.
//

import SwiftUI

struct HeartView: View {
    
    @StateObject private var redHeartViewmodel = RedHeartViewmodel()
    @StateObject private var yellowHeartViewmodel = YellowHeartViewmodel()
    
    var body: some View {
        VStack {
            LikeButton(likeViewmodel: redHeartViewmodel.likeVimewodel)
            LikeButton(likeViewmodel: yellowHeartViewmodel.likeViewmodel)
        }
    }
}

struct HeartView_Previews: PreviewProvider {
    static var previews: some View {
        HeartView()
    }
}
