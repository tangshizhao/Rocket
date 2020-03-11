import Foundation
import Alamofire

public struct PolicyConfig {
    
    public let policies: [String: ServerTrustPolicy]
    
    public init(policies: [String: ServerTrustPolicy]) {
        self.policies = policies
    }
}
