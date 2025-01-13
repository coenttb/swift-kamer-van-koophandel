import Foundation
import URLRouting
import UrlFormCoding
import Dependencies
import Kamer_van_Koophandel_Shared
import Kamer_van_Koophandel_Models

public enum API: Equatable, Sendable {
    case get(kvkNummer: Kamer_van_Koophandel_Models.Number, geoData: Bool?)
    case getEigenaar(kvkNummer: Kamer_van_Koophandel_Models.Number, geoData: Bool?)
    case getHoofdvestiging(kvkNummer: Kamer_van_Koophandel_Models.Number, geoData: Bool?)
    case getVestigingen(kvkNummer: Kamer_van_Koophandel_Models.Number)
}

extension API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}
        
        public var body: some URLRouting.Router<API> {
            OneOf {
                // Get basisprofiel
                URLRouting.Route(.case(API.get)) {
                    Method.get
                    Path.v1
                    Path.basisprofielen
                    Path { Parse(.string.representing(Kamer_van_Koophandel_Models.Number.self)) }
                    Query {
                        Optionally {
                            Field("geoData") {
                                Bool.parser()
                            }
                        }
                    }
                }
                
                URLRouting.Route(.case(API.getEigenaar)) {
                    Method.get
                    Path.v1
                    Path.basisprofielen
                    Path { Parse(.string.representing(Kamer_van_Koophandel_Models.Number.self)) }
                    Path.eigenaar
                    Query {
                        Optionally {
                            Field("geoData") {
                                Bool.parser()
                            }
                        }
                    }
                }
                
                
                // Get hoofdvestiging
                URLRouting.Route(.case(API.getHoofdvestiging)) {
                    Method.get
                    Path.v1
                    Path.basisprofielen
                    Path { Parse(.string.representing(Kamer_van_Koophandel_Models.Number.self)) }
                    Path.hoofdvestiging
                    Query {
                        Optionally {
                            Field("geoData") {
                                Bool.parser()
                            }
                        }
                    }
                }
                
                // Get vestigingen
                URLRouting.Route(.case(API.getVestigingen)) {
                    Method.get
                    Path.v1
                    Path.basisprofielen
                    Path { Parse(.string.representing(Kamer_van_Koophandel_Models.Number.self)) }
                    Path.vestigingen
                }
            }
        }
    }
}

// Add path extensions
extension Path<PathBuilder.Component<String>> {
    nonisolated(unsafe) public static let basisprofielen = Path {
        "basisprofielen"
    }
    
    nonisolated(unsafe) public static let eigenaar = Path {
        "eigenaar"
    }
    
    nonisolated(unsafe) public static let hoofdvestiging = Path {
        "hoofdvestiging"
    }
    
    nonisolated(unsafe) public static let vestigingen = Path {
        "vestigingen"
    }
}

extension API.Router: TestDependencyKey {
    public static let testValue: API.Router = .init()
}
