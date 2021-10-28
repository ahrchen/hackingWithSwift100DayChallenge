//
//  DetailUserView.swift
//  URLSessionChallenge
//
//  Created by Raymond Chen on 10/26/21.
//

import SwiftUI

struct DetailUserView: View {
//    @EnvironmentObject var model: Model
    
    let user: StoredUser
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DetailUserView_Previews: PreviewProvider {
    static var users: [User] = Bundle.main.decode("MockFriends.json")
    
    static var storedUser: StoredUser {
        let storedUser = StoredUser()
        storedUser.populate(from: users.first!)
        return storedUser
    }
    
    static var previews: some View {
        DetailUserView(user: storedUser)
    }
}
