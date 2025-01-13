import Foundation
import URLRouting
import UrlFormCoding
import Dependencies
import Kamer_van_Koophandel_Shared
import Kamer_van_Koophandel_Models

public enum APIV1: Equatable, Sendable {
    case search(
        kvkNummer: Kamer_van_Koophandel_Models.Number? = nil,
        rsin: String? = nil,
        vestigingsnummer: String? = nil,
        handelsnaam: String? = nil,
        straatnaam: String? = nil,
        plaats: String? = nil,
        postcode: String? = nil,
        huisnummer: Int? = nil,
        huisnummerToevoeging: String? = nil,
        type: String? = nil,
        inclusiefInactieveRegistraties: Bool? = nil,
        pagina: Int? = nil,
        aantal: Int? = nil
    )
}

extension APIV1 {
    public struct Router: ParserPrinter, Sendable {
        public init() {}
        
        public var body: some URLRouting.Router<APIV1> {
            OneOf {
                URLRouting.Route(.case(APIV1.search)) {
                    Method.get
                    Path.v1
                    Path.zoeken
                    Query {
                        Optionally {
                            Field("kvkNummer") {
                                Parse(.string.representing(Kamer_van_Koophandel_Models.Number.self))
                            }
                        }
                        
                        Optionally {
                            Field("rsin") {
                                Parse(.string)
                            }
                        }
                        
                        Optionally {
                            Field("vestigingsnummer") {
                                Parse(.string)
                            }
                        }
                        
                        Optionally {
                            Field("handelsnaam") {
                                Parse(.string)
                            }
                        }
                        
                        Optionally {
                            Field("straatnaam") {
                                Parse(.string)
                            }
                        }
                        
                        Optionally {
                            Field("plaats") {
                                Parse(.string)
                            }
                        }
                        
                        Optionally {
                            Field("postcode") {
                                Parse(.string)
                            }
                        }
                        
                        Optionally {
                            Field("huisnummer") {
                                Digits()
                            }
                        }
                        
                        Optionally {
                            Field("huisnummerToevoeging") {
                                Parse(.string)
                            }
                        }
                        
                        Optionally {
                            Field("type") {
                                Parse(.string)
                            }
                        }
                        
                        Optionally {
                            Field("InclusiefInactieveRegistraties") {
                                Bool.parser()
                            }
                        }
                        
                        Optionally {
                            Field("pagina") {
                                Digits()
                            }
                        }
                        
                        Optionally {
                            Field("aantal") {
                                Digits()
                            }
                        }
                    }
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    nonisolated(unsafe) public static let zoeken = Path {
        "zoeken"
    }
}

extension APIV1.Router: TestDependencyKey {
    public static let testValue: APIV1.Router = .init()
}
