import Dependencies
@testable import Basisprofielen
@testable import Kamer_van_Koophandel_Models
@testable import Kamer_van_Koophandel_Shared


#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension Basisprofielen.AuthenticatedClient: @retroactive TestDependencyKey {
    public static var testValue: Self {
        @Dependency(TestStrategy.self) var testStrategy
        
        return switch testStrategy {
        case .local:
            try! Basisprofielen.AuthenticatedClient.test { Basisprofielen.Client.testValue }
        case .liveTest:
            try! Basisprofielen.AuthenticatedClient.test { Basisprofielen.Client.live(makeRequest: $0) }
        case .live:
            try! Basisprofielen.AuthenticatedClient.test { Basisprofielen.Client.live(makeRequest: $0) }
        }
    }
}
