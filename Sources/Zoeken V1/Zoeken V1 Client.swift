import DependenciesMacros
import Foundation
import Kamer_van_Koophandel_Models
import Kamer_van_Koophandel_Shared

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

@DependencyClient
public struct Client: Sendable {
  @DependencyEndpoint
  public var search:
    @Sendable (
      _ kvkNummer: Kamer_van_Koophandel_Models.Number?,
      _ rsin: String?,
      _ vestigingsnummer: String?,
      _ handelsnaam: String?,
      _ straatnaam: String?,
      _ plaats: String?,
      _ postcode: String?,
      _ huisnummer: Int?,
      _ huisnummerToevoeging: String?,
      _ type: String?,
      _ inclusiefInactieveRegistraties: Bool?,
      _ pagina: Int?,
      _ aantal: Int?
    ) async throws -> ZoekenV1
}

public typealias AuthenticatedClient = Kamer_van_Koophandel_Shared.AuthenticatedClient<
  Zoeken_V1.API,
  Zoeken_V1.API.Router,
  Zoeken_V1.Client
>
