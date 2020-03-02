import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

public final class RequestSender {
    
    /// 发送请求并异步返回HTTPResponse对象
    ///
    /// - Parameters:
    ///   - request: 请求对象
    ///   - queue: 响应解析队列
    /// - Returns: 包含Data的Promise对象
    @discardableResult
    public class func send<R: RequestType>(
        _ request: R,
        on queue: DispatchQueue? = nil
    ) -> Promise<HTTPResponse> {
        return Alamofire
            .request(request)
            .httpResponse(on: queue)
    }
    
    /// 发送请求并异步返回Data对象
    ///
    /// - Parameters:
    ///   - request: 请求对象
    ///   - queue: 响应解析队列
    /// - Returns: 包含Data的Promise对象
    @discardableResult
    public class func send<R: RequestType>(
        _ request: R,
        on queue: DispatchQueue? = nil
    ) -> Promise<Data> {
        return Alamofire
            .request(request)
            .responseData(on: queue)
    }
    
    /// 发送请求并异步返回String对象
    ///
    /// - Parameters:
    ///   - request: 请求对象
    ///   - queue: 响应解析队列
    /// - Returns: 包含String的Promise对象
    @discardableResult
    public class func send<R: RequestType>(
        _ request: R,
        on queue: DispatchQueue? = nil
    ) -> Promise<String> {
        return Alamofire
            .request(request)
            .responseString(on: queue)
    }
}
