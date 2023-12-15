//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 노우영 on 12/13/23.
//

import ProjectDescription
import ProjectDescriptionHelpers

let infoPlist: [String: InfoPlist.Value] = [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
    "UIMainStoryboardFile": "",
    "UILaunchStoryboardName": "LaunchScreen"
]

let target = Target(
    name: "GlobalLoading",
    platform: .iOS,
    product: .app,
    bundleId: "page.problem.log.global.loading",
    infoPlist: .extendingDefault(with: infoPlist),
    sources: ["Sources/**"]
)

let testTarget = Target(
    name: "GlobalLoadingTest",
    platform: .iOS,
    product: .unitTests,
    bundleId: "page.problem.log.global.loading.test",
    infoPlist: .extendingDefault(with: infoPlist),
    sources: ["Tests/**"],
    dependencies: [
        .target(name: "GlobalLoading")
    ]
)

let project = Project(name: "GlobalLoading",
                      organizationName: "page",
                      settings: nil,
                      targets: [target, testTarget]
)

