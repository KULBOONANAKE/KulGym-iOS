//
//  Challenge.swift
//  Increment
//
//  Created by Kul Boonanake on 17/5/23.
//

import Foundation

struct Challenge: Codable {
    let exercise: String
    let startAmount: Int
    let increase: Int
    let length: Int
    let userId: String
    let startDate: Date
}
