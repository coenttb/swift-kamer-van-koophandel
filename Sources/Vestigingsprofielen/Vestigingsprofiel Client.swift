import Foundation
import DependenciesMacros
import Kamer_van_Koophandel_Models
import Kamer_van_Koophandel_Shared

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

@DependencyClient
public struct Client: Sendable {
    @DependencyEndpoint
    public var get: @Sendable (
        _ vestigingsnummer: String,
        _ geoData: Bool?
    ) async throws -> Vestigingsprofiel
}

public typealias AuthenticatedClient = _KvKAuthenticatedClient<
    API,
    API.Router,
    Client
>
