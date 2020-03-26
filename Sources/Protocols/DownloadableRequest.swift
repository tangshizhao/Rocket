import Foundation

public protocol DownloadableRequest {
    var urlString: String { get }
    var destination: DownloadRequest.DownloadFileDestination { get }
}

