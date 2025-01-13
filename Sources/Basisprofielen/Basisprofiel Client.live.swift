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
            get: { kvkNummer, geoData in
                try await handleRequest(
                    for: makeRequest(.get(kvkNummer: kvkNummer, geoData: geoData)),
                    decodingTo: Basisprofiel.self,
                    session: session
                )
            },
            getEigenaar: { kvkNummer, geoData in
                try await handleRequest(
                    for: makeRequest(.getEigenaar(kvkNummer: kvkNummer, geoData: geoData)),
                    decodingTo: Basisprofiel.Eigenaar.self,
                    session: session
                )
            },
            getHoofdvestiging: { kvkNummer, geoData in
                try await handleRequest(
                    for: makeRequest(.getHoofdvestiging(kvkNummer: kvkNummer, geoData: geoData)),
                    decodingTo: Basisprofiel.Vestiging.self,
                    session: session
                )
            },
            getVestigingen: { kvkNummer in
                try await handleRequest(
                    for: makeRequest(.getVestigingen(kvkNummer: kvkNummer)),
                    decodingTo: VestigingList.self,
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
