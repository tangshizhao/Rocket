import Foundation
import PromiseKit

public struct Printer {
    
    public static var isEnable: Bool = true
    private static let queue: DispatchQueue = DispatchQueue.global(qos: .background)
    

    /// 打印请求对象
    /// - Parameter request: 请求对象
    public static func print(_ request: HTTPRequest, with identifier: Identifiable) {
        guard Printer.isEnable else {
            return
        }
        Printer.queue.async {
            Swift.print("\(identifier)")
            Swift.print("\(request)")
        }
    }
    
    /// 打印响应对象
    /// - Parameter request: 响应对象
    public static func print(_ response: HTTPResponse, with identifier: Identifiable) {
        guard Printer.isEnable else {
            return
        }
        Printer.queue.async {
            Swift.print("\(identifier)")
            Swift.print("\(response)")
        }
    }
    
    /// 打印JSON
    /// - Parameter request: 响应对象
    public static func print(_ json: JSON) {
        guard Printer.isEnable else {
            return
        }
        Printer.queue.async {
            Swift.print("\(json)")
        }
    }
    
    /// 打印JSON
    /// - Parameter request: 响应对象
    public static func print(_ string: String) {
        guard Printer.isEnable else {
            return
        }
        Printer.queue.async {
            Swift.print("\(string)")
        }
    }
}
