
import Foundation
import Alamofire



public struct ValidationConfig {
    
    public typealias ResponseValidator = (URLRequest?, HTTPURLResponse, Data?) -> DataRequest.ValidationResult
    public static let defaultResponseValidator: ResponseValidator = { (urlRequest, httpUrlResponse, data) -> DataRequest.ValidationResult in
        let status = HTTPStatus(statusCode: httpUrlResponse.statusCode)
        guard HTTPStatus.successStatus.contains(status) else {
            let status = HTTPStatus(statusCode: httpUrlResponse.statusCode)
            return .failure(ResponseError.invalid(status: status))
        }
        return .success
    }
    
    public let responseValidator: ResponseValidator?
    
    public init(responseValidator: @escaping ResponseValidator = ValidationConfig.defaultResponseValidator) {
        self.responseValidator = responseValidator
    }
}
