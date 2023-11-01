//
//  TstApp.swift
//  Tst
//
//  Created by wooyoung on 2023/10/31.
//

import SwiftUI

@main
struct TstApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: TstDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
