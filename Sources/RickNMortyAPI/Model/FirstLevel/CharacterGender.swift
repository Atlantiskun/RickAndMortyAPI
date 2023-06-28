//
//  CharacterGender.swift
//  
//
//  Created by Дмитрий Болучевских
//

import Foundation

public enum CharacterGender: String, Codable, CaseIterable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown

    public init() {
        self = CharacterGender.allCases.first!
    }
}
