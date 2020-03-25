import Foundation
import Alamofire

public struct HTTPResponse: CustomStringConvertible {
    public let url: URL?
    public let status: HTTPStatus
    public let headers: HTTPHeaders?
    public let body: Data?
    
    public init(response: HTTPURLResponse, body: Data? = nil, identifier: Identifiable) {
        self.url = response.url
        self.status = HTTPStatus(statusCode: response.statusCode)
        self.headers = response.allHeaderFields as? HTTPHeaders
        self.body = body
        self.print(by: identifier)
    }
    
    private func print(by identifier: Identifiable) {
        Printer.print(self, with: identifier)
    }
}

extension HTTPResponse {
    public var description: String {
        return "---------- HTTPResponse ----------" + "\n"
            + "URL: \(url?.absoluteString ?? "")" + "\n"
            + "Status: \(status)" + "\n"
            + "Headers: \(headers ?? [:])" + "\n"
            + "Body: \(body?.json ?? .null)" + "\n"
            + "------------------------------"
    }
}
