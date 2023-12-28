//
//  SemaphoreViewModel.swift
//  GlobalLoading
//
//  Created by wooyoung on 12/26/23.
//  Copyright © 2023 page. All rights reserved.
//

import Foundation

final class SemaphoreViewModel: ObservableObject {
    @Published var count: Int = 0
    let semaphore = DispatchSemaphore(value: 0)
    
    func increase() {
        Task {
            self.count += 1
        }
        
        DispatchQueue.global(qos: .background).async {
            self.count += 1
        }
        
        Task { @MainActor in
            self.count += 1
        }
        
        DispatchQueue.main.async {
            self.count += 1
        }
        
        Task {
            await MainActor.run {
                self.count += 1
            }
        }
//        DispatchQueue.global(qos: .background).async {
//            Task {
//                await self.sleep()
//                self.semaphore.wait()
//                self.count += 1
//                self.semaphore.signal()
//            }
//        }
    }
    
    func sleep() async {
        do {
            try await Task.sleep(for: .seconds(2))
        } catch {
            await sleep()
        }
    }
}
