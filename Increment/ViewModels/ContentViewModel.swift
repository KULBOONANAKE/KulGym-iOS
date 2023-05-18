//
//  ContentViewModel.swift
//  Increment
//
//  Created by Kul Boonanake on 18/5/23.
//

import Foundation

final class ContentViewModel: ObservableObject {
    @Published var loginSignupPushed = false
    @Published var createPushed = false
    
    let title = "KulGym"
    let createButtonTitle = "Create a challenge"
    let createButtonImageName = "plus.circle"
    let alreadyButtonTitle = "I already have an account"
    let backgroundImageName = "frog-stand"
}
