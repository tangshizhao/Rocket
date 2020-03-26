//
//  HTTPRequest.swift
//  Rocket
//
//  Created by 汤世昭 on 2020/3/3.
//

import Foundation
import Alamofire

public struct HTTPRequest: URLRequestConvertible, CustomStringConvertible {
    public let url: URL
    public let method: HTTPMethod
    public let headers: HTTPHeaders?
    public let parameters: Parameters?
    public let parameterEncoding: ParameterEncoding
    
    public init(request: RequestType, identifier: Identifiable) throws {
        self.url = try request.asURL()
        self.method = request.method
        switch request {
        case let authorizationRequest as AuthorizationRequestType:
            self.headers = authorizationRequest.authorizedHeaders()
        default:
            self.headers = request.headers
        }
        self.parameters = request.parameters
        self.parameterEncoding = request.parameterEncoding
        self.print(by: identifier)
    }
    
    public init(request: DownloadableRequest, identifier: Identifiable) throws {
        self.url = try request.urlString.asURL()
        self.method = .get
        self.headers = nil
        self.parameters = nil
        self.parameterEncoding = URLEncoding.default
        self.print(by: identifier)
    }
    
    private func print(by identifier: Identifiable) {
        Printer.print(self, with: identifier)
    }
}


// MARK: - URLRequestConvertible
extension HTTPRequest {
    public func asURLRequest() throws -> URLRequest {
        let riginalRequest = try URLRequest(url: url, method: method, headers: headers)
        return try parameterEncoding.encode(riginalRequest, with: parameters)
    }
}

// MARK: - CustomStringConvertible
extension HTTPRequest {
    public var description: String {
        return "---------- HTTPRequest ----------" + "\n"
            + "URL: \(url.absoluteString)" + "\n"
            + "Method: \(method.rawValue)" + "\n"
            + "Headers: \(headers ?? [:])" + "\n"
            + "Parameters: \(parameters ?? [:])" + "\n"
            + "Parameter Encoding: \(parameterEncoding)" + "\n"
            + "-----------------------------"
    }
}
