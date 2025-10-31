import Foundation
import Kamer_van_Koophandel_Models

public struct ZoekenV1: Codable, Equatable, Sendable {
  public let pagina: Int
  public let aantal: Int
  public let totaal: Int
  public let vorige: String?
  public let volgende: String?
  public let resultaten: [ResultaatItem]
  public let links: [Link]

  private enum CodingKeys: String, CodingKey {
    case pagina
    case aantal
    case totaal
    case vorige
    case volgende
    case resultaten
    case links
  }

  public init(
    pagina: Int,
    aantal: Int,
    totaal: Int,
    vorige: String? = nil,
    volgende: String? = nil,
    resultaten: [ResultaatItem],
    links: [Link]
  ) {
    self.pagina = pagina
    self.aantal = aantal
    self.totaal = totaal
    self.vorige = vorige
    self.volgende = volgende
    self.resultaten = resultaten
    self.links = links
  }
}

extension ZoekenV1 {
  public struct ResultaatItem: Codable, Equatable, Sendable {
    public let kvkNummer: Kamer_van_Koophandel_Models.Number
    public let rsin: String?
    public let vestigingsnummer: String?
    public let handelsnaam: String
    public let adresType: String?
    public let straatnaam: String?
    public let huisnummer: Int?
    public let huisnummerToevoeging: String?
    public let postcode: String?
    public let plaats: String?
    public let type: String
    public let actief: String
    public let vervallenNaam: String?
    public let links: [Link]

    private enum CodingKeys: String, CodingKey {
      case kvkNummer
      case rsin
      case vestigingsnummer
      case handelsnaam
      case adresType
      case straatnaam
      case huisnummer
      case huisnummerToevoeging
      case postcode
      case plaats
      case type
      case actief
      case vervallenNaam
      case links
    }

    public init(
      kvkNummer: Kamer_van_Koophandel_Models.Number,
      rsin: String? = nil,
      vestigingsnummer: String? = nil,
      handelsnaam: String,
      adresType: String? = nil,
      straatnaam: String? = nil,
      huisnummer: Int? = nil,
      huisnummerToevoeging: String? = nil,
      postcode: String? = nil,
      plaats: String? = nil,
      type: String,
      actief: String,
      vervallenNaam: String? = nil,
      links: [Link]
    ) {
      self.kvkNummer = kvkNummer
      self.rsin = rsin
      self.vestigingsnummer = vestigingsnummer
      self.handelsnaam = handelsnaam
      self.adresType = adresType
      self.straatnaam = straatnaam
      self.huisnummer = huisnummer
      self.huisnummerToevoeging = huisnummerToevoeging
      self.postcode = postcode
      self.plaats = plaats
      self.type = type
      self.actief = actief
      self.vervallenNaam = vervallenNaam
      self.links = links
    }
  }
}

extension ZoekenV1 {
  public struct Link: Codable, Equatable, Sendable {
    public let rel: String?
    public let href: String
    public let hreflang: String?
    public let media: String?
    public let title: String?
    public let type: String?
    public let deprecation: String?
    public let profile: String?
    public let name: String?

    public init(
      rel: String? = nil,
      href: String,
      hreflang: String? = nil,
      media: String? = nil,
      title: String? = nil,
      type: String? = nil,
      deprecation: String? = nil,
      profile: String? = nil,
      name: String? = nil
    ) {
      self.rel = rel
      self.href = href
      self.hreflang = hreflang
      self.media = media
      self.title = title
      self.type = type
      self.deprecation = deprecation
      self.profile = profile
      self.name = name
    }
  }
}

extension ZoekenV1 {
  public struct Error: Codable, Equatable, Sendable {
    public let fout: [Fout]?

    public init(fout: [Fout]? = nil) {
      self.fout = fout
    }
  }
}

extension ZoekenV1 {
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
