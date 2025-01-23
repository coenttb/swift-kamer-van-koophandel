import Foundation
import Dependencies
import DependenciesMacros
import Kamer_van_Koophandel_Models
import Kamer_van_Koophandel_Shared

import Basisprofielen
import Naamgevingen
import Vestigingsprofielen
import Zoeken_V1
import Zoeken_V2

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

@DependencyClient
public struct Client: Sendable {
    public let basisprofiel: Basisprofielen.Client
    public let naamgeving: Naamgevingen.Client
    public let vestigingsprofiel: Vestigingsprofielen.Client
    public let zoeken: Client.Zoeken
}

extension Client {
    @dynamicMemberLookup
    public struct Zoeken: Sendable {
        public let v1: Zoeken_V1.Client
        public let v2: Zoeken_V2.Client
        
        public init(
            v1: Zoeken_V1.Client,
            v2: Zoeken_V2.Client
        ) {
            self.v1 = v1
            self.v2 = v2
        }
        
        public subscript<T>(dynamicMember keyPath: KeyPath<Zoeken_V2.Client, T?>) -> T? {
            v2[keyPath: keyPath]
        }
    }
}

public typealias AuthenticatedClient = Kamer_van_Koophandel_Shared.AuthenticatedClient<
    API,
    API.Router,
    Client
>

