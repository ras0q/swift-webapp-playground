import Hummingbird

actor AppHandler {
    // TODO: switch to Database
    var cities: [String:City] = [
        "Tokyo": City(id: 1, name: "Tokyo", CountryCode: "JPN", District: "Kanto", Population: "1000000"),
    ]

    struct City: ResponseCodable {
        let id: Int
        let name: String?
        let CountryCode: String?
        let District: String?
        let Population: String?
    }

    @Sendable
    func getCity(request: Request, context: BasicRequestContext) async throws -> City {
        guard let cityName = context.parameters.get("cityName") else {
            throw HTTPError(.badRequest, message: "City name not provided")
        }

        guard let city = cities[cityName] else {
            throw HTTPError(.notFound, message: "City Not Found")
        }

        return city
    }

    @Sendable
    func postCity(request: Request, context: BasicRequestContext) async throws -> City {
        let city = try await request.decode(as: City.self, context: context)
        guard let cityName = city.name else {
            throw HTTPError(.badRequest, message: "City name not provided")
        }

        cities[cityName] = city

        return city
    }
}
