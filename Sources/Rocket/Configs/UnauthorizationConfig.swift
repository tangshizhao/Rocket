//
//  UnauthorizationConfig.swift
//  Alamofire
//
//  Created by 汤世昭 on 2020/3/2.
//

import Foundation

public final class UnauthorizationConfig {
    
    public let httpStatus: HTTPStatus
    public let retryCount: Int
    public let isConcurrent: Bool
    public let reauthorizeRequest: RequestType
    
    public init(httpStatus: HTTPStatus = .unauthorized,
                retryCount: Int = 1,
                isConcurrent: Bool = false,
                reauthorizeRequest: RequestType) {
        self.httpStatus = httpStatus
        self.retryCount = retryCount
        self.isConcurrent = isConcurrent
        self.reauthorizeRequest = reauthorizeRequest
    }
}
