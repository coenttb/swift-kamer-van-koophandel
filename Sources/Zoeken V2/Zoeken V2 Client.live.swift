import Coenttb_Web
import Dependencies
import Foundation
import IssueReporting
import Kamer_van_Koophandel_Models
import Kamer_van_Koophandel_Shared

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

extension Client {
  public static func live(
    makeRequest: @escaping @Sendable (_ route: API) throws -> URLRequest
  ) -> Self {
    Self(
      search: {
        kvkNummer,
        rsin,
        vestigingsnummer,
        naam,
        straatnaam,
        plaats,
        postcode,
        huisnummer,
        huisletter,
        postbusnummer,
        type,
        inclusiefInactieveRegistraties,
        pagina,
        resultatenPerPagina in

        @Dependency(URLRequest.Handler.self) var handleRequest
        return try await handleRequest(
          for: makeRequest(
            .search(
              kvkNummer: kvkNummer,
              rsin: rsin,
              vestigingsnummer: vestigingsnummer,
              naam: naam,
              straatnaam: straatnaam,
              plaats: plaats,
              postcode: postcode,
              huisnummer: huisnummer,
              huisletter: huisletter,
              postbusnummer: postbusnummer,
              type: type,
              inclusiefInactieveRegistraties: inclusiefInactieveRegistraties,
              pagina: pagina,
              resultatenPerPagina: resultatenPerPagina
            )
          ),
          decodingTo: Zoeken.self
        )
      }
    )
  }
}

extension Client {
  public static func live(
    apiKey: String
  ) -> AuthenticatedClient {

    @Dependency(API.Router.self) var router

    return AuthenticatedClient(
      kvkApiKey: apiKey,
      router: router
    ) { makeRequest in
      Client.live(
        makeRequest: makeRequest
      )
    }
  }
}

extension AuthenticatedClient {
  package static var liveTest: Self {
    try! AuthenticatedClient.test { .live(makeRequest: $0) }
  }
}
