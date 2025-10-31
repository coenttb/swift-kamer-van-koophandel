import Dependencies
import DependenciesMacros
import Foundation
import Kamer_van_Koophandel_Models
import Kamer_van_Koophandel_Shared

extension Client: TestDependencyKey {
  public static let testValue: Self = {
    let store = Basisprofiel.Store()

    return Self(
      get: { kvkNummer, geoData in
        try store.get(kvkNummer: kvkNummer, geoData: geoData)
      },
      getEigenaar: { kvkNummer, geoData in
        try store.getEigenaar(kvkNummer: kvkNummer, geoData: geoData)
      },
      getHoofdvestiging: { kvkNummer, geoData in
        try store.getHoofdvestiging(kvkNummer: kvkNummer, geoData: geoData)
      },
      getVestigingen: { kvkNummer in
        try store.getVestigingen(kvkNummer: kvkNummer)
      }
    )
  }()
}

extension Basisprofiel {
  actor Store {
    private var storedBasisprofielen: [Kamer_van_Koophandel_Models.Number: Basisprofiel] = [
      Basisprofiel.kvk.kvkNummer: Basisprofiel.kvk
    ]

    func get(kvkNummer: Kamer_van_Koophandel_Models.Number, geoData: Bool?) throws -> Basisprofiel {
      guard let profiel = storedBasisprofielen[kvkNummer] else {
        throw KvKError.notFound
      }
      return profiel
    }

    func getEigenaar(kvkNummer: Kamer_van_Koophandel_Models.Number, geoData: Bool?) throws
      -> Eigenaar
    {
      guard let profiel = storedBasisprofielen[kvkNummer],
        let eigenaar = profiel.embedded?.eigenaar
      else {
        throw KvKError.notFound
      }
      return eigenaar
    }

    func getHoofdvestiging(kvkNummer: Kamer_van_Koophandel_Models.Number, geoData: Bool?) throws
      -> Vestiging
    {
      guard let profiel = storedBasisprofielen[kvkNummer],
        let hoofdvestiging = profiel.embedded?.hoofdvestiging
      else {
        throw KvKError.notFound
      }
      return hoofdvestiging
    }

    func getVestigingen(kvkNummer: Kamer_van_Koophandel_Models.Number) throws -> VestigingList {
      guard let profiel = storedBasisprofielen[kvkNummer],
        let hoofdvestiging = profiel.embedded?.hoofdvestiging
      else {
        throw KvKError.notFound
      }

      let vestigingBasis = VestigingBasis(
        vestigingsnummer: hoofdvestiging.vestigingsnummer,
        kvkNummer: hoofdvestiging.kvkNummer,
        eersteHandelsnaam: hoofdvestiging.eersteHandelsnaam,
        indHoofdvestiging: hoofdvestiging.indHoofdvestiging,
        indAdresAfgeschermd: hoofdvestiging.adressen?.first?.indAfgeschermd,
        indCommercieleVestiging: hoofdvestiging.indCommercieleVestiging,
        volledigAdres: hoofdvestiging.adressen?.first?.volledigAdres,
        links: hoofdvestiging.links
      )

      return VestigingList(
        kvkNummer: kvkNummer,
        aantalCommercieleVestigingen: 0,
        aantalNietCommercieleVestigingen: 1,
        totaalAantalVestigingen: 1,
        vestigingen: [vestigingBasis],
        links: [
          Link(
            href: "https://api.kvk.nl/api/v1/basisprofielen/\(kvkNummer)/vestigingen",
            title: "self"
          )
        ]
      )
    }
  }
}
extension KvKError {
  static let notFound = KvKError.httpError(
    statusCode: 404,
    message: "Geen resultaat gevonden"
  )
}

