//
//  DetailUserView.swift
//  Friendly
//
//  Created by Raymond Chen on 10/27/21.
//

import SwiftUI

struct MetadataView: View {
    
    let metadata: String
    let information: String
    
    var body: some View {
        HStack {
            Text(metadata)
                .font(.headline)
            Text(information)
                .font(.body)
        }
    }
}

struct DetailUserView: View {
    @EnvironmentObject var model: Model
    
    let user: StoredUser
    
    var body: some View {
        GeometryReader { g in
            ScrollView {
                VStack(alignment: .leading) {
                    MetadataView(metadata: "Company:", information: user.wrappedCompany)
                    MetadataView(metadata: "Age:", information: "\(Int(user.age))")
                    MetadataView(metadata: "Email:", information: user.wrappedEmail)
                    Text("About:")
                        .padding()
                        .font(.headline)
                    Text(user.wrappedAbout)
                    
                    List(user.wrappedFriends, id: \.id) { friend in
                        NavigationLink(
                            destination: DetailUserView(user: friend)) {
                                Text(friend.wrappedName)
                        }
                    }.frame(width: g.size.width - 5, height: g.size.height - 50, alignment: .center)
                }
            }
        }
        .navigationBarTitle(user.wrappedName)
        
    }
      
}


struct DetailUserView_Previews: PreviewProvider {
    static var users: [User] = Bundle.main.decode("mockfriend.json")
    
    static var storedUser: StoredUser {
        let storedUser = StoredUser()
        storedUser.populate(from: users.first!)
        return storedUser
    }
    
    static var previews: some View {
        DetailUserView(user: storedUser)
    }
}
