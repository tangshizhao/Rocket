import Foundation

public enum UploadObject {
    case fileURL(URL)
    case data(Data)
    case inputStream(InputStream)
}
