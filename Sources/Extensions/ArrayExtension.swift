import Foundation
import SwiftyJSON

extension Array: ResponseType where Element: ResponseType {
    public var json: JSON {
        return JSON(self)
    }
}
