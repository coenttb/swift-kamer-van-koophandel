import Dependencies
import DependenciesMacros
import Foundation
import Kamer_van_Koophandel_Models

extension Client: TestDependencyKey {
  public static let testValue: Self = {
    let store = Naamgeving.Store()

    return Self(
      get: { kvkNummer in
        try store.get(kvkNummer: kvkNummer)
      }
    )
  }()
}

extension Naamgeving {
  actor Store {
    private var storedNaamgevingen: [Kamer_van_Koophandel_Models.Number: Naamgeving] = [
      "68750110": Naamgeving(
        kvkNummer: "68750110",
        rsin: "857587973",
        statutaireNaam: "Test BV Donald",
        naam: "Test BV Donald",
        ookGenoemd: nil,
        startdatum: "20220421",
        einddatum: nil,
        vestigingen: [
          .commercieel(
            CommercieleVestiging(
              vestigingsnummer: "000015063097",
              eersteHandelsnaam: "Kamer van Koophandel Utrecht",
              handelsnamen: [
                Handelsnaam(naam: "Kamer van Koophandel Utrecht", volgorde: 0),
                Handelsnaam(naam: "KVK Utrecht", volgorde: 1),
              ],
              links: [
                Link(
                  href: "https://api.kvk.nl/api/v1/vestigingsprofielen/000015063097",
                  title: "Vestigingsprofiel"
                )
              ]
            )
          ),
          .nietCommercieel(
            NietCommercieleVestiging(
              vestigingsnummer: "000015063098",
              naam: "Kamer van Koophandel Bibliotheek",
              ookGenoemd: "KVK Bibliotheek",
              links: [
                Link(
                  href: "https://api.kvk.nl/api/v1/vestigingsprofielen/000015063098",
                  title: "Vestigingsprofiel"
                )
              ]
            )
          ),
        ],
        links: [
          Link(
            href: "https://api.kvk.nl/api/v1/naamgevingen/59581883",
            title: "Naamgeving"
          ),
          Link(
            href: "https://api.kvk.nl/api/v1/basisprofielen/59581883",
            title: "Basisprofiel"
          ),
        ]
      ),
      "59581883": Naamgeving(
        kvkNummer: "59581883",
        rsin: "823807071",
        statutaireNaam: "Kamer van Koophandel",
        naam: "Kamer van Koophandel",
        ookGenoemd: nil,
        startdatum: "20220421",
        einddatum: nil,
        vestigingen: [
          .commercieel(
            CommercieleVestiging(
              vestigingsnummer: "000015063097",
              eersteHandelsnaam: "Kamer van Koophandel Utrecht",
              handelsnamen: [
                Handelsnaam(naam: "Kamer van Koophandel Utrecht", volgorde: 0),
                Handelsnaam(naam: "KVK Utrecht", volgorde: 1),
              ],
              links: [
                Link(
                  href: "https://api.kvk.nl/api/v1/vestigingsprofielen/000015063097",
                  title: "Vestigingsprofiel"
                )
              ]
            )
          ),
          .nietCommercieel(
            NietCommercieleVestiging(
              vestigingsnummer: "000015063098",
              naam: "Kamer van Koophandel Bibliotheek",
              ookGenoemd: "KVK Bibliotheek",
              links: [
                Link(
                  href: "https://api.kvk.nl/api/v1/vestigingsprofielen/000015063098",
                  title: "Vestigingsprofiel"
                )
              ]
            )
          ),
        ],
        links: [
          Link(
            href: "https://api.kvk.nl/api/v1/naamgevingen/59581883",
            title: "Naamgeving"
          ),
          Link(
            href: "https://api.kvk.nl/api/v1/basisprofielen/59581883",
            title: "Basisprofiel"
          ),
        ]
      ),
      "12345678": Naamgeving(
        kvkNummer: "12345678",
        rsin: "123456789",
        statutaireNaam: "Test Bedrijf B.V.",
        naam: "Test Bedrijf",
        ookGenoemd: "TB",
        startdatum: "20200101",
        einddatum: nil,
        vestigingen: [
          .commercieel(
            CommercieleVestiging(
              vestigingsnummer: "000012345678",
              eersteHandelsnaam: "Test Bedrijf Amsterdam",
              handelsnamen: [
                Handelsnaam(naam: "Test Bedrijf Amsterdam", volgorde: 0),
                Handelsnaam(naam: "TB Amsterdam", volgorde: 1),
              ],
              links: [
                Link(
                  href: "https://api.kvk.nl/api/v1/vestigingsprofielen/000012345678",
                  title: "Vestigingsprofiel"
                )
              ]
            )
          )
        ],
        links: [
          Link(
            href: "https://api.kvk.nl/api/v1/naamgevingen/12345678",
            title: "Naamgeving"
          ),
          Link(
            href: "https://api.kvk.nl/api/v1/basisprofielen/12345678",
            title: "Basisprofiel"
          ),
        ]
      ),
    ]
  }
}

extension Naamgeving.Store {
  func get(kvkNummer: Kamer_van_Koophandel_Models.Number) throws -> Naamgeving {
    guard let naamgeving = storedNaamgevingen[kvkNummer] else {
      throw NSError(
        domain: "NaamgevingTest",
        code: 404,
        userInfo: [NSLocalizedDescriptionKey: "Naamgeving not found for KvK number: \(kvkNummer)"]
      )
    }
    return naamgeving
  }
}
