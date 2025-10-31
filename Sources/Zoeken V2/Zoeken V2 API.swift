import Dependencies
import Foundation
import Kamer_van_Koophandel_Models
import Kamer_van_Koophandel_Shared
import URLRouting
import UrlFormCoding

public enum API: Equatable, Sendable {
  case search(
    kvkNummer: Kamer_van_Koophandel_Models.Number? = nil,
    rsin: String? = nil,
    vestigingsnummer: String? = nil,
    naam: String? = nil,
    straatnaam: String? = nil,
    plaats: String? = nil,
    postcode: String? = nil,
    huisnummer: Int? = nil,
    huisletter: String? = nil,
    postbusnummer: Int? = nil,
    type: [String]? = nil,
    inclusiefInactieveRegistraties: Bool? = nil,
    pagina: Int? = nil,
    resultatenPerPagina: Int? = nil
  )
}

extension API {
  public struct Router: ParserPrinter, Sendable {
    public init() {}

    public var body: some URLRouting.Router<API> {
      OneOf {
        URLRouting.Route(.case(API.search)) {
          Method.get
          Path.v2
          Path.zoeken

          Parse {
            Optionally {
              Query {
                Field("kvkNummer") {
                  Parse(.string.representing(Kamer_van_Koophandel_Models.Number.self))
                }
              }
            }
            Optionally {
              Query {
                Field("rsin") {
                  Parse(.string)
                }
              }
            }
            Optionally {
              Query {
                Field("vestigingsnummer") {
                  Parse(.string)
                }
              }
            }
            Optionally {
              Query {
                Field("naam") {
                  Parse(.string)
                }
              }
            }
            Optionally {
              Query {
                Field("straatnaam") {
                  Parse(.string)
                }
              }
            }
            Optionally {
              Query {
                Field("plaats") {
                  Parse(.string)
                }
              }
            }
            Optionally {
              Query {
                Field("postcode") {
                  Parse(.string)
                }
              }
            }
            Optionally {
              Query {
                Field("huisnummer") {
                  Digits()
                }
              }
            }
            Optionally {
              Query {
                Field("huisletter") {
                  Parse(.string)
                }
              }
            }
            Optionally {
              Query {
                Field("postbusnummer") {
                  Digits()
                }
              }
            }
            Optionally {
              Query {
                Field("type") {
                  //                                Parse(.array(.string))
                  Many {
                    Parse(.string)
                  }
                }
              }
            }
            Optionally {
              Query {
                Field("inclusiefInactieveRegistraties") {
                  Bool.parser()
                }
              }
            }
            Optionally {
              Query {
                Field("pagina") {
                  Digits()
                }
              }
            }
            Optionally {
              Query {
                Field("resultatenPerPagina") {
                  Digits()
                }
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

extension API.Router: TestDependencyKey {
  public static let testValue: API.Router = .init()
}
