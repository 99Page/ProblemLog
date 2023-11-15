import ProjectDescription
import ProjectDescriptionHelpers

let infoPlist: [String: InfoPlist.Value] = [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
    "UIMainStoryboardFile": "",
    "UILaunchStoryboardName": "LaunchScreen"
]

let target = Target(
    name: "KeyChainStudy",
    platform: .iOS,
    product: .app,
    bundleId: "page.casestudy.keychain.study",
    infoPlist: .extendingDefault(with: infoPlist),
    sources: ["Sources/**"]
)

let project = Project(name: "KeyChainStudy",
                      organizationName: "page",
                      settings: nil,
                      targets: [target]
)
