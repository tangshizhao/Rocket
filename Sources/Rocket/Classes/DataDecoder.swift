//
//  DataDecoder.swift
//  Alamofire
//
//  Created by 汤世昭 on 2020/3/2.
//

import Foundation
import PromiseKit

public struct DataDecoder<P: ResponseType> {
    
    public let jsonDecoder: JSONDecoder
    public let type: P.Type
    
    public init(type: P.Type, jsonDecoder: JSONDecoder) {
        self.type = type
        self.jsonDecoder = jsonDecoder
    }
    
    public func decode(_ data: Data) -> Promise<P> {
        if let response = data as? P {
            return Promise.value(response)
        }
        do {
            let response = try jsonDecoder.decode(type, from: data)
            return Promise.value(response)
        } catch {
            return Promise(error: error)
        }
    }
}
