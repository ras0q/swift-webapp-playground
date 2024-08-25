import Hummingbird
import MySQLKit

actor Handler {
    let database: MySQLDatabase

    init(database: MySQLDatabase) {
        self.database = database
    }

    struct City: ResponseCodable {
        let id: Int
        let name: String?
        let countryCode: String?
        let district: String?
        let population: String?

        init(id: Int = 0, name: String? = nil, countryCode: String? = nil, district: String? = nil, population: String? = nil) {
            self.id = id
            self.name = name
            self.countryCode = countryCode
            self.district = district
            self.population = population
        }

        init(row: MySQLRow) throws {
            guard let cityID = row.column("id")?.int else {
                throw HTTPError(.internalServerError, message: "City ID not found")
            }

            self.id = cityID
            self.name = row.column("Name")?.string
            self.countryCode = row.column("CountryCode")?.string
            self.district = row.column("District")?.string
            self.population = row.column("Population")?.string
        }
    }

    @Sendable
    func getCity(request: Request, context: BasicRequestContext) async throws -> City {
        guard let cityName = context.parameters.get("cityName") else {
            throw HTTPError(.badRequest, message: "City name not provided")
        }

        let query = database.query("SELECT * FROM city WHERE Name = ? LIMIT 1", [MySQLData(string: cityName)])
        guard let row = try await query.get().first else {
            throw HTTPError(.notFound, message: "City not found")
        }

        return try City(row: row)
    }

    struct PostCityRequest: Decodable {
        let name: String?
        let countryCode: String?
        let district: String?
        let population: String?
    }

    @Sendable
    func postCity(request: Request, context: BasicRequestContext) async throws -> City {
        let cityRequest = try await request.decode(as: City.self, context: context)

        let query = database.query("INSERT INTO city (Name, CountryCode, District, Population) VALUES (?, ?, ?, ?)", [
            MySQLData(string: cityRequest.name ?? ""),
            MySQLData(string: cityRequest.countryCode ?? ""),
            MySQLData(string: cityRequest.district ?? ""),
            MySQLData(string: cityRequest.population ?? "")
        ])
        guard let row = try await query.get().first else {
            throw HTTPError(.internalServerError, message: "Failed to insert city")
        }

        return try City(row: row)
    }
}
