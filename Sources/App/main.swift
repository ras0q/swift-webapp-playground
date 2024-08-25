import Hummingbird

let router = Router()
var handler = AppHandler()

router.get("/cities/:cityName", use: handler.getCity)
router.post("/cities", use: handler.postCity)

let app = Application(
    router: router,
    configuration: .init(address: .hostname("0.0.0.0", port: 8080))
)

try await app.runService()
