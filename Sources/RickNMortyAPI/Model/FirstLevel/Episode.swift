//
//  File.swift
//  
//
//  Created by Дмитрий Болучевских
//

import Foundation

public struct Episode: ResponseResult, Hashable {
    /** The id of the episode */
    public var id: Int = .init()
    /** The name of the episode */
    public var name: String = .init()
    /** The air date of the episode */
    public var airDate: String = .init()
    /** The code of the episode */
    public var episode: String = .init()
    /** List of characters who have been seen in the episode */
    public var characters: [String] = .init()
    /** Link to the episode's own endpoint */
    public var url: String = .init()
    /** Time at which the episode was created in the database */
    public var created: String = .init()

    public init() {}

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case name
        case airData = "air_date"
        case episode
        case characters
        case url
        case created
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(airDate, forKey: .airData)
        try container.encode(episode, forKey: .episode)
        try container.encode(characters, forKey: .characters)
        try container.encode(url, forKey: .url)
        try container.encode(created, forKey: .created)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? container.decode(Int.self, forKey: .id)) ?? .init()
        name = (try? container.decode(String.self, forKey: .name)) ?? .init()
        airDate = (try? container.decode(String.self, forKey: .airData)) ?? .init()
        episode = (try? container.decode(String.self, forKey: .episode)) ?? .init()
        characters = (try? container.decode([String].self, forKey: .characters)) ?? .init()
        url = (try? container.decode(String.self, forKey: .url)) ?? .init()
        created = (try? container.decode(String.self, forKey: .created)) ?? .init()
    }

    public static func == (lhs: Episode, rhs: Episode) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.airDate == rhs.airDate &&
        lhs.episode == rhs.episode &&
        lhs.characters == rhs.characters &&
        lhs.url == rhs.url &&
        lhs.created == rhs.created
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id.hashValue)
        hasher.combine(name.hashValue)
        hasher.combine(airDate.hashValue)
        hasher.combine(episode.hashValue)
        hasher.combine(characters.hashValue)
        hasher.combine(url.hashValue)
        hasher.combine(created.hashValue)
    }
}
