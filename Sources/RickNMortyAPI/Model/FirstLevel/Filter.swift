//
//  Filter.swift
//  
//
//  Created by Дмитрий Болучевских
//

import Foundation

public enum FilterType {
    case character
    case episode
    case location
}

public protocol Filter {
    var filterType: FilterType { get set }
    var name: String? { get }

    func toNetwork() -> [String]?
}

public extension Filter {
    func toNetwork() -> [String]? {
        var networkFilters: [String] = []
        switch filterType {
        case .character:
            guard let filter = self as? CharacterFilter else { return nil }
            if let name = filter.name {
                networkFilters.append("name=\(name)")
            }
            if let status = filter.status {
                networkFilters.append("status=\(status.rawValue.lowercased())")
            }
            if let species = filter.species {
                networkFilters.append("species=\(species)")
            }
            if let type = filter.type {
                networkFilters.append("type=\(type)")
            }
            if let gender = filter.gender {
                networkFilters.append("gender=\(gender.rawValue.lowercased())")
            }
            return networkFilters
        case .episode:
            guard let filter = self as? EpisodeFilter else { return nil }
            if let name = filter.name {
                networkFilters.append("name=\(name)")
            }
            if let episode = filter.episode {
                networkFilters.append("episode=\(episode)")
            }
            return networkFilters
        case .location:
            guard let filter = self as? LocationFilter else { return nil }
            if let name = filter.name {
                networkFilters.append("name=\(name)")
            }
            if let type = filter.type {
                networkFilters.append("type=\(type)")
            }
            if let dimension = filter.dimension {
                networkFilters.append("dimension=\(dimension)")
            }
            return networkFilters
        }
    }
}

public struct CharacterFilter: Filter {
    public var filterType: FilterType = .character
    public var name: String?
    public var status: CharacterStatus?
    public var species: String?
    public var type: String?
    public var gender: CharacterGender?
}

public struct EpisodeFilter: Filter {
    public var filterType: FilterType = .episode
    public var name: String?
    public var episode: String?
}

public struct LocationFilter: Filter {
    public var filterType: FilterType = .location
    public var name: String?
    public var type: String?
    public var dimension: String?
}
