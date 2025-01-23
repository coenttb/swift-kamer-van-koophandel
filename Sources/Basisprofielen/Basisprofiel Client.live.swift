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
        makeRequest: @escaping @Sendable (_ route: API) throws -> URLRequest
    ) -> Self {

        @Dependency(URLRequest.Handler.self) var handleRequest
        
        return Self(
            get: { kvkNummer, geoData in
                try await handleRequest(
                    for: makeRequest(.get(kvkNummer: kvkNummer, geoData: geoData)),
                    decodingTo: Basisprofiel.self
                )
            },
            getEigenaar: { kvkNummer, geoData in
                try await handleRequest(
                    for: makeRequest(.getEigenaar(kvkNummer: kvkNummer, geoData: geoData)),
                    decodingTo: Basisprofiel.Eigenaar.self
                )
            },
            getHoofdvestiging: { kvkNummer, geoData in
                try await handleRequest(
                    for: makeRequest(.getHoofdvestiging(kvkNummer: kvkNummer, geoData: geoData)),
                    decodingTo: Basisprofiel.Vestiging.self
                )
            },
            getVestigingen: { kvkNummer in
                try await handleRequest(
                    for: makeRequest(.getVestigingen(kvkNummer: kvkNummer)),
                    decodingTo: VestigingList.self
                )
            }
        )
    }
}

extension Client {
    public static func live(
        apiKey: String
    ) -> AuthenticatedClient {
        @Dependency(\.defaultSession) var session
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
