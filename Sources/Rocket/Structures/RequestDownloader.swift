import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

public struct RequestDownloader: Identifiable {
    public let uuid: UUID
    public let config: Config
    
    private let sessionManager: SessionManager
    
    public init(config: Config) {
        self.uuid = UUID()
        self.config = config
        self.sessionManager = SessionManager(policyConfig: config.policyConfig)
    }
    
    private func validate(_ urlRequest: URLRequest?, _ httpUrlResponse: HTTPURLResponse, _ data: Data?) -> DataRequest.ValidationResult {
        guard let validator = self.config.validationConfig?.responseValidator else {
            return .success
        }
        return validator(urlRequest, httpUrlResponse, data)
    }
    
}

extension RequestDownloader {
    
    @discardableResult
    public func download(request: DownloadableRequest, on queue: DispatchQueue? = nil) -> Promise<HTTPResponse> {
        guard let httpRequest = try? HTTPRequest(request: request, identifier: self) else {
            return Promise(error: RequestError.invalidURL)
        }
        return self.sessionManager
            .download(httpRequest, to: request.destination)
            .httpResponse(identifier: self, on: queue)
    }
    
    @discardableResult
    public func download(request: DownloadableRequest, on queue: DispatchQueue? = nil) -> Promise<Data> {
        guard let httpRequest = try? HTTPRequest(request: request, identifier: self) else {
            return Promise(error: RequestError.invalidURL)
        }
        return self.sessionManager
            .download(httpRequest, to: request.destination)
            .responseData(identifier: self, on: queue)
    }
    
    @discardableResult
    public func download(request: DownloadableRequest, on queue: DispatchQueue? = nil) -> Promise<URL> {
        guard let httpRequest = try? HTTPRequest(request: request, identifier: self) else {
            return Promise(error: RequestError.invalidURL)
        }
        return self.sessionManager
            .download(httpRequest, to: request.destination)
            .fileUrlResponse(identifier: self, on: queue)
    }
    
}
