import Foundation
import PromiseKit

public struct Printer {
    
    public static var isEnable: Bool = true
    
    /// 打印请求对象
    /// - Parameter request: 请求对象
    public static func print(_ request: RequestType) {
        if Printer.isEnable {
            Swift.print("\(request)")
        }
    }
    
    /// 打印响应对象
    /// - Parameter request: 响应对象
    public static func print(_ response: HTTPResponse) {
        if Printer.isEnable {
            Swift.print("\(response)")
        }
    }
    
    /// 打印JSON
    /// - Parameter request: 响应对象
    public static func print(_ json: JSON) {
        if Printer.isEnable {
            Swift.print("\(json)")
        }
    }
    
    /// 打印Data
    /// - Parameter request: 响应对象
    public static func print(_ data: Data) {
        Printer.print(JSON(data))
    }
    
    /// 打印JSON
    /// - Parameter request: 响应对象
    public static func print(_ string: String) {
        if Printer.isEnable {
            Swift.print("\(string)")
        }
    }
    
    /// 异步打印请求对象
    /// - Parameter request: 请求对象
    public static func printAsync(_ request: RequestType) -> Guarantee<RequestType> {
        return Guarantee { (seal) in
            Printer.print(request)
            seal(request)
        }
    }
    
    /// 异步打印响应对象
    /// - Parameter request: 响应对象
    public static func printAsync(_ response: HTTPResponse) -> Guarantee<HTTPResponse> {
        return Guarantee { (seal) in
            Printer.print(response)
            seal(response)
        }
    }
    
    /// 异步打印JSON
    /// - Parameter request: 响应对象
    public static func printAsync(_ json: JSON) -> Guarantee<JSON> {
        return Guarantee { (seal) in
            Printer.print(json)
            seal(json)
        }
    }
    
    /// 异步打印Data
    /// - Parameter request: 响应对象
    public static func printAsync(_ data: Data) -> Guarantee<Data> {
        return Guarantee { (seal) in
            Printer.print(data)
            seal(data)
        }
    }
    
    /// 异步打印Data
    /// - Parameter request: 响应对象
    public static func printAsync(_ string: String) -> Guarantee<String> {
        return Guarantee { (seal) in
            Printer.print(string)
            seal(string)
        }
    }
}
