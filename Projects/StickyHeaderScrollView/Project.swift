//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 노우영 on 1/7/24.
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
    name: "StickyHeaderScrollView",
    platform: .iOS,
    product: .app,
    bundleId: "page.problem.log.sticky.header",
    infoPlist: .extendingDefault(with: infoPlist),
    sources: ["Sources/**"],
    dependencies: [
        .project(target: "PagePackage", path: "../PagePackage")
    ]
)

let project = Project(name: "StickyHeader",
                      organizationName: "page",
                      settings: nil,
                      targets: [target]
)

