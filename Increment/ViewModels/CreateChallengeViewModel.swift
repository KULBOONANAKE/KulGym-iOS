//
//  CreateChallengeView.swift
//  Increment
//
//  Created by Kul Boonanake on 17/5/23.
//

import Foundation
import Combine

typealias UserId = String

final class CreateChallengeViewModel : ObservableObject {
    @Published var exerciseDropdown = ChallengePartViewModel(type: .exercise)
    @Published var startAmountDropdown = ChallengePartViewModel(type: .startAmount)
    @Published var increaseDropdown = ChallengePartViewModel(type: .increase)
    @Published var lengthDropdown = ChallengePartViewModel(type: .length)
    
    @Published var error: IncrementError?
    @Published var isLoading = false
    
    private let userService: UserServiceProtocol
    private let challengeService: ChallengeServiceProtocol
    private var cancellables: [AnyCancellable] = []
    
    enum Action {
        case createChallenge
    }
    
    
    init(userService: UserServiceProtocol = UserService(), challengeService: ChallengeServiceProtocol = ChallengeService()) {
        self.userService = userService
        self.challengeService = challengeService
    }
    
    func send(action: Action) {
        switch action {
        case .createChallenge:
            isLoading = true
            currrentUserId().flatMap { userId -> AnyPublisher<Void, IncrementError> in
                return self.createChallenge(userId: userId)
            }
            .sink { completion in
                self.isLoading = false
                switch completion {
                case let .failure(error):
                    self.error = error
                case .finished:
                    print("finished")
                }
            } receiveValue: { _ in
                print("success")
            }.store(in: &cancellables)
            
        }
    }
    
    private func createChallenge(userId: UserId) -> AnyPublisher<Void, IncrementError> {
        guard let exercise = exerciseDropdown.text,
              let startAmount = startAmountDropdown.number,
              let increase = increaseDropdown.number,
              let length = lengthDropdown.number else {
            return Fail(error: .default(description: "Parsing error")).eraseToAnyPublisher()
        }
        
        let challenge = Challenge(
            exercise: exercise,
            startAmount: startAmount,
            increase: increase,
            length: length,
            userId: userId,
            startDate: Date())
        
        return challengeService.create(challenge).eraseToAnyPublisher()
    }
    
    
    private func currrentUserId() -> AnyPublisher<UserId , IncrementError> {
        return userService.currentUser().flatMap { user -> AnyPublisher<UserId, IncrementError> in
            if let userId = user?.uid {
                
                return Just(userId)
                    .setFailureType(to: IncrementError.self)
                    .eraseToAnyPublisher()
            } else {
                return self.userService
                    .signInAnonymously()
                    .map {$0.uid}
                    .eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
}

extension CreateChallengeViewModel {
    struct ChallengePartViewModel: DropdownItemProtocol {
        var selectedOption: DropdownOption
        
        var options: [DropdownOption]
        
        var headerTitle: String {
            type.rawValue
        }
        
        var dropdownTitle: String {
            selectedOption.formatted
        }
        
        var isSelected: Bool = false
        private let type: ChallengePartType
        
        init(type: ChallengePartType){
            switch type {
            case .exercise:
                self.options = ExerciseOption.allCases.map {$0.toDropdownOption}
            case .startAmount:
                self.options = StartOption.allCases.map {$0.toDropdownOption}
            case .increase:
                self.options = IncreaseOption.allCases.map {$0.toDropdownOption}
            case .length:
                self.options = LengthOption.allCases.map {$0.toDropdownOption}
            }
            self.type = type
            self.selectedOption = options.first!
        }
        
        enum ChallengePartType: String, CaseIterable {
            case exercise = "Exercise"
            case startAmount = "Starting Amount"
            case increase = "Daily Increase"
            case length = "Challenge Length"
        }
        
        enum ExerciseOption: String, CaseIterable, DropdownOptionProtocol {
            case pullups
            case pushups
            case situps
            case muscleups
            case handStand
            
            var toDropdownOption: DropdownOption {
                .init(type: .text(rawValue), formatted: rawValue.capitalized)
            }
        }
        
        enum StartOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two = 10, three = 20, four = 30, five = 40, six = 50
            
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: "\(rawValue)")
            }
        }
        
        enum IncreaseOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1,  two, three, four, five, ten = 10
            
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: "+\(rawValue)")
            }
        }
        
        enum LengthOption: Int, CaseIterable, DropdownOptionProtocol {
            case seven = 7, fourteen = 14, twentyOne = 21, twentyEight = 28, twomount = 60, sixmonht = 180, year = 365
            
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: "\(rawValue) days")
            }
        }
        
    }
}

extension CreateChallengeViewModel.ChallengePartViewModel {
    var text: String? {
        if case let .text(text) = selectedOption.type {
            return text
        }
        return nil
    }
    
    var number: Int? {
        if case let .number(number) = selectedOption.type {
            return number
        }
        return nil
    }
}
