import Foundation

public struct Vestigingsprofiel: Codable, Equatable, Sendable {
  public let vestigingsnummer: String
  public let kvkNummer: Kamer_van_Koophandel_Models.Number
  public let rsin: String?
  public let indNonMailing: String?
  public let formeleRegistratiedatum: String?
  public let materieleRegistratie: MaterieleRegistratie?
  public let statutaireNaam: String?
  public let eersteHandelsnaam: String?
  public let indHoofdvestiging: String?
  public let indCommercieleVestiging: String?
  public let voltijdWerkzamePersonen: Int?
  public let totaalWerkzamePersonen: Int?
  public let deeltijdWerkzamePersonen: Int?
  public let handelsnamen: [Handelsnaam]?
  public let adressen: [Adres]?
  public let websites: [String]?
  public let sbiActiviteiten: [SBIActiviteit]?
  public let links: [Link]?

  private enum CodingKeys: String, CodingKey {
    case vestigingsnummer
    case kvkNummer
    case rsin
    case indNonMailing
    case formeleRegistratiedatum
    case materieleRegistratie
    case statutaireNaam
    case eersteHandelsnaam
    case indHoofdvestiging
    case indCommercieleVestiging
    case voltijdWerkzamePersonen
    case totaalWerkzamePersonen
    case deeltijdWerkzamePersonen
    case handelsnamen
    case adressen
    case websites
    case sbiActiviteiten
    case links = "_links"
  }

  public init(
    vestigingsnummer: String,
    kvkNummer: Kamer_van_Koophandel_Models.Number,
    rsin: String? = nil,
    indNonMailing: String? = nil,
    formeleRegistratiedatum: String? = nil,
    materieleRegistratie: MaterieleRegistratie? = nil,
    statutaireNaam: String? = nil,
    eersteHandelsnaam: String? = nil,
    indHoofdvestiging: String? = nil,
    indCommercieleVestiging: String? = nil,
    voltijdWerkzamePersonen: Int? = nil,
    totaalWerkzamePersonen: Int? = nil,
    deeltijdWerkzamePersonen: Int? = nil,
    handelsnamen: [Handelsnaam]? = nil,
    adressen: [Adres]? = nil,
    websites: [String]? = nil,
    sbiActiviteiten: [SBIActiviteit]? = nil,
    links: [Link]? = nil
  ) {
    self.vestigingsnummer = vestigingsnummer
    self.kvkNummer = kvkNummer
    self.rsin = rsin
    self.indNonMailing = indNonMailing
    self.formeleRegistratiedatum = formeleRegistratiedatum
    self.materieleRegistratie = materieleRegistratie
    self.statutaireNaam = statutaireNaam
    self.eersteHandelsnaam = eersteHandelsnaam
    self.indHoofdvestiging = indHoofdvestiging
    self.indCommercieleVestiging = indCommercieleVestiging
    self.voltijdWerkzamePersonen = voltijdWerkzamePersonen
    self.totaalWerkzamePersonen = totaalWerkzamePersonen
    self.deeltijdWerkzamePersonen = deeltijdWerkzamePersonen
    self.handelsnamen = handelsnamen
    self.adressen = adressen
    self.websites = websites
    self.sbiActiviteiten = sbiActiviteiten
    self.links = links
  }
}

extension Vestigingsprofiel {
  public struct MaterieleRegistratie: Codable, Equatable, Sendable {
    public let datumAanvang: String?
    public let datumEinde: String?

    public init(
      datumAanvang: String? = nil,
      datumEinde: String? = nil
    ) {
      self.datumAanvang = datumAanvang
      self.datumEinde = datumEinde
    }
  }
}

extension Vestigingsprofiel {
  public struct GeoData: Codable, Equatable, Sendable {
    public let addresseerbaarObjectId: String?
    public let nummerAanduidingId: String?
    public let gpsLatitude: Double?
    public let gpsLongitude: Double?
    public let rijksdriehoekX: Double?
    public let rijksdriehoekY: Double?
    public let rijksdriehoekZ: Double?

