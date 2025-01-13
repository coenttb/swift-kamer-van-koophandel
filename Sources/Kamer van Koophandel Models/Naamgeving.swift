import Foundation

public struct Naamgeving: Codable, Equatable, Sendable {
    public let kvkNummer: Kamer_van_Koophandel_Models.Number
    public let rsin: String?
    public let statutaireNaam: String?
    public let naam: String?
    public let ookGenoemd: String?
    public let startdatum: String?
    public let einddatum: String?
    public let vestigingen: [Vestiging]?
    public let links: [Link]?
    
    private enum CodingKeys: String, CodingKey {
        case kvkNummer
        case rsin
        case statutaireNaam
        case naam
        case ookGenoemd
        case startdatum
        case einddatum
        case vestigingen
        case links = "links"
    }
    
    public init(
        kvkNummer: Kamer_van_Koophandel_Models.Number,
        rsin: String? = nil,
        statutaireNaam: String? = nil,
        naam: String? = nil,
        ookGenoemd: String? = nil,
        startdatum: String? = nil,
        einddatum: String? = nil,
        vestigingen: [Vestiging]? = nil,
        links: [Link]?
    ) {
        self.kvkNummer = kvkNummer
        self.rsin = rsin
        self.statutaireNaam = statutaireNaam
        self.naam = naam
        self.ookGenoemd = ookGenoemd
        self.startdatum = startdatum
        self.einddatum = einddatum
        self.vestigingen = vestigingen
        self.links = links
    }
    
    public struct Links: Codable, Equatable, Sendable {
        public let `self`: Link
        public let basisprofiel: Link

        public init(
            `self` _self: Link,
            basisprofiel: Link
        ) {
            self.`self` = _self
            self.basisprofiel = basisprofiel
        }
    }
}

extension Naamgeving {
    public enum Vestiging: Codable, Equatable, Sendable {
        case commercieel(CommercieleVestiging)
        case nietCommercieel(NietCommercieleVestiging)
        
        private enum CodingKeys: String, CodingKey {
            case vestigingsnummer
            case eersteHandelsnaam
            case handelsnamen
            case naam
            case ookGenoemd
            case links
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let vestigingsnummer = try container.decode(String.self, forKey: .vestigingsnummer)
            let links = try container.decode([Link].self, forKey: .links)
            
            if let eersteHandelsnaam = try container.decodeIfPresent(String.self, forKey: .eersteHandelsnaam),
               let handelsnamen = try container.decodeIfPresent([Handelsnaam].self, forKey: .handelsnamen) {
                self = .commercieel(
                    CommercieleVestiging(
                        vestigingsnummer: vestigingsnummer,
                        eersteHandelsnaam: eersteHandelsnaam,
                        handelsnamen: handelsnamen,
                        links: links
                    )
                )
            } else if let naam = try container.decodeIfPresent(String.self, forKey: .naam) {
                self = .nietCommercieel(
                    NietCommercieleVestiging(
                        vestigingsnummer: vestigingsnummer,
                        naam: naam,
                        ookGenoemd: try container.decodeIfPresent(String.self, forKey: .ookGenoemd),
                        links: links
                    )
                )
            } else {
                throw DecodingError.dataCorruptedError(
                    forKey: .vestigingsnummer,
                    in: container,
                    debugDescription: "Unable to decode either CommercieleVestiging or NietCommercieleVestiging"
                )
            }
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            switch self {
            case .commercieel(let vestiging):
                try container.encode(vestiging.vestigingsnummer, forKey: .vestigingsnummer)
                try container.encode(vestiging.eersteHandelsnaam, forKey: .eersteHandelsnaam)
                try container.encode(vestiging.handelsnamen, forKey: .handelsnamen)
                try container.encode(vestiging.links, forKey: .links)
                
            case .nietCommercieel(let vestiging):
                try container.encode(vestiging.vestigingsnummer, forKey: .vestigingsnummer)
                try container.encode(vestiging.naam, forKey: .naam)
                try container.encodeIfPresent(vestiging.ookGenoemd, forKey: .ookGenoemd)
                try container.encode(vestiging.links, forKey: .links)
            }
        }
    }
}

extension Naamgeving {
    public struct CommercieleVestiging: Codable, Equatable, Sendable {
        public let vestigingsnummer: String
        public let eersteHandelsnaam: String
        public let handelsnamen: [Handelsnaam]
        public let links: [Link]?
        
        private enum CodingKeys: String, CodingKey {
            case vestigingsnummer
            case eersteHandelsnaam
            case handelsnamen
            case links
        }
        
        public init(
            vestigingsnummer: String,
            eersteHandelsnaam: String,
            handelsnamen: [Handelsnaam],
            links: [Link]?
        ) {
            self.vestigingsnummer = vestigingsnummer
            self.eersteHandelsnaam = eersteHandelsnaam
            self.handelsnamen = handelsnamen
            self.links = links
        }
    }
}

extension Naamgeving {
    public struct NietCommercieleVestiging: Codable, Equatable, Sendable {
        public let vestigingsnummer: String
        public let naam: String
        public let ookGenoemd: String?
        public let links: [Link]?
        
        private enum CodingKeys: String, CodingKey {
            case vestigingsnummer
            case naam
            case ookGenoemd
            case links
        }
        
        public init(
            vestigingsnummer: String,
            naam: String,
            ookGenoemd: String? = nil,
            links: [Link]?
        ) {
            self.vestigingsnummer = vestigingsnummer
            self.naam = naam
            self.ookGenoemd = ookGenoemd
            self.links = links
        }
    }
}

extension Naamgeving {
    public struct Handelsnaam: Codable, Equatable, Sendable {
        public let naam: String
        public let volgorde: Int
        
        public init(
            naam: String,
            volgorde: Int
        ) {
            self.naam = naam
            self.volgorde = volgorde
        }
    }
}

extension Naamgeving {
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
extension Naamgeving {
    public struct VestigingLinks: Codable, Equatable, Sendable {
        public let vestigingsprofiel: Link
        
        public init(vestigingsprofiel: Link) {
            self.vestigingsprofiel = vestigingsprofiel
        }
    }
}

extension Naamgeving {
    public struct Error: Codable, Equatable, Sendable {
        public let fout: [Fout]?
        
        public init(fout: [Fout]? = nil) {
            self.fout = fout
        }
    }
}

extension Naamgeving {
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
