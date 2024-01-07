//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 노우영 on 1/7/24.
//

import ProjectDescription

let infoPlist: [String: InfoPlist.Value] = [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
    "UIMainStoryboardFile": "",
    "UILaunchStoryboardName": "LaunchScreen"
    ]

let pagePackage = Target(
    name: "PagePackage",
    platform: .iOS,
    product: .framework,
    bundleId: "com.page.package",
    infoPlist: .extendingDefault(with: infoPlist),
    sources: ["Sources/**"]
)

let viewProject = Project(name: "PagePackage",
                      organizationName: "page",
                      settings: nil,
                      targets: [pagePackage]
                      )

