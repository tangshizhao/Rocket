import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

public struct RequestUploader: Identifiable {
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

// MARK: - Upload Single Uploadable Object
extension RequestUploader {

    @discardableResult
    public func upload(_ request: UploadableRequest, on queue: DispatchQueue? = nil) -> Promise<HTTPResponse> {
        guard let httpRequest = try? HTTPRequest(request: request, identifier: self) else {
            return Promise(error: RequestError.invalidURL)
        }
        return self
            .uploadRequest(request, with: httpRequest)
            .httpResponse(identifier: self, on: queue)
    }
    
    @discardableResult
    public func upload(_ request: UploadableRequest, on queue: DispatchQueue? = nil) -> Promise<Data> {
        guard let httpRequest = try? HTTPRequest(request: request, identifier: self) else {
            return Promise(error: RequestError.invalidURL)
        }
        return self
            .uploadRequest(request, with: httpRequest)
            .responseData(identifier: self, on: queue)
    }
    
    @discardableResult
    public func upload(_ request: UploadableRequest, on queue: DispatchQueue? = nil) -> Promise<String> {
        guard let httpRequest = try? HTTPRequest(request: request, identifier: self) else {
            return Promise(error: RequestError.invalidURL)
        }
        return self
            .uploadRequest(request, with: httpRequest)
            .responseString(identifier: self, on: queue)
    }
    
    private func uploadRequest(_ request: UploadableRequest, with httpRequest: HTTPRequest) -> UploadRequest {
        var uploadRequest: UploadRequest
        switch request.uploadObject {
        case .fileURL(let fileURL):
            uploadRequest = self.sessionManager.upload(fileURL, with: httpRequest)
        case .data(let data):
            uploadRequest = self.sessionManager.upload(data, with: httpRequest)
        case .inputStream(let inputStream):
            uploadRequest = self.sessionManager.upload(inputStream, with: httpRequest)
        }
        return uploadRequest
    }
    
}



// MARK: - Upload Multi-part Form Data
extension RequestUploader {
    @discardableResult
    public func upload(_ request: MultipartFormDataUploadRequest, on queue: DispatchQueue? = nil) -> Promise<HTTPResponse> {
        return self
            .encodedUploadRequest(request, on: queue)
            .then { $0.httpResponse(identifier: self, on: queue) }
    }
    
    @discardableResult
    public func upload(_ request: MultipartFormDataUploadRequest, on queue: DispatchQueue? = nil) -> Promise<Data> {
        return self
            .encodedUploadRequest(request, on: queue)
            .then { $0.responseData(identifier: self, on: queue) }
    }
    
    @discardableResult
    public func upload(_ request: MultipartFormDataUploadRequest, on queue: DispatchQueue? = nil) -> Promise<String> {
        return self
            .encodedUploadRequest(request, on: queue)
            .then { $0.responseString(identifier: self, on: queue) }
    }
    
    private func encodedUploadRequest(_ request: MultipartFormDataUploadRequest, on queue: DispatchQueue? = nil) -> Promise<UploadRequest> {
        return Promise { (seal) in
            guard let httpRequest = try? HTTPRequest(request: request, identifier: self) else {
                seal.reject(RequestError.invalidURL)
                return
            }
            self.sessionManager.upload(
                multipartFormData: request.multipartFormData,
                usingThreshold: self.config.uploadConfig.encodingMemoryThreshold,
                with: httpRequest,
                queue: queue
            ) { (result) in
                switch result {
                case .success(let uploadRequest, _, _):
                    seal.fulfill(uploadRequest)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
}
