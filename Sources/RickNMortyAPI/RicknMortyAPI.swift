//
//  RicknMortyAPI.swift
//  
//
//  Created by Дмитрий Болучевских
//

import Foundation

enum NetworkHandlerError: Error {
    case InvalidURL
    case JSONDecodingError
    case RequestError(String)
    case UnknownError
}

struct ResponseErrorMessage: Codable {
    let error: String
}

open class RicknMortyAPI {

    var baseURL: String = "https://rickandmortyapi.com/api/"

    /**
     Perform API request with given method.
     - parameter method: URL for API request.
     - parameter page: Page for request
     - parameter filter: Needed filters 
     - Returns: response.
     */
    func performAPIRequestByMethod<T: Codable>(
        method: String,
        page: Int? = nil,
        filter: [String]? = nil
    ) async throws -> T {
        let urlString = baseURL + method
        guard var urlComponents = URLComponents(string: urlString) else {
            throw(NetworkHandlerError.InvalidURL)
        }
        var queryItems: [URLQueryItem] = []

        if let page {
            queryItems = [
                URLQueryItem(name: "page", value: "\(page)")
            ]
        }

        if let filter, !filter.isEmpty {
            let filterQuerryItems: [URLQueryItem] = filter.compactMap { it -> URLQueryItem? in
                let components = it.components(separatedBy: "=")
                let (name, value) = (components.first, components.last)
                if let name {
                    return URLQueryItem(name: name, value: value)
                }
                return nil
            }
            queryItems.append(contentsOf: filterQuerryItems)
        }

        if !queryItems.isEmpty {
            urlComponents.queryItems = queryItems
        }

        guard let url = urlComponents.url else {
            throw(NetworkHandlerError.InvalidURL)
        }
        print("URL: \(url)")

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
            let error: ResponseErrorMessage = try decodeJSONData(data: data)
            throw NetworkHandlerError.RequestError(error.error)
        }
        guard let response = try? decodeJSONData(data: data) as T else {
            throw(NetworkHandlerError.JSONDecodingError)
        }
        return response
    }

    /**
     Perform API request with given URL.
     - Parameter url: URL for API request.
     - Returns: response.
     */
    func performAPIRequestByURL<T: Codable>(url: String) async throws -> T {
        if let url = URL(string: url) {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                let error: ResponseErrorMessage = try decodeJSONData(data: data)
                throw NetworkHandlerError.RequestError(error.error)
            }
            guard let response = try? decodeJSONData(data: data) as T else {
                throw(NetworkHandlerError.JSONDecodingError)
            }
            return response
        } else {
            throw(NetworkHandlerError.InvalidURL)
        }
    }

    /**
     Decode JSON response for codable struct model.
     - Parameters:
     - data: HTTP data response.
     - Returns: Model struct of associated variable type.
     */
    func decodeJSONData<T: Codable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkHandlerError.JSONDecodingError
        }
    }
}
