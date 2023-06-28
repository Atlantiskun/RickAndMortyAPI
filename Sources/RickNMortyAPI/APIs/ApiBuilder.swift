//
//  ApiBuilder.swift
//  
//
//  Created by Дмитрий Болучевских
//

import Foundation

public protocol ResponseProtocol: Codable {
    associatedtype  R
    var results: [R] { get set }
    var info: Info { get set }
}

public protocol ResponseResult: Codable {
    var id: Int { get set }
}

public struct ApiBuilder<T: ResponseProtocol> {

    public enum Method: String {
        case character
        case location
        case episode
    }

    public init() {}

    let api: RicknMortyAPI = RicknMortyAPI()

    public func getAll<R>(with method: Method) async throws -> [R] where R: ResponseResult, T.R == R {
        let response: T = try await api.performAPIRequestByMethod(method: method.rawValue)
        let result: [R] = try await withThrowingTaskGroup(of: [R].self) { group in
            for index in 1...response.info.pages {
                group.addTask {
                    let response: T = try await api.performAPIRequestByMethod(method: "\(method)/?page=\(index)")
                    return response.results
                }
            }

            return try await group.reduce(into: [R]()) { allResults, result in
                allResults.append(contentsOf: result)
            }
        }
        return result.sorted { $0.id < $1.id }
    }

    public func getAll(from page: Int? = nil, withMethod: Method, andFilter: (any Filter)? = nil) async throws -> T {
        let response: T = try await api.performAPIRequestByMethod(
            method: withMethod.rawValue,
            page: page,
            filter: andFilter?.toNetwork()
        )
        return response
    }

    public func get<R: Codable>(by ids: [Int], withMethod: Method) async throws -> [R] {
        let stringIDs = ids.map { String($0) }
        let response: [R] = try await api.performAPIRequestByMethod(method: "\(withMethod)/\(stringIDs.joined(separator: ","))")
        return response
    }

    public func get<R: Codable>(by id: Int, withMethod: Method) async throws -> R {
        try await api.performAPIRequestByMethod(method: "\(withMethod)/\(id)")
    }

    public func get<R: Codable>(by url: String) async throws -> R {
        try await api.performAPIRequestByURL(url: url)
    }
}
