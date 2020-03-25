import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

extension DataRequest {
    
    /// 异步返回请求响应的HTTPResponse
    /// - Parameter queue: 响应处理的队列
    public func httpResponse(identifier: Identifiable, on queue: DispatchQueue? = nil) -> Promise<HTTPResponse> {
        return Promise { (seal) in
            response(queue: queue) { (dataResponse) in
                guard let httpUrlResponse = dataResponse.response else {
                    seal.reject(ResponseError.noResponse)
                    return
                }
                let response = HTTPResponse(
                    response: httpUrlResponse,
                    body: dataResponse.data,
                    identifier: identifier
                )
                seal.fulfill(response)
            }
        }
    }
    
    /// 异步返回请求响应的Data
    /// - Parameter queue: 响应处理的队列
    public func responseData(identifier: Identifiable, on queue: DispatchQueue? = nil) -> Promise<Data> {
        return Promise { (seal) in
            responseData(queue: queue) { (dataResponse) in
                guard let httpUrlResponse = dataResponse.response else {
                    seal.reject(ResponseError.noResponse)
                    return
                }
                let _ = HTTPResponse(
                    response: httpUrlResponse,
                    body: dataResponse.data,
                    identifier: identifier
                )
                switch dataResponse.result {
                case .success(let value):
                    seal.fulfill(value)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    /// 异步返回请求响应的String
    /// - Parameter queue: 响应处理的队列
    /// - Parameter encoding: 字符串编码
    public func responseString(identifier: Identifiable, on queue: DispatchQueue? = nil, encoding: String.Encoding = .utf8) -> Promise<String> {
        return Promise { (seal) in
            responseString(queue: queue, encoding: encoding) { (dataResponse) in
                guard let httpUrlResponse = dataResponse.response else {
                    seal.reject(ResponseError.noResponse)
                    return
                }
                let _ = HTTPResponse(
                    response: httpUrlResponse,
                    body: dataResponse.data,
                    identifier: identifier
                )
                switch dataResponse.result {
                case .success(let value):
                    seal.fulfill(value)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
}
