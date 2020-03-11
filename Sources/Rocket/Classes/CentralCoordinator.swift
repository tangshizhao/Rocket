import Foundation
import PromiseKit

public final class CentralCoordinator {
    public static let shared: CentralCoordinator = CentralCoordinator()
    
    private var config: Config = Config.default
    
    private let requestQueue: DispatchQueue = DispatchQueue.global(qos: .default)
    private let decodeQueue: DispatchQueue = DispatchQueue.global(qos: .default)
    private let authorizeQueue: DispatchQueue = DispatchQueue.global(qos: .default)
    
    private init() {
        
    }
    
    public func setup(with config: Config) {
        self.config = config
    }
}

// MARK: - Request Sender
extension CentralCoordinator {
    @discardableResult
    public func request(_ request: RequestType) -> Promise<HTTPResponse> {
        return RequestSender(config: self.config)
            .send(request, on: self.requestQueue)
            .recover(on: self.authorizeQueue, self.recover)
    }
    
    @discardableResult
    public func request(_ request: RequestType) -> Promise<Data> {
        return RequestSender(config: self.config)
            .send(request, on: self.requestQueue)
            .recover(on: self.authorizeQueue, self.recover)
    }
    
    @discardableResult
    public func request(_ request: RequestType) -> Promise<String> {
        return RequestSender(config: self.config)
            .send(request, on: self.requestQueue)
            .recover(on: self.authorizeQueue, self.recover)
    }
    
    @discardableResult
    public func request<P: ResponseType>(_ request: RequestType, decode type: P.Type) -> Promise<P> {
        let jsonDecoder = JSONDecoder(config: self.config.jsonDecoderConfig)
        let decoder = DataDecoder(type: type, jsonDecoder: jsonDecoder)
        return self
            .request(request)
            .then(on: self.decodeQueue) { decoder.decode($0) }
    }
}

// MARK: - Request Uploader
extension CentralCoordinator {
    @discardableResult
    public func upload(_ request: UploadableRequest) -> Promise<HTTPResponse> {
        return RequestUploader(config: self.config)
            .upload(request, on: self.requestQueue)
            .recover(on: self.authorizeQueue, self.recover)
    }
    
    @discardableResult
    public func upload(_ request: UploadableRequest) -> Promise<Data> {
         return RequestUploader(config: self.config)
             .upload(request, on: self.requestQueue)
             .recover(on: self.authorizeQueue, self.recover)
    }
    
    @discardableResult
    public func upload(_ request: UploadableRequest) -> Promise<String> {
         return RequestUploader(config: self.config)
             .upload(request, on: self.requestQueue)
             .recover(on: self.authorizeQueue, self.recover)
    }
    
    @discardableResult
    public func upload<P: ResponseType>(_ request: UploadableRequest, decode type: P.Type) -> Promise<P> {
        let jsonDecoder = JSONDecoder(config: self.config.jsonDecoderConfig)
        let decoder = DataDecoder(type: type, jsonDecoder: jsonDecoder)
        return self
            .upload(request)
            .then(on: self.decodeQueue) { decoder.decode($0) }
    }
    
    @discardableResult
    public func upload(_ request: MultipartFormDataUploadRequest) -> Promise<HTTPResponse> {
        return RequestUploader(config: self.config)
            .upload(request, on: self.requestQueue)
            .recover(on: self.authorizeQueue, self.recover)
    }
    
    @discardableResult
    public func upload(_ request: MultipartFormDataUploadRequest) -> Promise<Data> {
        return RequestUploader(config: self.config)
            .upload(request, on: self.requestQueue)
            .recover(on: self.authorizeQueue, self.recover)
    }
    
    @discardableResult
    public func upload(_ request: MultipartFormDataUploadRequest) -> Promise<String> {
        return RequestUploader(config: self.config)
            .upload(request, on: self.requestQueue)
            .recover(on: self.authorizeQueue, self.recover)
    }
    
    @discardableResult
    public func upload<P: ResponseType>(_ request: MultipartFormDataUploadRequest, decode type: P.Type) -> Promise<P> {
        let jsonDecoder = JSONDecoder(config: self.config.jsonDecoderConfig)
        let decoder = DataDecoder(type: type, jsonDecoder: jsonDecoder)
        return self
            .upload(request)
            .then(on: self.decodeQueue) { decoder.decode($0) }
    }
}

// MARK: - Private Functions
extension CentralCoordinator {
    private func recover(_ error: Error) -> Promise<HTTPResponse> {
        guard self.isUnauthorizedError(error) else {
            return Promise(error: error)
        }
        guard let request = config.unauthorizedConfig?.reauthorizeRequest else {
            return Promise(error: error)
        }
        return RequestSender(config: self.config)
            .send(request, on: self.authorizeQueue)
    }
    
    private func recover(_ error: Error) -> Promise<Data> {
        guard self.isUnauthorizedError(error) else {
            return Promise(error: error)
        }
        guard let request = config.unauthorizedConfig?.reauthorizeRequest else {
            return Promise(error: error)
        }
        return RequestSender(config: self.config)
            .send(request, on: self.authorizeQueue)
    }
    
    private func recover(_ error: Error) -> Promise<String> {
        guard self.isUnauthorizedError(error) else {
            return Promise(error: error)
        }
        guard let request = config.unauthorizedConfig?.reauthorizeRequest else {
            return Promise(error: error)
        }
        return RequestSender(config: self.config)
            .send(request, on: self.authorizeQueue)
    }
    
    private func isUnauthorizedError(_ error: Error) -> Bool {
        guard let unauthorizedConfig = self.config.unauthorizedConfig else {
            return false
        }
        switch error {
        case let responseError as ResponseError:
            switch responseError {
            case .invalid(status: let status):
                if status == unauthorizedConfig.httpStatus {
                    return true
                }
            default:
                break
            }
        default:
            break
        }
        return false
    }
}
