//
//  Listingg.swift
//  NasaApp
//
//  Created by Chirag Sushilkumar Gehi on 31/01/23.
//

import SwiftUI

struct Listingg: View {
    //The view to display the favourite dates
    @State var arrr = [String]()
    
    var body: some View {
        VStack {
            Text("Favourite Dates")
                .font(.system(size: 25, weight: .bold))
            ForEach(arrr, id: \.self) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item)
                            .font(.headline)
                    }
                    Spacer()
                    Image(systemName:"heart.fill" )
                        .foregroundColor(.red)
                }
                .padding()
            }
            Spacer()
        }

    }
}

struct Listingg_Previews: PreviewProvider {
    static var previews: some View {
        Listingg()
    }
}
