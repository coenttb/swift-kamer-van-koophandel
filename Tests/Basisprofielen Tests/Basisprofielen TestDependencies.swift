import Dependencies
@testable import Basisprofiel
@testable import Kamer_van_Koophandel_Models
@testable import Kamer_van_Koophandel_Shared

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension AuthenticatedClient: @retroactive TestDependencyKey {
    public static var testValue: Self {
        @Dependency(TestStrategy.self) var testStrategy
        
        return switch testStrategy {
        case .local:
            try! AuthenticatedClient.test { Client.testValue }
        case .liveTest:
            try! AuthenticatedClient.test { Client.live(makeRequest: $0) }
        case .live:
            try! AuthenticatedClient.test { Client.live(makeRequest: $0) }
        }
    }
}
