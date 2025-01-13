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
        Self.init(
            basisprofiel: .live(
                makeRequest: { try makeRequest(.basisprofiel($0)) },
                session: session
            ),
            naamgeving: .live(
                makeRequest: { try makeRequest(.naamgeving($0)) },
                session: session
            ),
            vestigingsprofiel: .live(
                makeRequest: { try makeRequest(.vestigingsprofiel($0)) },
                session: session
            ),
            zoeken: .init(
                v1: .live(
                    makeRequest: { try makeRequest(.zoeken(.v1($0))) },
                    session: session
                ),
                v2: .live(
                    makeRequest: { try makeRequest(.zoeken(.v2($0))) },
                    session: session
                )
            )
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
