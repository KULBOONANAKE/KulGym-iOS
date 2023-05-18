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
    
    func item(at index: Int) -> SettingItemViewModel {
        itemViewModels[index]
    }
    
    func tappedItem(at index: Int) {
        switch itemViewModels[index].type {
        case .account:
            loginSignupPushed = true
        case .mode:
            isDarkMode = !isDarkMode
            buildItems()
        default:
            break
        }
    }
    
    private func buildItems() {
        itemViewModels = [
            .init(title: "Create Account", iconName: "person.circle", type: .account),
            .init(title: "\(isDarkMode ? "Dark" : "Light") Mode", iconName: "\(isDarkMode ? "moon.circle": "lightbulb.circle")", type: .mode),
            .init(title: "Privacy Policy", iconName: "shield", type: .privacy),
        ]
    }
    
    func onAppear() {
        buildItems()
    }
}
