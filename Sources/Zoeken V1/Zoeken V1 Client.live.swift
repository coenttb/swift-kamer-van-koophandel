import Foundation
import IssueReporting
import Dependencies
import Kamer_van_Koophandel_Shared
import Kamer_van_Koophandel_Models

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension ClientV1 {
    public static func live(
        makeRequest: @escaping @Sendable (_ route: APIV1) throws -> URLRequest,
        session: @escaping @Sendable (URLRequest) async throws -> (Data, URLResponse) = { try await URLSession.shared.data(for: $0) }
    ) -> Self {
        Self(
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
                    decodingTo: ZoekenV1.self,
                    session: session
                )
            }
        )
    }
}

extension ClientV1 {
    public static func live(
        baseURL: URL = URL(string: "https://api.kvk.nl")!,
        apiKey: String,
        session: @escaping @Sendable (URLRequest) async throws -> (Data, URLResponse) = { request in try await URLSession.shared.data(for: request)}
    ) -> AuthenticatedClientV1 {
        
        @Dependency(APIV1.Router.self) var router
        
        return AuthenticatedClientV1(
            baseURL: baseURL,
            kvkApiKey: apiKey,
            session: session,
            router: router
        ) { makeRequest in
            ClientV1.live(
                makeRequest: makeRequest,
                session: session
            )
        }
    }
}

extension AuthenticatedClientV1 {
    package static var liveTest: Self {
        try! AuthenticatedClientV1.test { .live(makeRequest: $0) }
    }
}
