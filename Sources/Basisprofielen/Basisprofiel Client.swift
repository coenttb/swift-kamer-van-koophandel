import Foundation
import DependenciesMacros
import Kamer_van_Koophandel_Models
import Kamer_van_Koophandel_Shared

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

@DependencyClient
public struct Client: Sendable {
    @DependencyEndpoint
    public var get: @Sendable (
        _ kvkNummer: Kamer_van_Koophandel_Models.Number,
        _ geoData: Bool?
    ) async throws -> Basisprofiel
    
    @DependencyEndpoint
    public var getEigenaar: @Sendable (
        _ kvkNummer: Kamer_van_Koophandel_Models.Number,
        _ geoData: Bool?
    ) async throws -> Basisprofiel.Eigenaar
    
    @DependencyEndpoint
    public var getHoofdvestiging: @Sendable (
        _ kvkNummer: Kamer_van_Koophandel_Models.Number,
        _ geoData: Bool?
    ) async throws -> Basisprofiel.Vestiging
    
    @DependencyEndpoint
    public var getVestigingen: @Sendable (
        _ kvkNummer: Kamer_van_Koophandel_Models.Number
    ) async throws -> VestigingList
}

public struct VestigingList: Codable, Equatable, Sendable {
    public let kvkNummer: Kamer_van_Koophandel_Models.Number?
    public let aantalCommercieleVestigingen: Int
    public let aantalNietCommercieleVestigingen: Int
    public let totaalAantalVestigingen: Int
    public let vestigingen: [VestigingBasis]?
    public let links: [Basisprofiel.Link]?
    
    private enum CodingKeys: String, CodingKey {
        case kvkNummer
        case aantalCommercieleVestigingen
        case aantalNietCommercieleVestigingen
        case totaalAantalVestigingen
        case vestigingen
        case links = "links"
    }
    
    public init(
        kvkNummer: Kamer_van_Koophandel_Models.Number?,
        aantalCommercieleVestigingen: Int,
        aantalNietCommercieleVestigingen: Int,
        totaalAantalVestigingen: Int,
        vestigingen: [VestigingBasis]?,
        links: [Basisprofiel.Link]?
    ) {
        self.kvkNummer = kvkNummer
        self.aantalCommercieleVestigingen = aantalCommercieleVestigingen
        self.aantalNietCommercieleVestigingen = aantalNietCommercieleVestigingen
        self.totaalAantalVestigingen = totaalAantalVestigingen
        self.vestigingen = vestigingen
        self.links = links
    }
}

public struct VestigingBasis: Codable, Equatable, Sendable {
    public let vestigingsnummer: String
    public let kvkNummer: Kamer_van_Koophandel_Models.Number?
    public let eersteHandelsnaam: String?
    public let indHoofdvestiging: String?
    public let indAdresAfgeschermd: String?
    public let indCommercieleVestiging: String?
    public let volledigAdres: String?
    public let links: [Basisprofiel.Link]?
    
    private enum CodingKeys: String, CodingKey {
        case vestigingsnummer
        case kvkNummer
        case eersteHandelsnaam
        case indHoofdvestiging
        case indAdresAfgeschermd
        case indCommercieleVestiging
        case volledigAdres
        case links = "links"
    }
    
    public init(
        vestigingsnummer: String,
        kvkNummer: Kamer_van_Koophandel_Models.Number?,
        eersteHandelsnaam: String? = nil,
        indHoofdvestiging: String? = nil,
        indAdresAfgeschermd: String? = nil,
        indCommercieleVestiging: String? = nil,
        volledigAdres: String? = nil,
        links: [Basisprofiel.Link]?
    ) {
        self.vestigingsnummer = vestigingsnummer
        self.kvkNummer = kvkNummer
        self.eersteHandelsnaam = eersteHandelsnaam
        self.indHoofdvestiging = indHoofdvestiging
        self.indAdresAfgeschermd = indAdresAfgeschermd
        self.indCommercieleVestiging = indCommercieleVestiging
        self.volledigAdres = volledigAdres
        self.links = links
    }
}

public typealias AuthenticatedClient = _KvKAuthenticatedClient<
    API,
    API.Router,
    Client
>
