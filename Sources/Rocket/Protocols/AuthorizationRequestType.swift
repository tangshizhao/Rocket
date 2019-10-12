import Foundation
import Alamofire

// MARK: - Protocol
public protocol AuthorizationRequestType: RequestType {
    var authorizationKey: String { get }
    var authroizationValue: String { get }
    
    func authorize(header: HTTPHeaders?) -> HTTPHeaders?
}

// MARK: - Default Implemention
extension AuthorizationRequestType {
    func authorize(header: HTTPHeaders?) -> HTTPHeaders? {
        var header = header
        header?[authorizationKey] = authroizationValue
        return header
    }
}

// MARK: - URLRequestConvertible
extension AuthorizationRequestType {
    public func asURLRequest() throws -> URLRequest {
        let url = try (host + uri).asURL()
        let authorizedHeaders = authorize(header: headers)
        let riginalRequest = try URLRequest(url: url, method: method, headers: authorizedHeaders)
        return try parameterEncoding.encode(riginalRequest, with: parameters)
    }
}
