//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by wooyoung on 2023/11/29.
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
    name: "ModelDataStudy",
    platform: .iOS,
    product: .app,
    bundleId: "page.casestudy.model.data.study",
    infoPlist: .extendingDefault(with: infoPlist),
    sources: ["Sources/**"]
)

let project = Project(name: "ModelDataStudy",
                      organizationName: "page",
                      settings: nil,
                      targets: [target]
)

