//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 노우영 on 12/4/23.
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
    name: "RefreshableScrollView",
    platform: .iOS,
    product: .app,
    bundleId: "page.problem.log.refreshable.scroll.view",
    infoPlist: .extendingDefault(with: infoPlist),
    sources: ["Sources/**"]
)

let project = Project(name: "RefreshableScrollView",
                      organizationName: "page",
                      settings: nil,
                      targets: [target]
)

