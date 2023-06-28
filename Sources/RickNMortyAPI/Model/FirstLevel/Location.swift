//
//  File.swift
//  
//
//  Created by Дмитрий Болучевских
//

import Foundation

public struct Location: ResponseResult, Hashable {
    /** The id of the location */
    public var id: Int = .init()
    /** The name of the location */
    public var name: String = .init()
    /** The type of the location */
    public var type: String = .init()
    /** The dimension in which the location is located */
    public var dimension: String = .init()
    /** List of character who have been last seen in the location */
    public var residents: [String] = .init()
    /** Link to the location's own endpoint */
    public var url: String = .init()
    /** Time at which the location was created in the database */
    public var created: String = .init()

    public init() {}

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case name
        case type
        case dimension
        case residents
        case url
        case created
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(dimension, forKey: .dimension)
        try container.encode(residents, forKey: .residents)
        try container.encode(url, forKey: .url)
        try container.encode(created, forKey: .created)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? container.decode(Int.self, forKey: .id)) ?? .init()
        name = (try? container.decode(String.self, forKey: .name)) ?? .init()
        type = (try? container.decode(String.self, forKey: .type)) ?? .init()
        dimension = (try? container.decode(String.self, forKey: .dimension)) ?? .init()
        residents = (try? container.decode([String].self, forKey: .residents)) ?? .init()
        url = (try? container.decode(String.self, forKey: .url)) ?? .init()
        created = (try? container.decode(String.self, forKey: .created)) ?? .init()
    }

    public static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.type == rhs.type &&
        lhs.dimension == rhs.dimension &&
        lhs.residents == rhs.residents &&
        lhs.url == rhs.url &&
        lhs.created == rhs.created
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id.hashValue)
        hasher.combine(name.hashValue)
        hasher.combine(type.hashValue)
        hasher.combine(dimension.hashValue)
        hasher.combine(residents.hashValue)
        hasher.combine(url.hashValue)
        hasher.combine(created.hashValue)
    }
}
