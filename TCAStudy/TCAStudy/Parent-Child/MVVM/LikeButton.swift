//
//  LikeButton.swift
//  TCAStudy
//
//  Created by wooyoung on 2023/08/30.
//

import SwiftUI

struct LikeButton: View {
    
    @ObservedObject var likeViewmodel: LikeViewmodel
    
    var body: some View {
        Button {
            likeViewmodel.likeButtonTapped() 
        } label: {
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(likeViewmodel.heartColor)
        }
    }
}
//
//struct LikeButton_Previews: PreviewProvider {
//    static var previews: some View {
//        LikeButton()
//    }
//}
