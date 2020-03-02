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
    
    private init() {
        
    }
    
    public func setup(with config: Config) {
        self.config = config
    }
    
    @discardableResult
    public func request<R: RequestType, P: ResponseType>(
        _ request: R,
        decode type: P.Type,
        on queue: DispatchQueue? = nil
    ) -> Promise<P> {
        let decoder = DataDecoder(
            type: type,
            jsonDecoder: JSONDecoder(config: config.jsonDecoderConfig)
        )
        return self
            .request(request, on: queue)
            .compactMap { $0.body }
            .then { decoder.decode($0, on: queue) }
    }
    
    @discardableResult
    public func request<R: RequestType>(
        _ request: R,
        on queue: DispatchQueue? = nil
    ) -> Promise<HTTPResponse> {
        return PromiseKit
            .firstly { Printer.printAsync(request) }
            .then { _ in RequestSender.send(request, on: queue) }
            .then { Printer.printAsync($0) }
    }
    
    @discardableResult
    public func request<R: RequestType>(
        _ request: R,
        on queue: DispatchQueue? = nil
    ) -> Promise<Data> {
        return PromiseKit
            .firstly { Printer.printAsync(request) }
            .then { _ in RequestSender.send(request, on: queue) }
            .then { Printer.printAsync($0) }
    }
    
    @discardableResult
    public func request<R: RequestType>(
        _ request: R,
        on queue: DispatchQueue? = nil
    ) -> Promise<String> {
        return PromiseKit
            .firstly { Printer.printAsync(request) }
            .then { _ in RequestSender.send(request, on: queue) }
            .then { Printer.printAsync($0) }
    }
}
