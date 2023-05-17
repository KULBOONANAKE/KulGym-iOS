//
//  IncrementApp.swift
//  Increment
//
//  Created by Kul Boonanake on 17/5/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct IncrementApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                TabContainerView()
            }
            else {
                ContentView()
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

class AppState: ObservableObject {
    @Published private(set) var isLoggedIn = false
    
    private let userService: UserServiceProtocol
    init(userService: UserServiceProtocol = UserService()){
        self.userService = userService
        userService
            .observeAuthChanges()
            .map {$0 != nil}
            .assign(to: &$isLoggedIn)
    }
}
