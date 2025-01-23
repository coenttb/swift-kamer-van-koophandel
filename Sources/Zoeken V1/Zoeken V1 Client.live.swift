import Foundation
import IssueReporting
import Dependencies
import Kamer_van_Koophandel_Shared
import Kamer_van_Koophandel_Models
import Coenttb_Web

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension Client {
    public static func live(
        makeRequest: @escaping @Sendable (_ route: Zoeken_V1.API) throws -> URLRequest
    ) -> Self {
        @Dependency(URLRequest.Handler.self) var handleRequest
        
        return Self(
            search: { kvkNummer, rsin, vestigingsnummer, handelsnaam, straatnaam, plaats, postcode, huisnummer, huisnummerToevoeging, type, inclusiefInactieveRegistraties, pagina, aantal in
                try await handleRequest(
                    for: makeRequest(
                        .search(
                            kvkNummer: kvkNummer,
                            rsin: rsin,
                            vestigingsnummer: vestigingsnummer,
                            handelsnaam: handelsnaam,
                            straatnaam: straatnaam,
                            plaats: plaats,
                            postcode: postcode,
                            huisnummer: huisnummer,
                            huisnummerToevoeging: huisnummerToevoeging,
                            type: type,
                            inclusiefInactieveRegistraties: inclusiefInactieveRegistraties,
                            pagina: pagina,
                            aantal: aantal
                        )
                    ),
                    decodingTo: ZoekenV1.self
                )
            }
        )
    }
}

extension Client {
    public static func live(
        apiKey: String
    ) -> AuthenticatedClient {
        
        @Dependency(Zoeken_V1.API.Router.self) var router
        
        return AuthenticatedClient(
            kvkApiKey: apiKey,
            router: router
        ) { makeRequest in
            Zoeken_V1.Client.live(
                makeRequest: makeRequest
            )
        }
    }
}

extension Zoeken_V1.AuthenticatedClient {
    package static var liveTest: Self {
        try! Zoeken_V1.AuthenticatedClient.test { .live(makeRequest: $0) }
    }
}
