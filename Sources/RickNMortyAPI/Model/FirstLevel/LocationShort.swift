//
//  LocationShort.swift
//  
//
//  Created by Дмитрий Болучевских
//

import Foundation

public struct LocationShort: Codable, Hashable {
    /** The name of the location */
    public var name: String = .init()
    /** Link to the location's own endpoint */
    public var url: String = .init()

    public init() {}

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case url
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(url, forKey: .url)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = (try? container.decode(String.self, forKey: .name)) ?? .init()
        url = (try? container.decode(String.self, forKey: .url)) ?? .init()
    }

    public static func == (lhs: LocationShort, rhs: LocationShort) -> Bool {
        lhs.name == rhs.name && lhs.url == rhs.url
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(name.hashValue)
        hasher.combine(url.hashValue)
    }
}
