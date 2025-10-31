import Dependencies
import DependenciesMacros
import DependenciesTestSupport
import EnvironmentVariables
import Foundation
import IssueReporting
import Kamer_van_Koophandel_Shared
import Testing

@testable import Kamer_van_Koophandel_Models
@testable import Zoeken_V1

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

extension Zoeken_V1.AuthenticatedClient: @retroactive TestDependencyKey {
  public static let testValue: Self = {
    @Dependency(TestStrategy.self) var testStrategy

    return switch testStrategy {
    case .local:
      try! Zoeken_V1.AuthenticatedClient.test { Zoeken_V1.Client.testValue }

    case .liveTest:
      try! Zoeken_V1.AuthenticatedClient.test { Zoeken_V1.Client.live(makeRequest: $0) }

    case .live:
      try! Zoeken_V1.AuthenticatedClient.test { Zoeken_V1.Client.live(makeRequest: $0) }
    }
  }()
}
