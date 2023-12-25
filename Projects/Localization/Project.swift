//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 노우영 on 12/25/23.
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
    name: "Localization",
    platform: .iOS,
    product: .app,
    bundleId: "page.problem.log.localization",
    infoPlist: .extendingDefault(with: infoPlist),
    sources: ["Sources/**"]
)

let project = Project(name: "Localization",
                      organizationName: "page",
                      settings: nil,
                      targets: [target]
)
