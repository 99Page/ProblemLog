//
//  MultiTextEditor.swift
//  ProjectDescriptionHelpers
//
//  Created by 노우영 on 12/28/23.
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
    name: "MultiTextEditor",
    platform: .iOS,
    product: .app,
    bundleId: "page.problem.log.multi.text.editor",
    infoPlist: .extendingDefault(with: infoPlist),
    sources: ["Sources/**"]
)

let project = Project(name: "MultiTextEditor",
                      organizationName: "page",
                      settings: nil,
                      targets: [target]
)
