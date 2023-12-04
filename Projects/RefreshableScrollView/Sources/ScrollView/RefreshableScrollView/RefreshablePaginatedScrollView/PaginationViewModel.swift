//
//  PaginationViewModel.swift
//  RefreshableScrollView
//
//  Created by 노우영 on 12/5/23.
//  Copyright © 2023 page. All rights reserved.
//

import Foundation

final class PaginationViewModel: ObservableObject {
    @Published var model = PaginationModel()
    
    private let fetch: () -> ()
    
    init(fetch: @escaping () -> Void) {
        self.fetch = fetch
    }
    
    func fetchIfPossible() {
        guard model.isFetchEnabeld else { return }
        model.state = .loading
        fetch()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.model.state = .wait
        }
    }
}
