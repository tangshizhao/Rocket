//
//  JSONDecoderConfig.swift
//  Rocket
//
//  Created by 汤世昭 on 2020/3/2.
//

import Foundation


/// A  configurable struct to wrap the config of class `JSONDecoder `
public struct JSONDecoderConfig {
    
    public static let `default`: JSONDecoderConfig = JSONDecoderConfig()
    
    public let dateDecodingStrategy: JSONDecoder.DateDecodingStrategy
    public let dataDecodingStrategy: JSONDecoder.DataDecodingStrategy
    public let nonConformingFloatDecodingStrategy: JSONDecoder.NonConformingFloatDecodingStrategy
    public let keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy
    public let userInfo: [CodingUserInfoKey : Any]
        
    public init(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .base64,
                nonConformingFloatDecodingStrategy: JSONDecoder.NonConformingFloatDecodingStrategy = .throw,
                keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                userInfo: [CodingUserInfoKey : Any] = [:]) {
        self.dateDecodingStrategy = dateDecodingStrategy
        self.dataDecodingStrategy = dataDecodingStrategy
        self.nonConformingFloatDecodingStrategy = nonConformingFloatDecodingStrategy
        self.keyDecodingStrategy = keyDecodingStrategy
        self.userInfo = userInfo
    }
}
