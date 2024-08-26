import JavaScriptKit
import Schema
import TokamakShim

@main
struct TokamakApp: App {
    var body: some Scene {
        WindowGroup("Tokamak App") {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State private var cityName: String = ""
    @State private var city: City?

    var body: some View {
        VStack {
            TextField("Enter a city name...", text: $cityName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Fetch City") {
                fetchCity()
            }

            if let city {
                Text("City: \(city.description)")
            }
        }
    }

    private let _jsFetch = JSObject.global.fetch.function!
    private func fetchCity() {
        let url = "http://localhost:8080/cities/\(cityName)"
        JSPromise(_jsFetch(url).object!)!
    }
}
