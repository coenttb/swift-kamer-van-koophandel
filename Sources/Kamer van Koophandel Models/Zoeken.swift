import Foundation

public struct Zoeken: Codable, Equatable, Sendable {
    public let pagina: Int
    public let resultatenPerPagina: Int
    public let totaal: Int
    public let vorige: String?
    public let volgende: String?
    public let resultaten: [ResultaatItem]
    public let links: [Link]
    
    private enum CodingKeys: String, CodingKey {
        case pagina
        case resultatenPerPagina
        case totaal
        case vorige
        case volgende
        case resultaten
        case links = "_links"
    }
    
    public init(
        pagina: Int,
        resultatenPerPagina: Int,
        totaal: Int,
        vorige: String? = nil,
        volgende: String? = nil,
        resultaten: [ResultaatItem],
        links: [Link]
    ) {
        self.pagina = pagina
        self.resultatenPerPagina = resultatenPerPagina
        self.totaal = totaal
        self.vorige = vorige
        self.volgende = volgende
        self.resultaten = resultaten
        self.links = links
    }
}

extension Zoeken {
    public struct ResultaatItem: Codable, Equatable, Sendable {
        public let kvkNummer: Kamer_van_Koophandel_Models.Number
        public let rsin: String?
        public let vestigingsnummer: String?
        public let naam: String
        public let adres: Adres
        public let type: String
        public let actief: String
        public let vervallenNaam: String?
        public let links: [Link]
        
        private enum CodingKeys: String, CodingKey {
            case kvkNummer
            case rsin
            case vestigingsnummer
            case naam
            case adres
            case type
            case actief
            case vervallenNaam
            case links = "_links"
        }
        
        public init(
            kvkNummer: Kamer_van_Koophandel_Models.Number,
            rsin: String? = nil,
            vestigingsnummer: String? = nil,
            naam: String,
            adres: Adres,
            type: String,
            actief: String,
            vervallenNaam: String? = nil,
            links: [Link]
        ) {
            self.kvkNummer = kvkNummer
            self.rsin = rsin
            self.vestigingsnummer = vestigingsnummer
            self.naam = naam
            self.adres = adres
            self.type = type
            self.actief = actief
            self.vervallenNaam = vervallenNaam
            self.links = links
        }
    }
}

extension Zoeken {
    public struct Adres: Codable, Equatable, Sendable {
        public let binnenlandsAdres: BinnenlandsAdres?
        public let buitenlandsAdres: BuitenlandsAdres?
        
        public init(
            binnenlandsAdres: BinnenlandsAdres? = nil,
            buitenlandsAdres: BuitenlandsAdres? = nil
        ) {
            self.binnenlandsAdres = binnenlandsAdres
            self.buitenlandsAdres = buitenlandsAdres
        }
    }
}

extension Zoeken {
    public struct BinnenlandsAdres: Codable, Equatable, Sendable {
        public let type: AdresType
        public let straatnaam: String?
        public let huisnummer: Int?
        public let huisletter: String?
        public let postbusnummer: Int?
        public let postcode: String?
        public let plaats: String?
        
        public init(
            type: AdresType,
            straatnaam: String? = nil,
            huisnummer: Int? = nil,
            huisletter: String? = nil,
            postbusnummer: Int? = nil,
            postcode: String? = nil,
            plaats: String? = nil
        ) {
            self.type = type
            self.straatnaam = straatnaam
            self.huisnummer = huisnummer
            self.huisletter = huisletter
            self.postbusnummer = postbusnummer
            self.postcode = postcode
            self.plaats = plaats
        }
    }
}

extension Zoeken {
    public struct BuitenlandsAdres: Codable, Equatable, Sendable {
        public let type: AdresType
        public let straatHuisnummer: String?
        public let postcodeWoonplaats: String?
        public let land: String?
        
        public init(
            type: AdresType,
            straatHuisnummer: String? = nil,
            postcodeWoonplaats: String? = nil,
            land: String? = nil
        ) {
            self.type = type
            self.straatHuisnummer = straatHuisnummer
            self.postcodeWoonplaats = postcodeWoonplaats
            self.land = land
        }
    }
}

extension Zoeken {
    public enum AdresType: String, Codable, Equatable, Sendable {
        case bezoekadres
        case postadres
    }
}

extension Zoeken {
    public struct Links: Codable, Equatable, Sendable {
        public let `self`: Link
        
        public init(`self` _self: Link) {
            self.`self` = _self
        }
    }
}

extension Zoeken {
    public struct Link: Codable, Equatable, Sendable {
        public let href: String
        public let title: String?
        
        public init(
            href: String,
            title: String? = nil
        ) {
            self.href = href
            self.title = title
        }
    }
}

extension Zoeken {
    public struct Error: Codable, Equatable, Sendable {
        public let fout: [Fout]?
        
        public init(fout: [Fout]? = nil) {
            self.fout = fout
        }
    }
}

extension Zoeken {
    public struct Fout: Codable, Equatable, Sendable {
        public let code: String?
        public let omschrijving: String?
        
        public init(
            code: String? = nil,
            omschrijving: String? = nil
        ) {
            self.code = code
            self.omschrijving = omschrijving
        }
    }
}
