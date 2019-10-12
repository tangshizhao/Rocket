import Foundation
import Alamofire

public struct HTTPResponse: CustomStringConvertible {
    public let url: URL?
    public let status: HTTPStatus
    public let headers: HTTPHeaders?
    public let body: Data?
    
    public init(response: HTTPURLResponse, body: Data? = nil) {
        self.url = response.url
        self.status = HTTPStatus(statusCode: response.statusCode)
        self.headers = response.allHeaderFields as? HTTPHeaders
        self.body = body
    }
}

extension HTTPResponse {
    public var description: String {
        return "---------- Response ----------" + "\n"
            + "URL: \(url?.absoluteString ?? "")" + "\n"
            + "Status: \(status)" + "\n"
            + "Headers: \(headers ?? [:])" + "\n"
            + "Body: \(body?.json ?? .null)" + "\n"
            + "------------------------------"
    }
}
