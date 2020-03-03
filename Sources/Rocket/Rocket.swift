import Foundation
import PromiseKit
import Alamofire

public func setup(with config: Config) {
    SessionManager.shared.setup(with: config)
}

@discardableResult
public func send<P: ResponseType>(_ request: RequestType, decode type: P.Type) -> Promise<P> {
    return SessionManager.shared.request(request, decode: type)
}

@discardableResult
public func send(_ request: RequestType) -> Promise<Data> {
    return SessionManager.shared.request(request)
}

@discardableResult
public func send(_ request: RequestType) -> Promise<HTTPResponse> {
    return SessionManager.shared.request(request)
}



