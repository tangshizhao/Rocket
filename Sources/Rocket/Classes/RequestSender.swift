import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

public final class RequestSender: Identifiable {
    
    public let uuid: UUID
    public var successStatusCodes: Range<Int> = 200 ..< 300
    
    public init() {
        self.uuid = UUID()
    }
        
    /// 发送请求并异步返回HTTPResponse对象
    ///
    /// - Parameters:
    ///   - request: 请求对象
    ///   - queue: 响应解析队列
    /// - Returns: 包含Data的Promise对象
    @discardableResult
    public func send(_ request: RequestType, on queue: DispatchQueue? = nil) -> Promise<HTTPResponse> {
        guard let httpRequest = try? HTTPRequest(request: request, identifier: self) else {
            return Promise(error: RequestError.invalidURL)
        }
        return self.send(httpRequest, on: queue)
    }
    
    /// 发送请求并异步返回HTTPResponse对象
    ///
    /// - Parameters:
    ///   - request: HTTPRequest请求对象
    ///   - queue: 响应解析队列
    /// - Returns: 包含Data的Promise对象
    @discardableResult
    public func send(_ request: HTTPRequest, on queue: DispatchQueue? = nil) -> Promise<HTTPResponse> {
        return Alamofire
            .request(request)
            .httpResponse(identifier: self, on: queue)
    }
    
    /// 发送请求并异步返回Data对象
    ///
    /// - Parameters:
    ///   - request: 请求对象
    ///   - queue: 响应解析队列
    /// - Returns: 包含Data的Promise对象
    @discardableResult
    public func send(_ request: RequestType, on queue: DispatchQueue? = nil) -> Promise<Data> {
        return Alamofire
            .request(request)
            .validate(validate)
            .responseData(identifier: self, on: queue)
    }
    
    /// 发送请求并异步返回String对象
    ///
    /// - Parameters:
    ///   - request: 请求对象
    ///   - queue: 响应解析队列
    /// - Returns: 包含String的Promise对象
    @discardableResult
    public func send(_ request: RequestType, on queue: DispatchQueue? = nil) -> Promise<String> {
        return Alamofire
            .request(request)
            .validate(validate)
            .responseString(identifier: self, on: queue)
    }

    
    private func validate(_ urlRequest: URLRequest?, _ httpUrlResponse: HTTPURLResponse, _ data: Data?) -> DataRequest.ValidationResult {
        switch httpUrlResponse.statusCode {
        case successStatusCodes:
            return .success
        default:
            let status = HTTPStatus(statusCode: httpUrlResponse.statusCode)
            return .failure(ResponseError.invalid(status: status))
        }
    }
}
