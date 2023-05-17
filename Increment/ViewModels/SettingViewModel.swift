//
//  SettingViewModel.swift
//  Increment
//
//  Created by Kul Boonanake on 18/5/23.
//

import Combine

final class SettingViewModel: ObservableObject {
    @Published private(set) var itemViewModels: [SettingItemViewModel] = []
    
    func onAppear() {
        itemViewModels = [
            .init(title: "Create Account", iconName: "person.circle", type: .account),
            .init(title: "Light Mode", iconName: "lightbulb", type: .mode),
            .init(title: "Privacy Policy", iconName: "shield", type: .privacy),
        ]
    }
}
