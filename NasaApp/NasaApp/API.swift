//
//  API.swift
//  NasaApp
//
//  Created by Chirag Sushilkumar Gehi on 31/01/23.
//

import SwiftUI
import CachedAsyncImage

struct Response: Codable {
    // Creating a Model for the JSON returned by API
    var date: String
    var explanation: String
    var hdurl: String
    var media_type: String
    var service_version: String
    var title: String
    var url: String
    
    static let alll = Response(date:"", explanation:"", hdurl: "", media_type: "", service_version: "", title: "", url: "")
}

struct API: View {
    @State var results =  Response.alll // Initializing the structure
    
    var datee: String // The date to be received to make append to the API
    
    var body: some View {
        VStack(alignment: .leading) {
            //The view structure for the API
            Text(results.title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color(hue: 0.672, saturation: 1.0, brightness: 1.0))
                .frame(height: 3.0)
            HStack(alignment: .center) {
                CachedAsyncImage(url: URL(string: results.url), transaction: Transaction(animation: .easeInOut)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .transition(.opacity)
                            .padding()
                    }
                    else {
                        HStack {
                            /*Color.blue
                             .frame(width: 200,
                             height: 100,
                             alignment: .center)*/
                        }
                    }
                }
            }
            Text(results.explanation)
                .padding()
            //Text(results.date)
        }
        .task {
            await loadData(var: datee)
        }
    }
    
    func loadData(var datee: String) async {
        //The function to load the data received by API into the model
        var urll = "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY" // The base url
        urll = urll + "&date=" + datee // Appending the string to the url
        guard let url = URL(string:
                                urll) else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url) //Creating url session
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from:data) {
                results = decodedResponse //decoding the JSON response
            }
        }
        catch {
            print("Invalid data")
        }
    }
}

struct API_Previews: PreviewProvider {
    static var previews: some View {
        API(datee: "")
    }
}
