//
//  StatusCodeError.swift
//  Rocket
//
//  Created by 汤世昭 on 2019/10/8.
//  Copyright © 2019 苏打出行. All rights reserved.
//

import Foundation

struct StatusCodeError: Error {
    let statusCode: Int
    
    init(statusCode: Int) {
        self.statusCode = statusCode
    }
}
