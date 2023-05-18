//
//  SettingViewModel.swift
//  Increment
//
//  Created by Kul Boonanake on 18/5/23.
//

import Combine
import SwiftUI

final class SettingViewModel: ObservableObject {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Published private(set) var itemViewModels: [SettingItemViewModel] = []
    @Published var loginSignupPushed = false
    let title = "Setting"
    private let userService: UserServiceProtocol
    private var cencellables: [AnyCancellable] = []
    
    init(userService: UserServiceProtocol = UserService()){
        self.userService = userService
    }
    
    func item(at index: Int) -> SettingItemViewModel {
        itemViewModels[index]
    }
    
    func tappedItem(at index: Int) {
        switch itemViewModels[index].type {
        case .account:
            guard userService.currentUser?.email == nil else { return }
            loginSignupPushed = true
        case .mode:
            isDarkMode = !isDarkMode
            buildItems()
        case .logout:
            userService.logout().sink { completion in
                switch completion {
                case let .failure(error):
                    print(error.localizedDescription)
                case .finished: break
                }
            } receiveValue: { _ in }
                .store(in: &cencellables)

        default:
            break
        }
    }
    
    private func buildItems() {
        itemViewModels = [
            .init(title: userService.currentUser?.email ?? "Create Account", iconName: "person.circle", type: .account),
            .init(title: "\(isDarkMode ? "Dark" : "Light") Mode", iconName: "\(isDarkMode ? "moon.circle": "lightbulb.circle")", type: .mode),
            .init(title: "Privacy Policy", iconName: "shield", type: .privacy),
        ]
        
        if userService.currentUser?.email != nil {
            itemViewModels += [.init(title: "Logout", iconName: "arrowshape.turn.up.left", type: .logout)]
        }
    }
    
    func onAppear() {
        buildItems()
    }
}
