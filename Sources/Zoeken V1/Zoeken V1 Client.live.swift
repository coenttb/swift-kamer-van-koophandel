import Foundation
import IssueReporting
import Dependencies
import Kamer_van_Koophandel_Shared
import Kamer_van_Koophandel_Models
import Coenttb_Web

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension ClientV1 {
    public static func live(
        makeRequest: @escaping @Sendable (_ route: APIV1) throws -> URLRequest
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

extension ClientV1 {
    public static func live(
        apiKey: String
    ) -> AuthenticatedClientV1 {
        
        @Dependency(APIV1.Router.self) var router
        
        return AuthenticatedClientV1(
            kvkApiKey: apiKey,
            router: router
        ) { makeRequest in
            ClientV1.live(
                makeRequest: makeRequest
            )
        }
    }
}

extension AuthenticatedClientV1 {
    package static var liveTest: Self {
        try! AuthenticatedClientV1.test { .live(makeRequest: $0) }
    }
}
