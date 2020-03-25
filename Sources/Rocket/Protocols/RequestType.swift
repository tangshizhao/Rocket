import Foundation
import Alamofire

// MARK: - Protocol
public protocol RequestType: URLConvertible {
    var host: String { get }
    var uri: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var parameterEncoding: ParameterEncoding { get }
}

// MARK: - URLConvertible
extension RequestType {
    public func asURL() throws -> URL {
        return try (host + uri).asURL()
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
