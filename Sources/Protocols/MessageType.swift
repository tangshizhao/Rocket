import Foundation

// MARK: - Protocol
public protocol MessageType: Codable, CustomStringConvertible {
    associatedtype Code: Hashable
    var code: Code { get }
    var content: String { get }
}

// MARK: - CustomStringConvertible
extension MessageType {
    public var description: String {
        return "---------- Message ----------" + "\n"
            + "Code: \(code)"  + "\n"
            + "Content: \(content)" + "\n"
            + "-----------------------------"
    }
}
