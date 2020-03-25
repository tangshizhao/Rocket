//
//  ResponseError.swift
//  Rocket
//
//  Created by 汤世昭 on 2019/9/26.
//  Copyright © 2019 苏打出行. All rights reserved.
//

import Foundation

public enum ResponseError: Error {
    case noResponse
    case timeout
    case invalid(status: HTTPStatus)
    case downloadedUrlMissing
}
