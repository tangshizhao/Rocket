import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

public struct RequestSender: Identifiable {
    
    public let uuid: UUID
    public let config: Config
    
    private let sessionManager: SessionManager
    
    public init(config: Config) {
        self.uuid = UUID()
        self.config = config
        self.sessionManager = SessionManager(policyConfig: config.policyConfig)
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
        return self.sessionManager
            .request(httpRequest)
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
        guard let httpRequest = try? HTTPRequest(request: request, identifier: self) else {
            return Promise(error: RequestError.invalidURL)
        }
        return self.sessionManager
            .request(httpRequest)
            .validate(self.validate)
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
        guard let httpRequest = try? HTTPRequest(request: request, identifier: self) else {
            return Promise(error: RequestError.invalidURL)
        }
        return self.sessionManager
            .request(httpRequest)
            .validate(self.validate)
            .responseString(identifier: self, on: queue)
    }
    
    private func validate(_ urlRequest: URLRequest?, _ httpUrlResponse: HTTPURLResponse, _ data: Data?) -> DataRequest.ValidationResult {
        guard let validator = self.config.validationConfig?.responseValidator else {
            return .success
        }
        return validator(urlRequest, httpUrlResponse, data)
    }
}
