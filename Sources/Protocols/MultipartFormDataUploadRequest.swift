import Foundation

public protocol MultipartFormDataUploadRequest: RequestType {
    var multipartFormData: (MultipartFormData) -> Void { get }
}
