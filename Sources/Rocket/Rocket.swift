import Foundation
import PromiseKit

public struct Rocket {
    
    public let requestSender: RequestSender = RequestSender()
    public let jsonDecoder: JSONDecoder
    public let printer: Printer
    
    public init(jsonDecoder: JSONDecoder, isPrintEnable: Bool) {
        self.jsonDecoder = jsonDecoder
        self.printer = Printer(isEnable: isPrintEnable)
    }
    
    /// Send the specifiied request and decode to desire type
    /// - Parameter request: The request object to describe a HTTP request.
    /// - Parameter type: The desire type which is goint to decode.
    /// - Parameter queue: Decodeed queue, if the passing queue is nil, json decoder will decode on main queue.
    @discardableResult
    public func send<R: RequestType, P: ResponseType>(_ request: R,
                                                      decode type: P.Type,
                                                      on queue: DispatchQueue? = nil) -> Promise<P> {
        return PromiseKit
            .firstly { self.printer.printAsync(request) }
            .then { self.requestSender.send(request, on: queue) }
            .get { self.printer.print($0) }
            .compactMap { $0.body }
            .then(on: queue) { self.decode($0, with: type) }
    }
    
    /// Decode desire type wrapped in a promise
    /// - Parameter data: The data value which is decding from.
    /// - Parameter type: The desire type which is decding to.
    private func decode<P: ResponseType>(_ data: Data, with type: P.Type) -> Promise<P> {
        if let response = data as? P {
            return Promise.value(response)
        }
        do {
            let response = try jsonDecoder.decode(type, from: data)
            return Promise.value(response)
        } catch {
            return Promise(error: error)
        }
    }
}
