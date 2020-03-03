//
//  SessionManager.swift
//  Rocket
//
//  Created by 汤世昭 on 2020/3/2.
//

import Foundation
import PromiseKit

public final class SessionManager {
    public static let shared: SessionManager = SessionManager()
    
    private var config: Config = Config.default
    
    private let requestQueue: DispatchQueue = DispatchQueue.global(qos: .userInteractive)
    private let decodeQueue: DispatchQueue = DispatchQueue.global(qos: .background)
    private let authorizeQueue: DispatchQueue = DispatchQueue.global(qos: .userInteractive)
    
    private init() {
        
    }
    
    public func setup(with config: Config) {
        self.config = config
    }
    
    @discardableResult
    public func request<P: ResponseType>(_ request: RequestType, decode type: P.Type) -> Promise<P> {
        let jsonDecoder = JSONDecoder(config: config.jsonDecoderConfig)
        let decoder = DataDecoder(type: type, jsonDecoder: jsonDecoder)
        return self
            .request(request)
            .then(on: decodeQueue) { decoder.decode($0) }
    }
    
    @discardableResult
    public func request(_ request: RequestType) -> Promise<Data> {
        return self
            .request(request)
            .compactMap { $0.body }
    }
    
    @discardableResult
    public func request(_ request: RequestType) -> Promise<HTTPResponse> {
        return RequestSender()
            .send(request, on: requestQueue)
            .recover(on: authorizeQueue, recover)
    }
    
    private func recover(_ error: Error) -> Promise<HTTPResponse> {
        guard isUnauthorizedError(error) else {
            return Promise(error: error)
        }
        guard let request = config.unauthorizedConfig?.reauthorizeRequest else {
            return Promise(error: error)
        }
        return RequestSender().send(request, on: authorizeQueue)
    }
    
    private func isUnauthorizedError(_ error: Error) -> Bool {
        guard let unauthorizedConfig = config.unauthorizedConfig else {
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
