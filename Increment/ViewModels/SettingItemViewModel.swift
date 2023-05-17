//
//  SettingItemViewModel.swift
//  Increment
//
//  Created by Kul Boonanake on 18/5/23.
//

import Foundation

struct SettingItemViewModel {
    let title: String
    let iconName: String
    let type: SettingItemType
}

enum SettingItemType {
    case account
    case mode
    case privacy
}
