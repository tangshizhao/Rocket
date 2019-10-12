import Foundation
import SwiftyJSON

extension Data: ResponseType {
    public var json: JSON {
        return JSON(self)
    }
}
