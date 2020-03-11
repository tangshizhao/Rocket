import Foundation
import Alamofire

extension SessionManager {
    public convenience init(policyConfig: PolicyConfig? = nil) {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        if let policies = policyConfig?.policies {
            let policyManager = ServerTrustPolicyManager(policies: policies)
            self.init(configuration: configuration, serverTrustPolicyManager: policyManager)
        } else {
            self.init(configuration: configuration)
        }
    }
}
