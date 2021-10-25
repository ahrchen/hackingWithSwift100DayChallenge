//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Raymond Chen on 10/14/21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order2
    var cupcakeInfo: CupcakeInfo
    var address: Address
    
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var showingError = false
    @State private var failedMessage = ""
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    Text("Your total is $\(self.order.orderInfo.cupcakeInfo.cost, specifier: "%.2f")")
                    
                    Button("Place Order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
            .alert(isPresented: $showingConfirmation) {
                Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
            }
            .alert(isPresented: $showingError) {
                Alert(title: Text("Sorry!"), message: Text(failedMessage), dismissButton: .default(Text("OK")))
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .onAppear(perform: {
            order.orderInfo = OrderInfo(cupcakeInfo: cupcakeInfo, address: address)
        })
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                self.failedMessage = "No data in response: \(error?.localizedDescription ?? "Unknown error")."
                self.showingError = true
                return
            }
            if let decodedOrder = try? JSONDecoder().decode(Order2.self, from: data) {
                self.confirmationMessage = "Your order for \(decodedOrder.orderInfo.cupcakeInfo.quantity)x \(Order.types[decodedOrder.orderInfo.cupcakeInfo.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            } else {
                print("Invalid response from server")
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order2(), cupcakeInfo: CupcakeInfo(type: 0, quantity: 2, extraFrosting: false, addSprinkles: false), address: Address(name: "", streetAddress: "", city: "", zip: ""))
    }
}
