import Foundation
import Alamofire

// MARK: - Protocol
public protocol RequestType: URLRequestConvertible, URLConvertible, CustomStringConvertible {
    var host: String { get }
    var uri: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var parameterEncoding: ParameterEncoding { get }
}

// MARK: - URLRequestConvertible
extension RequestType {
    public func asURLRequest() throws -> URLRequest {
        let url = try asURL()
        let riginalRequest = try URLRequest(url: url, method: method, headers: headers)
        return try parameterEncoding.encode(riginalRequest, with: parameters)
    }
}

// MARK: - URLConvertible
extension RequestType {
    public func asURL() throws -> URL {
        return try (host + uri).asURL()
    }
}

// MARK: - CustomStringConvertible
extension RequestType {
    public var description: String {
        return "---------- Request ----------" + "\n"
            + "URL: \(host)\(uri)" + "\n"
            + "Method: \(method.rawValue)" + "\n"
            + "Headers: \(headers ?? [:])" + "\n"
            + "Parameters: \(parameters ?? [:])" + "\n"
            + "Parameter Encoding: \(parameterEncoding)" + "\n"
            + "-----------------------------"
    }
}

// MARK: - Default Implemention
extension RequestType {
    var headers: HTTPHeaders? {
        return nil
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    var parameterEncoding: ParameterEncoding {
        if method == .get {
            return URLEncoding.queryString
        }
        return JSONEncoding.default
    }
}
