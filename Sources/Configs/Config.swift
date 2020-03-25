//
//  Config.swift
//  Rocket
//
//  Created by 汤世昭 on 2020/3/2.
//

import Foundation

public struct Config {
    
    public static let `default`: Config = Config()
    
    
    public let jsonDecoderConfig: JSONDecoderConfig
    public let unauthorizedConfig: UnauthorizationConfig?
    public let policyConfig: PolicyConfig?
    public let uploadConfig: UploadConfig
    public let validationConfig: ValidationConfig?
    
    public init(jsonDecoderConfig: JSONDecoderConfig = JSONDecoderConfig.default,
                unauthorizedConfig: UnauthorizationConfig? = nil,
                policyConfig: PolicyConfig? = nil,
                uploadConfig: UploadConfig = UploadConfig(),
                validationConfig: ValidationConfig? = nil) {
        self.jsonDecoderConfig = jsonDecoderConfig
        self.unauthorizedConfig = unauthorizedConfig
        self.policyConfig = policyConfig
        self.uploadConfig = uploadConfig
        self.validationConfig = validationConfig
    }
}
