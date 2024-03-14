import Foundation
import SwiftUI

func fetchFortuneFromAPI(urlString: String) async throws -> Data? {
    guard let url = URL(string: urlString) else {
        print("Invalid URL")
        return nil
    }

    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    } catch {
        print("Error fetching data: \(error)")
        throw error
    }
}

struct FortuneResponseJSON: Codable {
    let content: String
    let role: String
    let functionCall: String
    let toolCalls: String
}

func fetchFortune(query: String) async -> String {
    do {
        print("try api with query \(query)")
//        guard let data = try await fetchFortuneFromAPI(urlString: "http://127.0.0.1:8000/fortune_chat/Love%20wins") else {
        guard let data = try await fetchFortuneFromAPI(urlString: "http://127.0.0.1:8000/fortune_chat/\(query)") else {
            print("Data is nil.")
            return "Default Message 1"
        }

        let json = try JSONSerialization.jsonObject(with: data, options: [])
        
        guard let dictionary = json as? [String: Any] else {
            print("JSON data couldn't be converted to a dictionary.")
            return "Default Message 2"
        }

        if let message = dictionary["message"] as? String {
            print("JSON indexed as dictionary: \(message)")
            return message
        } else {
            return "Failed dictionary conversion"
        }
    } catch {
        print("Error: \(error)")
        return "Default Message 4"
    }
}

@Observable
class Fortunes {
    var items = [FortuneItem]()
}

struct ContentView: View {
    @State private var fortunes = Fortunes()
    @State private var userQuery = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(fortunes.items, id: \.name) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iFortune")

            VStack {
                TextField("Ask anything", text: $userQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Get Fortune") {
                    let myQuery: String = userQuery
                    let fortune = FortuneItem(name: myQuery, type: "Personal", reply: "BLANK")
                    fortunes.items.append(fortune)
                    
                    Task {
                        print("the userQuery is: \(myQuery)")
                        
                        let fortuneResponse: String = await fetchFortune(query: myQuery)
                        let fortune2 = FortuneItem(name: fortuneResponse, type: "Personal", reply: "BLANK")
                        fortunes.items.append(fortune2)
                        print("Fortune response in the main app: \(fortuneResponse)")
                    }
                    userQuery = ""
                }
                .padding()
            }
        }
    }

    func removeItems(at offsets: IndexSet) {
        fortunes.items.remove(atOffsets: offsets)
    }
}

struct FortuneItem: Identifiable {
    var id = UUID()
    var name: String
    var type: String
    var reply: String
}

#Preview {
    ContentView()
}
