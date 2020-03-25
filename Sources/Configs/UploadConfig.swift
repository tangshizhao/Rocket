//
//  UploadConfig.swift
//  Rocket
//
//  Created by 王薰怡 on 2020/3/11.
//

import Foundation

public struct UploadConfig {
    
    public let encodingMemoryThreshold: UInt64
    
    public init(encodingMemoryThreshold: UInt64 = SessionManager.multipartFormDataEncodingMemoryThreshold) {
        self.encodingMemoryThreshold = encodingMemoryThreshold
    }
}
