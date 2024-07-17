//
//  APIError.swift
//  DBZ-Guide
//
//  Created by Ethan Borrowman on 7/8/24.
//

import Foundation

public struct APIError: Error {
    let errorType: APIErrorType
    
    public var errorMessage: String {
        return errorType.errorMessage
    }
}

public enum APIErrorType: Sendable {
    case invalidURL
    case missingData
    case parseFailure
    
    case generic(message: String)
    
    public var errorMessage: String {
        switch self {
        case .invalidURL: return "The URL specified is invalid."
        case .missingData: return "The response did not contain any data."
        case .parseFailure: return "The response was unable to be read."
        case .generic(let message): return message
        }
    }
}
