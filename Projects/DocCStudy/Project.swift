import ProjectDescription
import ProjectDescriptionHelpers

let infoPlist: [String: InfoPlist.Value] = [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
    "UIMainStoryboardFile": "",
    "UILaunchStoryboardName": "LaunchScreen"
]

let target = Target(
    name: "DocCStudy",
    platform: .iOS,
    product: .app,
    bundleId: "page.casestudy.doccstudy",
    infoPlist: .extendingDefault(with: infoPlist),
    sources: ["Sources/**"]
)

let project = Project(name: "DocCStudy",
                      organizationName: "page",
                      settings: nil,
                      targets: [target]
)
