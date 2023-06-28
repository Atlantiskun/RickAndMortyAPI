//
//  EpisodeApi.swift
//  
//
//  Created by Дмитрий Болучевских
//

import Foundation

public struct EpisodeApi {

    public init() {
        builder = ApiBuilder<EpisodesResponse>()
    }

    public static let methods: EpisodeApi = EpisodeApi()

    private let builder: ApiBuilder<EpisodesResponse>

    public func getAllEpisodes() async throws -> [Episode] {
        try await builder.getAll(with: .episode)
    }

    public func getAllEpisodes(page: Int? = nil, filter: (any Filter)? = nil) async throws -> EpisodesResponse {
        try await builder.getAll(from: page, withMethod: .episode, andFilter: filter)
    }

    public func getEpisode(by ids: [Int]) async throws -> [Episode] {
        try await builder.get(by: ids, withMethod: .episode)
    }

    public func getEpisode(by id: Int) async throws -> Episode {
        try await builder.get(by: id, withMethod: .episode)
    }

    public func getEpisode(by url: String) async throws -> Episode {
        try await builder.get(by: url)
    }
}
