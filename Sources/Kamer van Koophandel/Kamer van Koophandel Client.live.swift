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
        return Self.init(
            basisprofiel: .live(
                makeRequest: { try makeRequest(.basisprofiel($0)) }
            ),
            naamgeving: .live(
                makeRequest: { try makeRequest(.naamgeving($0)) }
            ),
            vestigingsprofiel: .live(
                makeRequest: { try makeRequest(.vestigingsprofiel($0)) }
            ),
            zoeken: .init(
                v1: .live(
                    makeRequest: { try makeRequest(.zoeken(.v1($0))) }
                ),
                v2: .live(
                    makeRequest: { try makeRequest(.zoeken(.v2($0))) }
                )
            )
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