extension Basisprofiel {
  package static let kvk: Self = .init(
    kvkNummer: "59581883",
    indNonMailing: "Ja",
    naam: "Kamer van Koophandel",
    formeleRegistratiedatum: "20140102",
    materieleRegistratie: nil,
    totaalWerkzamePersonen: nil,
    statutaireNaam: nil,
    handelsnamen: nil,
    sbiActiviteiten: [
      SBIActiviteit(
        sbiCode: "9411",
        sbiOmschrijving: "Bedrijfs- en werkgeversorganisaties",
        indHoofdactiviteit: "Ja"
      )
    ],
    links: [
      Link(href: "https://api.kvk.nl/api/v1/basisprofielen/59581883"),
      Link(href: "https://api.kvk.nl/api/v1/basisprofielen/59581883/vestigingen"),
    ],
    embedded: EmbeddedContainer(
      hoofdvestiging: .kvkHoofdVestiging,
      eigenaar: .kvk
    )
  )
}

extension Basisprofiel.Vestiging {
  static let kvkHoofdVestiging: Self = .init(
    vestigingsnummer: "000015063097",
    kvkNummer: "59581883",
    rsin: "823807071",
    indNonMailing: nil,
    formeleRegistratiedatum: "20140102",
    materieleRegistratie: .init(
      datumAanvang: "19900701",
      datumEinde: nil
    ),
    statutaireNaam: nil,
    eersteHandelsnaam: "Kamer van Koophandel",
    indHoofdvestiging: "Ja",
    indCommercieleVestiging: "Nee",
    voltijdWerkzamePersonen: nil,
    totaalWerkzamePersonen: nil,
    deeltijdWerkzamePersonen: nil,
    handelsnamen: nil,
    adressen: [
      .init(
        type: "correspondentieadres",
        indAfgeschermd: "Nee",
        volledigAdres: "Postbus 48 3500AA Utrecht",
        straatnaam: nil,
        huisnummer: nil,
        huisletter: nil,
        huisnummerToevoeging: nil,
        toevoegingAdres: nil,
        postcode: "3500AA",
        postbusnummer: 48,
        plaats: "Utrecht",
        straatHuisnummer: nil,
        postcodeWoonplaats: nil,
        regio: nil,
        land: "Nederland",
        geoData: nil
      ),
      .init(
        type: "bezoekadres",
        indAfgeschermd: "Nee",
        volledigAdres: "St.-Jacobsstraat 300 3511BT Utrecht",
        straatnaam: "St.-Jacobsstraat",
        huisnummer: 300,
        huisletter: nil,
        huisnummerToevoeging: nil,
        toevoegingAdres: nil,
        postcode: "3511BT",
        postbusnummer: nil,
        plaats: "Utrecht",
        straatHuisnummer: nil,
        postcodeWoonplaats: nil,
        regio: nil,
        land: "Nederland",
        geoData: nil
      ),
    ],
    websites: ["www.kvk.nl"],
    sbiActiviteiten: nil,
    links: [
      .init(href: "https://api.kvk.nl/api/v1/basisprofielen/59581883/hoofdvestiging"),
      .init(href: "https://api.kvk.nl/api/v1/basisprofielen/59581883/vestigingen"),
      .init(href: "https://api.kvk.nl/api/v1/basisprofielen/59581883"),
      .init(href: "https://api.kvk.nl/api/v1/vestigingsprofielen/000015063097"),
    ]
  )
}

extension Basisprofiel.Eigenaar {
  package static let kvk: Self = .init(
    rsin: "823807071",
    rechtsvorm: "Publiekrechtelijke Rechtspersoon",
    uitgebreideRechtsvorm: "Publiekrechtelijke Rechtspersoon: Zelfstandig Bestuursorgaan (ZBO)",
    adressen: nil,
    websites: nil,
    links: [
      .init(href: "https://api.kvk.nl/api/v1/basisprofielen/59581883/eigenaar"),
      .init(href: "https://api.kvk.nl/api/v1/basisprofielen/59581883"),
    ]
  )
}
