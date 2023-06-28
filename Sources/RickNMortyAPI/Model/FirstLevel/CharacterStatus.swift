//
//  CharacterStatus.swift
//  
//
//  Created by Дмитрий Болучевских
//

import Foundation

public enum CharacterStatus: String, Codable, CaseIterable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown

    public init() {
        self = CharacterStatus.allCases.first!
    }
}
