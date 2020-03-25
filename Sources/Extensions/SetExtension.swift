import Foundation
import SwiftyJSON

extension Set: ResponseType where Element: ResponseType {
    public var json: JSON {
        return JSON(self)
    }
}
