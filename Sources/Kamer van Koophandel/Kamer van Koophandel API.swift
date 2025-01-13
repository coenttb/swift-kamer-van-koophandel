import Foundation
import URLRouting
import UrlFormCoding
import Dependencies
import Kamer_van_Koophandel_Shared
import Kamer_van_Koophandel_Models

import Zoeken_V1
import Zoeken_V2
import Vestigingsprofielen
import Naamgevingen
import Basisprofielen

public enum API: Equatable, Sendable {
    case basisprofiel(Basisprofielen.API)
    case naamgeving(Naamgevingen.API)
    case vestigingsprofiel(Vestigingsprofielen.API)
    case zoeken(API.Zoeken)
}

extension API {
    public enum Zoeken: Equatable, Sendable {
        case v1(Zoeken_V1.APIV1)
        case v2(Zoeken_V2.API)
    }
}

extension API {
    public static func zoeken(_ zoeken: Zoeken_V2.API) -> Self {
        .zoeken(.v2(zoeken))
    }
}

extension API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}
        
        public var body: some URLRouting.Router<API> {
            OneOf {
                URLRouting.Route(.case(API.basisprofiel)) {
                    Basisprofielen.API.Router()
                }
                URLRouting.Route(.case(API.naamgeving)) {
                    Naamgevingen.API.Router()
                }
                URLRouting.Route(.case(API.vestigingsprofiel)) {
                    Vestigingsprofielen.API.Router()
                }
                URLRouting.Route(.case(API.zoeken)) {
                    OneOf {
                        URLRouting.Route(.case(API.Zoeken.v1)) {
                            Zoeken_V1.APIV1.Router()
                        }
                        
                        URLRouting.Route(.case(API.Zoeken.v2)) {
                            Zoeken_V2.API.Router()
                        }
                    }
                }
            }
        }
    }
}


extension API.Router: TestDependencyKey {
    public static let testValue: API.Router = .init()
}
