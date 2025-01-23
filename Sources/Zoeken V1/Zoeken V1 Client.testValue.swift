import Foundation
import Dependencies
import DependenciesMacros
import Kamer_van_Koophandel_Models
import Kamer_van_Koophandel_Shared

extension Zoeken_V1.Client: TestDependencyKey {
    public static let testValue: Self = {
        let store = ZoekenV1.Store()
        
        return Self(
            search: { kvkNummer, rsin, vestigingsnummer, handelsnaam, straatnaam, plaats, postcode, huisnummer, huisnummerToevoeging, type, inclusiefInactieveRegistraties, pagina, aantal in
                try store.search(
                    kvkNummer: kvkNummer,
                    rsin: rsin,
                    vestigingsnummer: vestigingsnummer,
                    handelsnaam: handelsnaam,
                    straatnaam: straatnaam,
                    plaats: plaats,
                    postcode: postcode,
                    huisnummer: huisnummer,
                    huisnummerToevoeging: huisnummerToevoeging,
                    type: type,
                    inclusiefInactieveRegistraties: inclusiefInactieveRegistraties,
                    pagina: pagina ?? 1,
                    aantal: aantal ?? 10
                )
            }
        )
    }()
}

extension ZoekenV1 {
    actor Store {
        private var storedResults: [ResultaatItem] = [
            ResultaatItem(
                kvkNummer: "59581883",
                rsin: "823807071",
                vestigingsnummer: "000015063097",
                handelsnaam: "Kamer van Koophandel Utrecht",
                adresType: "bezoekadres",
                straatnaam: "St.-Jacobsstraat",
                huisnummer: 300,
                huisnummerToevoeging: nil,
                postcode: "3511BT",
                plaats: "Utrecht",
                type: "hoofdvestiging",
                actief: "Ja",
                links: [
                    Link(
                        rel: "self",
                        href: "https://api.kvk.nl/api/v1/zoeken/hoofdvestiging/59581883",
                        title: "Details hoofdvestiging"
                    )
                ]
            ),
            ResultaatItem(
                kvkNummer: "12345678",
                rsin: "123456789",
                vestigingsnummer: "000012345678",
                handelsnaam: "Test Bedrijf Amsterdam",
                adresType: "bezoekadres",
                straatnaam: "Teststraat",
                huisnummer: 42,
                huisnummerToevoeging: "A",
                postcode: "1234AB",
                plaats: "Amsterdam",
                type: "hoofdvestiging",
                actief: "Ja",
                links: [
                    Link(
                        rel: "self",
                        href: "https://api.kvk.nl/api/v1/zoeken/hoofdvestiging/12345678",
                        title: "Details hoofdvestiging"
                    )
                ]
            ),
            ResultaatItem(
                kvkNummer: "87654321",
                rsin: "987654321",
                vestigingsnummer: "000087654321",
                handelsnaam: "International Company B.V.",
                adresType: "bezoekadres",
                straatnaam: nil,
                huisnummer: nil,
                huisnummerToevoeging: nil,
                postcode: nil,
                plaats: "Parijs",
                type: "rechtspersoon",
                actief: "Ja",
                links: [
                    Link(
                        rel: "self",
                        href: "https://api.kvk.nl/api/v1/zoeken/rechtspersoon/87654321",
                        title: "Details rechtspersoon"
                    )
                ]
            )
        ]
        
        func search(
            kvkNummer: Kamer_van_Koophandel_Models.Number?,
            rsin: String?,
            vestigingsnummer: String?,
            handelsnaam: String?,
            straatnaam: String?,
            plaats: String?,
            postcode: String?,
            huisnummer: Int?,
            huisnummerToevoeging: String?,
            type: String?,
            inclusiefInactieveRegistraties: Bool?,
            pagina: Int,
            aantal: Int
        ) throws -> ZoekenV1 {
            var filteredResults = storedResults
            
            // Apply filters based on search parameters
            if let kvkNummer = kvkNummer {
                filteredResults = filteredResults.filter { $0.kvkNummer == kvkNummer }
            }
            
            if let rsin = rsin {
                filteredResults = filteredResults.filter { $0.rsin == rsin }
            }
            
            if let vestigingsnummer = vestigingsnummer {
                filteredResults = filteredResults.filter { $0.vestigingsnummer == vestigingsnummer }
            }
            
            if let handelsnaam = handelsnaam {
                filteredResults = filteredResults.filter { $0.handelsnaam.localizedCaseInsensitiveContains(handelsnaam) }
            }
            
            if let straatnaam = straatnaam {
                filteredResults = filteredResults.filter { $0.straatnaam?.localizedCaseInsensitiveContains(straatnaam) ?? false }
            }
            
            if let plaats = plaats {
                filteredResults = filteredResults.filter { $0.plaats?.localizedCaseInsensitiveContains(plaats) ?? false }
            }
            
            if let postcode = postcode {
                filteredResults = filteredResults.filter { $0.postcode == postcode }
            }
            
            if let huisnummer = huisnummer {
                filteredResults = filteredResults.filter { $0.huisnummer == huisnummer }
            }
            
            if let huisnummerToevoeging = huisnummerToevoeging {
                filteredResults = filteredResults.filter { $0.huisnummerToevoeging == huisnummerToevoeging }
            }
            
            if let type = type {
                filteredResults = filteredResults.filter { $0.type == type }
            }
            
            if inclusiefInactieveRegistraties != true {
                filteredResults = filteredResults.filter { $0.actief == "Ja" }
            }
            
            let totalResults = filteredResults.count
            let startIndex = (pagina - 1) * aantal
            let endIndex = min(startIndex + aantal, totalResults)
            
            let paginatedResults = Array(filteredResults[startIndex..<endIndex])
            
            return ZoekenV1(
                pagina: pagina,
                aantal: aantal,
                totaal: totalResults,
                vorige: pagina > 1 ? "/api/v1/zoeken?pagina=\(pagina - 1)" : nil,
                volgende: endIndex < totalResults ? "/api/v1/zoeken?pagina=\(pagina + 1)" : nil,
                resultaten: paginatedResults,
                links: [
                    Link(
                        rel: "self",
                        href: "https://api.kvk.nl/api/v1/zoeken",
                        title: "Zoeken"
                    )
                ]
            )
        }
    }
}
