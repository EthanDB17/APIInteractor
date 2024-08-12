//
//  APIService.swift
//  DBZ-Guide
//
//  Created by Ethan Borrowman on 7/8/24.
//

import Foundation

public protocol IAPIExecutor {
    func executeRequest<T: Decodable>(endpoint: APIEndpoint, parameters: [String:String]?) async throws(APIError) -> T
}

public struct APIExecutor: IAPIExecutor {
    
    public init() {}
        
    // MARK: - Execution -
    
    public func executeRequest<T: Decodable>(endpoint: APIEndpoint, parameters: [String:String]?) async throws(APIError) -> T {
        guard let url = URL(string: endpoint.url), var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw APIError(errorType: .invalidURL)
        }
        
        if let parameters {
            components.queryItems = []
            for key in parameters.keys {
                components.queryItems?.append(URLQueryItem(name: key, value: parameters[key]))
            }
        }
        
        guard let comoponentUrl = components.url else {
            throw APIError(errorType: .invalidURL)
        }
        
        var request = URLRequest(url: comoponentUrl)
        request.httpMethod = endpoint.httpMethod.rawValue
        
        let session = URLSession.shared
        
        do {
            let (data, _) = try await session.data(for: request)
            
            guard !data.isEmpty else {
                throw APIError(errorType: .missingData)
            }
            
            guard let modelData = try? JSONDecoder().decode(T.self, from: data) else {
                throw APIError(errorType: .parseFailure)
            }
            
            return modelData
            
        } catch {
            throw APIError(errorType: .generic(message: error.localizedDescription))
        }
    }
}
