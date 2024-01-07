//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 노우영 on 1/6/24.
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
    name: "KeyboardAvoidance",
    platform: .iOS,
    product: .app,
    bundleId: "page.problem.log.keyboard.avoidance",
    infoPlist: .extendingDefault(with: infoPlist),
    sources: ["Sources/**"]
)

let project = Project(name: "KeyboardAvoidance",
                      organizationName: "page",
                      settings: nil,
                      targets: [target]
)

