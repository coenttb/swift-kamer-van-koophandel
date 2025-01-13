import Foundation
import Dependencies
import DependenciesMacros
import Kamer_van_Koophandel_Models
import Kamer_van_Koophandel_Shared

extension Client: TestDependencyKey {
    public static let testValue: Self = {
        let store = Vestigingsprofiel.Store()
        
        return Self(
            get: { vestigingsnummer, geoData in
                try store.get(vestigingsnummer: vestigingsnummer, geoData: geoData)
            }
        )
    }()
}

extension Vestigingsprofiel {
    package actor Store {
        private var storedVestigingsprofielen: [String: Vestigingsprofiel] = [
            "000015063097": Vestigingsprofiel.kvkUtrecht
        ]
        
        func get(vestigingsnummer: String, geoData: Bool?) throws -> Vestigingsprofiel {
            guard let profiel = storedVestigingsprofielen[vestigingsnummer] else {
                throw KvKError.invalidResponse
            }
            return profiel
        }
    }
}

extension Vestigingsprofiel {
    package static let kvkUtrecht: Self = .init(
        vestigingsnummer: "000015063097",
        kvkNummer: "59581883",
        rsin: "823807071",
        indNonMailing: "Ja",
        formeleRegistratiedatum: "20140102",
        materieleRegistratie: .init(
            datumAanvang: "19900701",
            datumEinde: nil
        ),
        statutaireNaam: nil,
        eersteHandelsnaam: "Kamer van Koophandel Utrecht",
        indHoofdvestiging: "Ja",
        indCommercieleVestiging: "Nee",
        voltijdWerkzamePersonen: 250,
        totaalWerkzamePersonen: 300,
        deeltijdWerkzamePersonen: 50,
        handelsnamen: [
            .init(naam: "Kamer van Koophandel Utrecht", volgorde: 0),
            .init(naam: "KVK Utrecht", volgorde: 1)
        ],
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
                geoData: .init(
                    addresseerbaarObjectId: "0344010000000001",
                    nummerAanduidingId: "0344200000000001",
                    gpsLatitude: 52.093753,
                    gpsLongitude: 5.116060,
                    rijksdriehoekX: 136284.0,
                    rijksdriehoekY: 456556.0,
                    rijksdriehoekZ: nil
                )
            )
        ],
        websites: ["www.kvk.nl"],
        sbiActiviteiten: [
            .init(
                sbiCode: "9411",
                sbiOmschrijving: "Bedrijfs- en werkgeversorganisaties",
                indHoofdactiviteit: "Ja"
            )
        ],
        links: [
            .init(
                href: "https://api.kvk.nl/api/v1/vestigingsprofielen/000015063097",
                title: "self"
            ),
            .init(
                href: "https://api.kvk.nl/api/v1/basisprofielen/59581883/vestigingen",
                title: "vestigingen"
            ),
            .init(
                href: "https://api.kvk.nl/api/v1/basisprofielen/59581883",
                title: "basisprofiel"
            )
        ]
    )
}
