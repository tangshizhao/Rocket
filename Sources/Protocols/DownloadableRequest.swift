import Foundation

public protocol DownloadableRequest: RequestType {
    var destination: DownloadRequest.DownloadFileDestination { get }
}
