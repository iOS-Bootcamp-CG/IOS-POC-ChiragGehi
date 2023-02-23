//
//  ContentView.swift
//  NasAPP13
//
//  Created by Chirag Sushilkumar Gehi on 29/01/23.
//

import SwiftUI



struct ContentView: View {
    
    @State var selectedDate: Date = Date() //the selected date from the calendar
    @State var dDate: String = "" // The selected date in String data type
    var appi = API( datee: "") //To get the saved dates from API struct
    //@State var tdate: [String] =  appi.tdate //UserDefaults.standard.stringArray(forKey: "DATE") ?? []
    
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
    let startingDate: Date = Calendar.current.date(from: DateComponents(year: 1995)) ?? Date()
    let endingDate: Date = Date()
    var body: some View {
        NavigationView {
            VStack {
                Text("Pick a Date")
                Text(dateFormatter.string(from: selectedDate)).font(.title)
                //self.dDate = self.fDate.string(from: self.selectedDate)
                DatePicker("Select a Date", selection: $selectedDate,
                           in: startingDate...endingDate, displayedComponents: [.date])
                    .accentColor(Color.red)
                    .datePickerStyle(
                        //CompactDatePickerStyle()
                        //WheelDatePickerStyle()
                        GraphicalDatePickerStyle()
                    )
                    .onChange(of: selectedDate) { newDate in
                        let ddaa = fDate.string(from: newDate)
                        dDate = ddaa
                        //print("onChange \(dDate)")
                        //var chi = getDate()
                        //print("getDate \(chi)")
                    }
                HStack {
                    NavigationLink {
                        //Text(dDate)
                        API(datee: dDate)
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
                    

                    /*Button {
                        tdate.append(dDate)
                        UserDefaults.standard.set(tdate, forKey: "DATE")
                        //tdate = tempd
                        var n = tdate.count
                        let _ = print(dDate)
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
                    }.padding()*/
                    
                    NavigationLink { //The Listing view to display the favourite date 
                        Listingg(arrr: appi.tdate)
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
