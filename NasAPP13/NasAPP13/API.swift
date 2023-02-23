//
//  API.swift
//  NasAPP13
//
//  Created by Chirag Sushilkumar Gehi on 29/01/23.
//

import SwiftUI
import CachedAsyncImage

struct Response: Codable {
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
    @State var showLoading = false // Bool for showing the loading icon
    @State var tdate: [String] = UserDefaults.standard.stringArray(forKey: "DATE") ?? [] // To save the dates
    
    var datee: String // The date to be received to make append to the API

    var body: some View {
        ScrollView {
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
                if showLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    
                }
                
                HStack {
                    Button { //Saving the favourite date
                        tdate.append(datee)
                        UserDefaults.standard.set(tdate, forKey: "DATE")
                        //tdate = tempd
                        var n = tdate.count
                        let _ = print(datee)
                        //Listingg(arrr: tdate)
                    } label: {
                        Text("Save")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                Color.blue
                                    .cornerRadius(10)
                                    .shadow(radius: 10)
                            )
                    }.padding()
                    
                    NavigationLink {
                        Listingg(arrr: tdate)
                        //Text("F off")
                    } label: {
                        Text("View Saved")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                Color.blue
                                    .cornerRadius(10)
                                    .shadow(radius: 10)
                            )
                    }
                }
                
            }
        }
        .task {
            self.showLoading = true
            await loadData(var: datee)
            self.showLoading = false
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
        API(datee : "")
    }
}
