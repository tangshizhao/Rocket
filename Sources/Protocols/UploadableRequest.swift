import Foundation

public protocol UploadableRequest: RequestType {
    var uploadObject: UploadObject { get }
}
