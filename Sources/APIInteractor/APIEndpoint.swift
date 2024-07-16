//
//  APIEndpoint.swift
//  DBZ-Guide
//
//  Created by Ethan Borrowman on 7/8/24.
//

import Foundation

public protocol APIEndpoint {
    var url: String { get }
    var httpMethod: HttpMethodType { get }
}
