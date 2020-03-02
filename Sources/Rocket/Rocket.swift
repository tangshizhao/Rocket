import Foundation
import PromiseKit
import Alamofire

public func setup(with config: Config) {
    SessionManager.shared.setup(with: config)
}

@discardableResult
public func send<R: RequestType, P: ResponseType>(
    _ request: R,
    decode type: P.Type,
    on queue: DispatchQueue? = nil
) -> Promise<P> {
    return SessionManager.shared.request(request, decode: type, on: queue)
}


@discardableResult
public func send<R: RequestType>(
    _ request: R,
    on queue: DispatchQueue? = nil
) -> Promise<Data> {
    return SessionManager.shared.request(request, on: queue)
}

@discardableResult
public func send<R: RequestType>(
    _ request: R,
    on queue: DispatchQueue? = nil
) -> Promise<HTTPResponse> {
    return SessionManager.shared.request(request, on: queue)
}

