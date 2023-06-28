//
//  CharactersResponse.swift
//  
//
//  Created by Дмитрий Болучевских
//

import Foundation

public struct CharactersResponse: ResponseProtocol, Hashable {
    /** Response info */
    public var info: Info = .init()
    /** Response result */
    public var results: [Character] = .init()

    public init() {}

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case info
        case results
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(info, forKey: .info)
        try container.encode(results, forKey: .results)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        info = (try? container.decode(Info.self, forKey: .info)) ?? .init()
        results = (try? container.decode([Character].self, forKey: .results)) ?? .init()
    }

    public static func == (lhs: CharactersResponse, rhs: CharactersResponse) -> Bool {
        lhs.info == rhs.info &&
        lhs.results == rhs.results
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(info.hashValue)
        hasher.combine(results.hashValue)
    }
}
