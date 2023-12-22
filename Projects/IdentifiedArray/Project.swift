//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by wooyoung on 12/22/23.
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
    name: "IdentifiedArrayStudy",
    platform: .iOS,
    product: .app,
    bundleId: "page.problem.log.identified.array.study",
    infoPlist: .extendingDefault(with: infoPlist),
    sources: ["Sources/**"],
    dependencies: [
        .package(product: "IdentifiedCollections")
    ]
)

let testTarget = Target(
    name: "IdentifiedArrayTest",
    platform: .iOS,
    product: .unitTests,
    bundleId: "page.problem.log.identified.array.test",
    infoPlist: .extendingDefault(with: infoPlist),
    sources: ["Tests/**"],
    dependencies: [
        .target(name: "IdentifiedArrayStudy")
    ]
)

let project = Project(name: "IdentifiedArrayStudy",
                      organizationName: "page",
                      packages: [
                        .remote(url: "https://github.com/pointfreeco/swift-identified-collections.git",
                                requirement: .upToNextMajor(from: "1.0.0")),
                      ],
                      settings: nil,
                      targets: [target, testTarget]
)

