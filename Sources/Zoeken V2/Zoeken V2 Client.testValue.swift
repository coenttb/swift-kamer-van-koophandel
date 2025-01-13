import Foundation
import Dependencies
import DependenciesMacros
import Kamer_van_Koophandel_Models
import Kamer_van_Koophandel_Shared

extension Client: TestDependencyKey {
    public static let testValue: Self = {
        let store = Zoeken.Store()
        
        return Self(
            search: { kvkNummer, rsin, vestigingsnummer, naam, straatnaam, plaats, postcode, huisnummer, huisletter, postbusnummer, type, inclusiefInactieveRegistraties, pagina, resultatenPerPagina in
                try store.search(
                    kvkNummer: kvkNummer,
                    rsin: rsin,
                    vestigingsnummer: vestigingsnummer,
                    naam: naam,
                    straatnaam: straatnaam,
                    plaats: plaats,
                    postcode: postcode,
                    huisnummer: huisnummer,
                    huisletter: huisletter,
                    postbusnummer: postbusnummer,
                    type: type,
                    inclusiefInactieveRegistraties: inclusiefInactieveRegistraties,
                    pagina: pagina ?? 1,
                    resultatenPerPagina: resultatenPerPagina ?? 10
                )
            }
        )
    }()
}

extension Zoeken {
    actor Store {
        private var storedResults: [ResultaatItem] = [
            ResultaatItem(
                kvkNummer: "59581883",
                rsin: "823807071",
                vestigingsnummer: "000015063097",
                naam: "Kamer van Koophandel Utrecht",
                adres: Adres(
                    binnenlandsAdres: BinnenlandsAdres(
                        type: .bezoekadres,
                        straatnaam: "St.-Jacobsstraat",
                        huisnummer: 300,
                        postcode: "3511BT",
                        plaats: "Utrecht"
                    )
                ),
                type: "hoofdvestiging",
                actief: "Ja",
                links: [
                    Link(
                        href: "https://api.kvk.nl/api/v2/zoeken/hoofdvestiging/59581883",
                        title: "Details hoofdvestiging"
                    )
                ]
            ),
            ResultaatItem(
                kvkNummer: "12345678",
                rsin: "123456789",
                vestigingsnummer: "000012345678",
                naam: "Test Bedrijf Amsterdam",
                adres: Adres(
                    binnenlandsAdres: BinnenlandsAdres(
                        type: .bezoekadres,
                        straatnaam: "Teststraat",
                        huisnummer: 42,
                        postcode: "1234AB",
                        plaats: "Amsterdam"
                    )
                ),
                type: "hoofdvestiging",
                actief: "Ja",
                links: [
                    Link(
                        href: "https://api.kvk.nl/api/v2/zoeken/hoofdvestiging/12345678",
                        title: "Details hoofdvestiging"
                    )
                ]
            ),
            ResultaatItem(
                kvkNummer: "87654321",
                rsin: "987654321",
                vestigingsnummer: "000087654321",
                naam: "International Company B.V.",
                adres: Adres(
                    buitenlandsAdres: BuitenlandsAdres(
                        type: .bezoekadres,
                        straatHuisnummer: "53 Rue de Tilsitt",
                        postcodeWoonplaats: "X-13501 Parijs",
                        land: "Frankrijk"
                    )
                ),
                type: "rechtspersoon",
                actief: "Ja",
                links: [
                    Link(
                        href: "https://api.kvk.nl/api/v2/zoeken/rechtspersoon/87654321",
                        title: "Details rechtspersoon"
                    )
                ]
            )
        ]
        
        func search(
            kvkNummer: Kamer_van_Koophandel_Models.Number?,
            rsin: String?,
            vestigingsnummer: String?,
            naam: String?,
            straatnaam: String?,
            plaats: String?,
            postcode: String?,
            huisnummer: Int?,
            huisletter: String?,
            postbusnummer: Int?,
            type: [String]?,
            inclusiefInactieveRegistraties: Bool?,
            pagina: Int,
            resultatenPerPagina: Int
        ) throws -> Zoeken {
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
            
            if let naam = naam {
                filteredResults = filteredResults.filter { $0.naam.localizedCaseInsensitiveContains(naam) }
            }
            
            if let straatnaam = straatnaam {
                filteredResults = filteredResults.filter {
                    if let binnenlands = $0.adres.binnenlandsAdres {
                        return binnenlands.straatnaam?.localizedCaseInsensitiveContains(straatnaam) ?? false
                    }
                    return false
                }
            }
            
            if let plaats = plaats {
                filteredResults = filteredResults.filter {
                    if let binnenlands = $0.adres.binnenlandsAdres {
                        return binnenlands.plaats?.localizedCaseInsensitiveContains(plaats) ?? false
                    }
                    return false
                }
            }
            
            if let postcode = postcode {
                filteredResults = filteredResults.filter {
                    if let binnenlands = $0.adres.binnenlandsAdres {
                        return binnenlands.postcode == postcode
                    }
                    return false
                }
            }
            
            if let huisnummer = huisnummer {
                filteredResults = filteredResults.filter {
                    if let binnenlands = $0.adres.binnenlandsAdres {
                        return binnenlands.huisnummer == huisnummer
                    }
                    return false
                }
            }
            
            if let type = type {
                filteredResults = filteredResults.filter { type.contains($0.type) }
            }
            
            if inclusiefInactieveRegistraties != true {
                filteredResults = filteredResults.filter { $0.actief == "Ja" }
            }
            
            let totalResults = filteredResults.count
            let startIndex = (pagina - 1) * resultatenPerPagina
            let endIndex = min(startIndex + resultatenPerPagina, totalResults)
            
            let paginatedResults = Array(filteredResults[startIndex..<endIndex])
            
            return Zoeken(
                pagina: pagina,
                resultatenPerPagina: resultatenPerPagina,
                totaal: totalResults,
                vorige: pagina > 1 ? "/api/v2/zoeken?pagina=\(pagina - 1)" : nil,
                volgende: endIndex < totalResults ? "/api/v2/zoeken?pagina=\(pagina + 1)" : nil,
                resultaten: paginatedResults,
                links: [
                    Link(
                        href: "https://api.kvk.nl/api/v2/zoeken",
                        title: "Zoeken"
                    )
                ]
            )
        }
    }
}
