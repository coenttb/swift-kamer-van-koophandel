import Dependencies
import Foundation
import Kamer_van_Koophandel_Models
import Kamer_van_Koophandel_Shared
import URLRouting
import UrlFormCoding

public enum API: Equatable, Sendable {
  case get(vestigingsnummer: String, geoData: Bool?)
}

extension API {
  public struct Router: ParserPrinter, Sendable {
    public init() {}

    public var body: some URLRouting.Router<API> {
      OneOf {
        // Get vestigingsprofiel
        URLRouting.Route(.case(API.get)) {
          Method.get
          Path.v1
          Path.vestigingsprofielen
          Path { Parse(.string) }
          Query {
            Optionally {
              Field("geoData") {
                Bool.parser()
              }
            }
          }
        }
      }
    }
  }
}

// Add path extensions
extension Path<PathBuilder.Component<String>> {
  nonisolated(unsafe) public static let vestigingsprofielen = Path {
    "vestigingsprofielen"
  }
}

extension API.Router: TestDependencyKey {
  public static let testValue: API.Router = .init()
}
