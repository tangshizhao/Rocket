import Foundation
import Alamofire

extension DownloadRequest {
    public func fileUrlResponse(identifier: Identifiable, on queue: DispatchQueue? = nil) -> Promise<URL> {
        return Promise { (seal) in
            response(queue: queue) { (downloadResponse) in
                guard let httpUrlResponse = downloadResponse.response else {
                    seal.reject(ResponseError.noResponse)
                    return
                }
                let _ = HTTPResponse(
                    response: httpUrlResponse,
                    body: nil,
                    identifier: identifier
                )
                if let error = downloadResponse.error {
                    seal.reject(error)
                    return
                }
                guard let fileUrl = downloadResponse.destinationURL else {
                    if let temporaryUrl = downloadResponse.temporaryURL {
                        seal.fulfill(temporaryUrl)
                        return
                    }
                    seal.reject(ResponseError.downloadedUrlMissing)
                    return
                }
                seal.fulfill(fileUrl)
            }
        }
    }
    
    public func responseData(identifier: Identifiable, on queue: DispatchQueue? = nil) -> Promise<Data> {
        return Promise { (seal) in
            responseData(queue: queue) { (downloadResponse) in
                guard let httpUrlResponse = downloadResponse.response else {
                    seal.reject(ResponseError.noResponse)
                    return
                }
                let _ = HTTPResponse(
                    response: httpUrlResponse,
                    body: downloadResponse.value,
                    identifier: identifier
                )
                switch downloadResponse.result {
                case .success(let data):
                    seal.fulfill(data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    public func httpResponse(identifier: Identifiable, on queue: DispatchQueue? = nil) -> Promise<HTTPResponse> {
        return Promise { (seal) in
            response(queue: queue) { (downloadResponse) in
                guard let httpUrlResponse = downloadResponse.response else {
                    seal.reject(ResponseError.noResponse)
                    return
                }
                let response = HTTPResponse(
                    response: httpUrlResponse,
                    body: nil,
                    identifier: identifier
                )
                if let error = downloadResponse.error {
                    seal.reject(error)
                    return
                }
                seal.fulfill(response)
            }
        }
    }
}
