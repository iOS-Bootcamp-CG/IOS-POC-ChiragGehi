//
//  ContentView.swift
//  NasaApp
//
//  Created by Chirag Sushilkumar Gehi on 31/01/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedDate: Date = Date() //the selected date from the calendar
    @State var dDate: String = "" // The selected date in String data type
    @State var tdate: [String] = UserDefaults.standard.stringArray(forKey: "DATE") ?? [] // Array of saved favourite dates
    
    var dateFormatter: DateFormatter {
        //DateFormatter for date picker
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    var fDate: DateFormatter {
        // DateFormatter for the string format
        let ffDate = DateFormatter()
        ffDate.dateFormat = "YYYY-MM-dd"
        return ffDate
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("Pick a Date")
                Text(dateFormatter.string(from: selectedDate)).font(.title)
                DatePicker("Select a Date", selection: $selectedDate,    //Creating the Datepicker
                           displayedComponents: [.date])
                    .accentColor(Color.red)
                    .datePickerStyle(
                        //CompactDatePickerStyle()
                        //WheelDatePickerStyle()
                        GraphicalDatePickerStyle()
                    )
                    .onChange(of: selectedDate) { newDate in
                        let ddaa = fDate.string(from: newDate) // Converting the selected date in the string format
                        dDate = ddaa
                    }
                HStack {
                    NavigationLink {
                        API(datee: dDate) // Calling the API View with the selected date
                    } label: {
                        Text("APOD")
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
                    
                    Button {
                        tdate.append(dDate) // Saving the favourite the date in the array
                        UserDefaults.standard.set(tdate, forKey: "DATE")
                        var n = tdate.count
                        let _ = print(dDate)

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
                        Listingg(arrr: tdate) //The Listing view to display the favourite date 
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
