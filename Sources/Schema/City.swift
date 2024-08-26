import Hummingbird
import MySQLKit

public struct City: ResponseCodable {
    public let id: Int
    public let name: String?
    public let countryCode: String?
    public let district: String?
    public let population: String?

    public init(id: Int = 0, name: String? = nil, countryCode: String? = nil, district: String? = nil, population: String? = nil) {
        self.id = id
        self.name = name
        self.countryCode = countryCode
        self.district = district
        self.population = population
    }
}

// MARK: - MySQLRow Conversion

extension City {
    public init(row: MySQLRow) throws {
        guard let cityID = row.column("ID")?.int else {
            throw HTTPError(.internalServerError, message: "City ID not found")
        }

        self.id = cityID
        self.name = row.column("Name")?.string
        self.countryCode = row.column("CountryCode")?.string
        self.district = row.column("District")?.string
        self.population = row.column("Population")?.string
    }
}
