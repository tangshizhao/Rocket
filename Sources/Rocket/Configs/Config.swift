//
//  Config.swift
//  Alamofire
//
//  Created by 汤世昭 on 2020/3/2.
//

import Foundation

public final class Config {
    
    public static let `default`: Config = Config()
    
    public let jsonDecoderConfig: JSONDecoderConfig
    public let unauthorizedConfig: UnauthorizationConfig?
    
    public init(jsonDecoderConfig: JSONDecoderConfig = JSONDecoderConfig.default,
                unauthorizedConfig: UnauthorizationConfig? = nil) {
        self.jsonDecoderConfig = jsonDecoderConfig
        self.unauthorizedConfig = unauthorizedConfig
    }
}
