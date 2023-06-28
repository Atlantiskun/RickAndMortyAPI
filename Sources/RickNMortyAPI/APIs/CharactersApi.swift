//
//  CharactersApi.swift
//  
//
//  Created by Дмитрий Болучевских
//

import Foundation

public class CharactersApi {

    public init() {
        builder = ApiBuilder<CharactersResponse>()
    }

    public static let methods: CharactersApi = CharactersApi()

    private let builder: ApiBuilder<CharactersResponse>

    public func getAllCharacters() async throws -> [Character] {
        try await builder.getAll(with: .character)
    }

    public func getAllCharacters(page: Int? = nil, filter: (any Filter)? = nil) async throws -> CharactersResponse {
        try await builder.getAll(from: page, withMethod: .character, andFilter: filter)
    }

    public func getCharacter(by ids: [Int]) async throws -> [Character] {
        try await builder.get(by: ids, withMethod: .character)
    }

    public func getCharacter(by id: Int) async throws -> Character {
        try await builder.get(by: id, withMethod: .character)
    }

    public func getCharacter(by url: String) async throws -> Character {
        try await builder.get(by: url)
    }
}
