//
//  LocationApi.swift
//  
//
//  Created by Дмитрий Болучевских
//

import Foundation

public struct LocationApi {

    public init() {
        builder = ApiBuilder<LocationsResponse>()
    }

    public static let methods: LocationApi = LocationApi()

    private let builder: ApiBuilder<LocationsResponse>

    public func getAllLocations() async throws -> [Location] {
        try await builder.getAll(with: .location)
    }

    public func getAllLocations(page: Int? = nil, filter: (any Filter)? = nil) async throws -> LocationsResponse {
        try await builder.getAll(from: page, withMethod: .location, andFilter: filter)
    }

    public func getLocations(by ids: [Int]) async throws -> [Location] {
        try await builder.get(by: ids, withMethod: .location)
    }

    public func getLocation(by id: Int) async throws -> Location {
        try await builder.get(by: id, withMethod: .location)
    }

    public func getLocation(by url: String) async throws -> Location {
        try await builder.get(by: url)
    }
}