    public init(
      addresseerbaarObjectId: String? = nil,
      nummerAanduidingId: String? = nil,
      gpsLatitude: Double? = nil,
      gpsLongitude: Double? = nil,
      rijksdriehoekX: Double? = nil,
      rijksdriehoekY: Double? = nil,
      rijksdriehoekZ: Double? = nil
    ) {
      self.addresseerbaarObjectId = addresseerbaarObjectId
      self.nummerAanduidingId = nummerAanduidingId
      self.gpsLatitude = gpsLatitude
      self.gpsLongitude = gpsLongitude
      self.rijksdriehoekX = rijksdriehoekX
      self.rijksdriehoekY = rijksdriehoekY
      self.rijksdriehoekZ = rijksdriehoekZ
    }
  }
}

extension Vestigingsprofiel {
  public struct Adres: Codable, Equatable, Sendable {
    public let type: String
    public let indAfgeschermd: String?
    public let volledigAdres: String?
    public let straatnaam: String?
    public let huisnummer: Int?
    public let huisletter: String?
    public let huisnummerToevoeging: String?
    public let toevoegingAdres: String?
    public let postcode: String?
    public let postbusnummer: Int?
    public let plaats: String?
    public let straatHuisnummer: String?
    public let postcodeWoonplaats: String?
    public let regio: String?
    public let land: String?
    public let geoData: GeoData?

    public init(
      type: String,
      indAfgeschermd: String? = nil,
      volledigAdres: String? = nil,
      straatnaam: String? = nil,
      huisnummer: Int? = nil,
      huisletter: String? = nil,
      huisnummerToevoeging: String? = nil,
      toevoegingAdres: String? = nil,
      postcode: String? = nil,
      postbusnummer: Int? = nil,
      plaats: String? = nil,
      straatHuisnummer: String? = nil,
      postcodeWoonplaats: String? = nil,
      regio: String? = nil,
      land: String? = nil,
      geoData: GeoData? = nil
    ) {
      self.type = type
      self.indAfgeschermd = indAfgeschermd
      self.volledigAdres = volledigAdres
      self.straatnaam = straatnaam
      self.huisnummer = huisnummer
      self.huisletter = huisletter
      self.huisnummerToevoeging = huisnummerToevoeging
      self.toevoegingAdres = toevoegingAdres
      self.postcode = postcode
      self.postbusnummer = postbusnummer
      self.plaats = plaats
      self.straatHuisnummer = straatHuisnummer
      self.postcodeWoonplaats = postcodeWoonplaats
      self.regio = regio
      self.land = land
      self.geoData = geoData
    }
  }
}

extension Vestigingsprofiel {
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

extension Vestigingsprofiel {
  public struct SBIActiviteit: Codable, Equatable, Sendable {
    public let sbiCode: String
    public let sbiOmschrijving: String
    public let indHoofdactiviteit: String

    public init(
      sbiCode: String,
      sbiOmschrijving: String,
      indHoofdactiviteit: String
    ) {
      self.sbiCode = sbiCode
      self.sbiOmschrijving = sbiOmschrijving
      self.indHoofdactiviteit = indHoofdactiviteit
    }
  }
}

extension Vestigingsprofiel {
  public struct Link: Codable, Equatable, Sendable {
    public let href: String
    public let hreflang: String?
    public let title: String?
    public let type: String?
    public let deprecation: String?
    public let profile: String?
    public let name: String?
    public let templated: Bool?

    public init(
      href: String,
      hreflang: String? = nil,
      title: String? = nil,
      type: String? = nil,
      deprecation: String? = nil,
      profile: String? = nil,
      name: String? = nil,
      templated: Bool? = nil
    ) {
      self.href = href
      self.hreflang = hreflang
      self.title = title
      self.type = type
      self.deprecation = deprecation
      self.profile = profile
      self.name = name
      self.templated = templated
    }
  }
}
