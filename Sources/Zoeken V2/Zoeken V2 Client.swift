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
    public var search: @Sendable (
        _ kvkNummer: Kamer_van_Koophandel_Models.Number?,
        _ rsin: String?,
        _ vestigingsnummer: String?,
        _ naam: String?,
        _ straatnaam: String?,
        _ plaats: String?,
        _ postcode: String?,
        _ huisnummer: Int?,
        _ huisletter: String?,
        _ postbusnummer: Int?,
        _ type: [String]?,
        _ inclusiefInactieveRegistraties: Bool?,
        _ pagina: Int?,
        _ resultatenPerPagina: Int?
    ) async throws -> Zoeken
}

public typealias AuthenticatedClient = _KvKAuthenticatedClient<
    API,
    API.Router,
    Client
>
