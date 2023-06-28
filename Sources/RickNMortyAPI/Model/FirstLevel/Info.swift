//
//  Info.swift
//  
//
//  Created by Дмитрий Болучевских
//

import Foundation

public struct Info: Codable, Hashable {
    /** The length of the response */
    public var count: Int = .init()
    /** The amount of pages */
    public var pages: Int = .init()
    /** Link to the next page (if it exists) */
    public var next: String? = .init()
    /** Link to the previous page (if it exists) */
    public var prev: String? = .init()
    
    public init() {}
    
    public enum CodingKeys: String, CodingKey, CaseIterable {
        case count
        case pages
        case next
        case prev
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(count, forKey: .count)
        try container.encode(pages, forKey: .pages)
        try container.encodeIfPresent(next, forKey: .next)
        try container.encodeIfPresent(prev, forKey: .prev)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = (try? container.decode(Int.self, forKey: .count)) ?? .init()
        pages = (try? container.decode(Int.self, forKey: .pages)) ?? .init()
        next = try? container.decodeIfPresent(String.self, forKey: .next)
        prev = try? container.decodeIfPresent(String.self, forKey: .prev)
    }

    public static func == (lhs: Info, rhs: Info) -> Bool {
        lhs.count == rhs.count &&
        lhs.pages == rhs.pages &&
        lhs.next == rhs.next
        && lhs.prev == rhs.prev
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(count.hashValue)
        hasher.combine(pages.hashValue)
        hasher.combine(next.hashValue)
        hasher.combine(prev.hashValue)
    }
}

