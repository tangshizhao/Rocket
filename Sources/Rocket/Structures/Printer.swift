import Foundation
import PromiseKit

public struct Printer {
    
    public let isEnable: Bool
    
    public init(isEnable: Bool) {
        self.isEnable = isEnable
    }
    
    /// 打印请求对象
    /// - Parameter request: 请求对象
    public func print(_ request: RequestType) {
        if isEnable {
            Swift.print("\(request)")
        }
    }
    
    /// 打印响应对象
    /// - Parameter request: 响应对象
    public func print(_ response: HTTPResponse) {
        if isEnable {
            Swift.print("\(response)")
        }
    }
    
    /// 异步打印请求对象
    /// - Parameter request: 请求对象
    public func printAsync(_ request: RequestType) -> Guarantee<Void> {
        return Guarantee { (seal) in
            self.print(request)
            seal(())
        }
    }
    
    /// 异步打印响应对象
    /// - Parameter request: 响应对象
    public func printAsync(_ response: HTTPResponse) -> Guarantee<Void> {
        return Guarantee { (seal) in
            self.print(response)
            seal(())
        }
    }
}
