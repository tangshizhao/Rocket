import Foundation
import Alamofire

// MARK: - Protocol
public protocol AuthorizationRequestType: RequestType {
    var authorizationKey: String { get }
    var authroizationValue: String { get }
    
    func authorizedHeaders() -> HTTPHeaders?
}

// MARK: - Default Implemention
extension AuthorizationRequestType {
    func authorizedHeaders() -> HTTPHeaders? {
        var authorizedHeaders = headers
        authorizedHeaders?[authorizationKey] = authroizationValue
        return authorizedHeaders
    }
}
