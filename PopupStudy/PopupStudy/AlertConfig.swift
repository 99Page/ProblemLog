//
//  AlertConfig.swift
//  PopupStudy
//
//  Created by 노우영 on 2023/10/09.
//

import SwiftUI

struct AlertConfig {
    var enableBackbroundBlur: Bool = true
    var disableOutsideTap: Bool = true
    var transitionType: TransitionType = .slide
    var slideEdge: Edge = .bottom
    fileprivate var show: Bool = false
    fileprivate var showView: Bool = false
    
    enum TransitionType {
        case slide
        case opacity
    }
    
    mutating func present() {
        show = true
    }
    
    mutating func dismiss() {
        show = false
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let config = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        config.delegateClass = SceneDelegate.self
        return config
    }
    
}

class SceneDelegate: NSObject, UIWindowSceneDelegate, ObservableObject {
    weak var windowScene: UIWindowScene?
    var overlayWindow: UIWindow?
    var tag: Int = 0
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        windowScene = scene as? UIWindowScene
        setUpOverlayWindow()
    }
    
    func setUpOverlayWindow() {
        guard let windowScene = windowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        window.isHidden = true
        window.isUserInteractionEnabled = false
        self.overlayWindow = window
        
        print("setUpOverlayWindow called")
    }
    
    fileprivate func alert<Content: View>(config: Binding<AlertConfig>, @ViewBuilder content: @escaping () -> Content,
                                          viewTag: @escaping (Int) -> ()) {
        guard let alertWindow = overlayWindow else { return }
        let viewContoller = UIHostingController(rootView:
                                                    AlertView(config: config, tag: tag, content: {
            content()
        }))
        
        viewContoller.view.tag = tag
        viewContoller.view.backgroundColor = .clear
        viewTag(tag)
        tag += 1
        
        if alertWindow.rootViewController == nil {
            alertWindow.rootViewController = viewContoller
            alertWindow.isHidden = false
            alertWindow.isUserInteractionEnabled = true
        } else {
            print("Exisiting alert is still present")
        }
    }
}


extension View {
    @ViewBuilder
    func alert<Content: View>(alertConfig: Binding<AlertConfig>, @ViewBuilder content: @escaping () -> Content) -> some View {
        self
            .modifier(AlertModifier(config: alertConfig,
                                    alertContent: content))
    }
}

fileprivate struct AlertModifier<AlertContent: View>: ViewModifier {
    @Binding var config: AlertConfig
    @ViewBuilder var alertContent: () -> AlertContent
    @EnvironmentObject var sceneDelegate: SceneDelegate
    @State private var viewTag: Int = 0
    
    func body(content: Content) -> some View {
        content
            .onChange(of: config.show) { newValue in
                if newValue {
                    sceneDelegate.alert(config: $config, content: alertContent) { tag in
                        viewTag = tag
                    }
                } else {
                    guard let alertWindow = sceneDelegate.overlayWindow else { return }
                    if config.showView {
                        withAnimation(.spring()) {
                            config.showView = false
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                            alertWindow.rootViewController = nil
                            alertWindow.isHidden = true
                            alertWindow.isUserInteractionEnabled = true
                        }
                    }
                }
            }
    }
}
fileprivate struct AlertView<Content: View>: View {
    @Binding var config: AlertConfig
    var tag: Int
    @ViewBuilder var content: () -> Content
    @State private var showView: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                if config.enableBackbroundBlur {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                } else {
                    Rectangle()
                        .fill(.primary.opacity(0.25))
                }
            }
            .ignoresSafeArea()
            .contentShape(Rectangle())
            .opacity(showView ? 1 : 0)
            .onTapGesture {
                if !config.disableOutsideTap {
                    config.dismiss()
                }
            }
            
            if showView && config.transitionType == .slide {
                content()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.move(edge: config.slideEdge))
            } else {
                content()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .opacity(showView ? 1 : 0)
            }
        }
        .onAppear {
            config.showView = true
            withAnimation(.spring()) {
                showView = true
            }
            
        }
        .onChange(of: config.show) { newValue in
            withAnimation(.spring()) {
                showView = newValue
            }
        }
    }
}
