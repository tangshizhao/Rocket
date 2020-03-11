import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit


// MARK: - Typealias
public typealias HTTPHeaders = Alamofire.HTTPHeaders
public typealias HTTPMethod = Alamofire.HTTPMethod
public typealias Parameters = Alamofire.Parameters
public typealias ParameterEncoding = Alamofire.ParameterEncoding
public typealias MultipartFormData = Alamofire.MultipartFormData
public typealias SessionManager = Alamofire.SessionManager
public typealias ServerTrustPolicy = Alamofire.ServerTrustPolicy
public typealias JSON = SwiftyJSON.JSON
public typealias Promise = PromiseKit.Promise


// MARK: - Config
public func setup(with config: Config) {
    CentralCoordinator.shared.setup(with: config)
}

// MARK: - Request
@discardableResult
public func request(_ request: RequestType) -> Promise<HTTPResponse> {
    return CentralCoordinator.shared.request(request)
}

@discardableResult
public func request(_ request: RequestType) -> Promise<Data> {
    return CentralCoordinator.shared.request(request)
}

@discardableResult
public func request(_ request: RequestType) -> Promise<String> {
    return CentralCoordinator.shared.request(request)
}

@discardableResult
public func request<P: ResponseType>(_ request: RequestType, decode type: P.Type) -> Promise<P> {
    return CentralCoordinator.shared.request(request, decode: type)
}

// MARK: - Upload
@discardableResult
public func upload(_ request: UploadableRequest) -> Promise<HTTPResponse> {
    return CentralCoordinator.shared.upload(request)
}

@discardableResult
public func upload(_ request: UploadableRequest) -> Promise<Data> {
    return CentralCoordinator.shared.upload(request)
}

@discardableResult
public func upload(_ request: UploadableRequest) -> Promise<String> {
    return CentralCoordinator.shared.upload(request)
}

@discardableResult
public func upload<P: ResponseType>(_ request: UploadableRequest, decode type: P.Type) -> Promise<P> {
    return CentralCoordinator.shared.upload(request, decode: type)
}

// MARK: - Multipart Form Data Upload
@discardableResult
public func upload(_ request: MultipartFormDataUploadRequest) -> Promise<HTTPResponse> {
    return CentralCoordinator.shared.upload(request)
}

@discardableResult
public func upload(_ request: MultipartFormDataUploadRequest) -> Promise<Data> {
    return CentralCoordinator.shared.upload(request)
}

@discardableResult
public func upload(_ request: MultipartFormDataUploadRequest) -> Promise<String> {
    return CentralCoordinator.shared.upload(request)
}

@discardableResult
public func upload<P: ResponseType>(_ request: MultipartFormDataUploadRequest, decode type: P.Type) -> Promise<P> {
    return CentralCoordinator.shared.upload(request, decode: type)
}

