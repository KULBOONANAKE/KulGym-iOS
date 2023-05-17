//
//  LoginSignupViewModel.swift
//  Increment
//
//  Created by Kul Boonanake on 18/5/23.
//

import Foundation

final class LoginSignupViewModel: ObservableObject {
    private let mode: Mode
    init(mode: Mode){
        self.mode = mode
    }
}

extension LoginSignupViewModel {
    enum Mode {
        case login
        case signup
    }
}
