//
//  Character.swift
//  
//
//  Created by Дмитрий Болучевских
//

import Foundation

public struct Character: ResponseResult, Hashable {
    /** The id of the character */
    public var id: Int = .init()
    /** The name of the character */
    public var name: String = .init()
    /** The status of the character ('Alive', 'Dead' or 'unknown') */
    public var status: CharacterStatus = .init()
    /** The species of the character */
    public var species: String = .init()
    /** The type or subspecies of the character */
    public var type: String = .init()
    /** The gender of the character ('Female', 'Male', 'Genderless' or 'unknown') */
    public var gender: CharacterGender = .init()
    /** Name and link to the character's origin location */
    public var origin: LocationShort = .init()
    /** Name and link to the character's last known location endpoint */
    public var location: LocationShort = .init()
    /** Link to the character's image. All images are 300x300px and most are medium shots or portraits since they are intended to be used as avatars */
    public var image: String = .init()
    /** List of episodes in which this character appeared */
    public var episode: [String] = .init()
    /** Link to the character's own URL endpoint */
    public var url: String = .init()
    /** Time at which the character was created in the database */
    public var created: String = .init()

    public init() {}

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case name
        case status
        case species
        case type
        case gender
        case origin
        case location
        case image
        case episode
        case url
        case created
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(status, forKey: .status)
        try container.encode(species, forKey: .species)
        try container.encode(type, forKey: .type)
        try container.encode(gender, forKey: .gender)
        try container.encode(origin, forKey: .origin)
        try container.encode(location, forKey: .location)
        try container.encode(image, forKey: .image)
        try container.encode(episode, forKey: .episode)
        try container.encode(url, forKey: .url)
        try container.encode(created, forKey: .created)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? container.decode(Int.self, forKey: .id)) ?? .init()
        name = (try? container.decode(String.self, forKey: .name)) ?? .init()
        status = (try? container.decode(CharacterStatus.self, forKey: .status)) ?? .init()
        species = (try? container.decode(String.self, forKey: .species)) ?? .init()
        type = (try? container.decode(String.self, forKey: .type)) ?? .init()
        gender = (try? container.decode(CharacterGender.self, forKey: .gender)) ?? .init()
        origin = (try? container.decode(LocationShort.self, forKey: .origin)) ?? .init()
        location = (try? container.decode(LocationShort.self, forKey: .location)) ?? .init()
        image = (try? container.decode(String.self, forKey: .image)) ?? .init()
        episode = (try? container.decode([String].self, forKey: .episode)) ?? .init()
        url = (try? container.decode(String.self, forKey: .url)) ?? .init()
        created = (try? container.decode(String.self, forKey: .created)) ?? .init()
    }

    public static func == (lhs: Character, rhs: Character) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.status == rhs.status &&
        lhs.type == rhs.type &&
        lhs.gender == rhs.gender &&
        lhs.origin == rhs.origin &&
        lhs.location == rhs.location &&
        lhs.image == rhs.image &&
        lhs.episode == rhs.episode &&
        lhs.url == rhs.url &&
        lhs.created == rhs.created
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id.hashValue)
        hasher.combine(name.hashValue)
        hasher.combine(status.hashValue)
        hasher.combine(type.hashValue)
        hasher.combine(gender.hashValue)
        hasher.combine(origin.hashValue)
        hasher.combine(location.hashValue)
        hasher.combine(image.hashValue)
        hasher.combine(episode.hashValue)
        hasher.combine(url.hashValue)
        hasher.combine(created.hashValue)
    }
}
