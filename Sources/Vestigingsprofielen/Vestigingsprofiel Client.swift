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
  public var get:
    @Sendable (
      _ vestigingsnummer: String,
      _ geoData: Bool?
    ) async throws -> Vestigingsprofiel
}

public typealias AuthenticatedClient = Kamer_van_Koophandel_Shared.AuthenticatedClient<
  API,
  API.Router,
  Client
>
