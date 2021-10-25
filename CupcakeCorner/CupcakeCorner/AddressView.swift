//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Raymond Chen on 10/14/21.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order2
    var cupcakeInfo: CupcakeInfo
    
    @State private var name = ""
    @State private var streetAddress = ""
    @State private var city = ""
    @State private var zip = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $name)
                TextField("Street Address", text: $streetAddress)
                TextField("City", text: $city)
                TextField("Zip", text: $zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(order: order, cupcakeInfo: cupcakeInfo, address: Address(name: name, streetAddress: streetAddress, city: city, zip: zip))) {
                    Text("Check out")
                }.disabled(hasValidAddress == false)
            }
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
    
    var hasValidAddress: Bool {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedAddress = streetAddress.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedCity = city.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedZip = zip.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedName.isEmpty || trimmedAddress.isEmpty || trimmedCity.isEmpty || trimmedZip.isEmpty {
            return false
        }
        
        return true
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order2(), cupcakeInfo: CupcakeInfo(type: 0, quantity: 2, extraFrosting: false, addSprinkles: false))
    }
}
