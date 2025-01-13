import Foundation
import IssueReporting
import Dependencies
import Kamer_van_Koophandel_Shared
import Kamer_van_Koophandel_Models

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension Client {
    public static func live(
        makeRequest: @escaping @Sendable (_ route: API) throws -> URLRequest,
        session: @escaping @Sendable (URLRequest) async throws -> (Data, URLResponse) = { try await URLSession.shared.data(for: $0) }
    ) -> Self {
        Self(
            search: { kvkNummer, rsin, vestigingsnummer, naam, straatnaam, plaats, postcode, huisnummer, huisletter, postbusnummer, type, inclusiefInactieveRegistraties, pagina, resultatenPerPagina in
                try await handleRequest(
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
                    decodingTo: Zoeken.self,
                    session: session
                )
            }
        )
    }
}

extension Client {
    public static func live(
        baseURL: URL = URL(string: "https://api.kvk.nl")!,
        apiKey: String,
        session: @escaping @Sendable (URLRequest) async throws -> (Data, URLResponse) = { request in try await URLSession.shared.data(for: request)}
    ) -> AuthenticatedClient {
        
        @Dependency(API.Router.self) var router
        
        return AuthenticatedClient(
            baseURL: baseURL,
            kvkApiKey: apiKey,
            session: session,
            router: router
        ) { makeRequest in
            Client.live(
                makeRequest: makeRequest,
                session: session
            )
        }
    }
}

extension AuthenticatedClient {
    package static var liveTest: Self {
        try! AuthenticatedClient.test { .live(makeRequest: $0) }
    }
}
