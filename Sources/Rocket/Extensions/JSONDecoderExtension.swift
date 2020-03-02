//
//  JSONDecoderExtension.swift
//  Rocket
//
//  Created by 汤世昭 on 2020/3/2.
//

import Foundation

extension JSONDecoder {
    convenience init(config: JSONDecoderConfig) {
        self.init()
        self.dateDecodingStrategy = config.dateDecodingStrategy
        self.dataDecodingStrategy = config.dataDecodingStrategy
        self.nonConformingFloatDecodingStrategy = config.nonConformingFloatDecodingStrategy
        self.keyDecodingStrategy = config.keyDecodingStrategy
        self.userInfo = config.userInfo
    }
}
