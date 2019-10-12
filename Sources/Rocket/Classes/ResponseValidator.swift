import Foundation
import Alamofire

public let successStatusCodes: ClosedRange<Int> = 200 ... 299

// MARK: - Class
public final class ResponseValidator {
    
    public static var validator: ((URLRequest?, HTTPURLResponse, Data?) -> DataRequest.ValidationResult) = { (urlRequest, httpUrlResponse, data) in
        switch httpUrlResponse.statusCode {
        case successStatusCodes:
            return .success
        default:
            return .failure(StatusCodeError(statusCode: httpUrlResponse.statusCode))
        }
    }
}
