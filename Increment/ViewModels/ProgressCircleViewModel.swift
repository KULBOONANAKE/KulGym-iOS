//
//  ProgressCircleViewModel.swift
//  Increment
//
//  Created by Kul Boonanake on 18/5/23.
//

import Foundation

struct ProgressCircleViewModel {
    let title: String
    let message: String
    let percentageComplete: Double
    var shouldShowTitle: Bool {
        percentageComplete <= 1
    }
}
