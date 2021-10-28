//
//  Model.swift
//  URLSessionChallenge
//
//  Created by Raymond Chen on 10/26/21.
//

import Foundation
import SwiftUI
import CoreData

class Model: ObservableObject {
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        let request: NSFetchRequest<StoredUser> = StoredUser.fetchRequest()
        let count = (try? context.fetch(request).count) ?? 0
        
        if count == 0 {
            loadData(completion: { users in
                var storedUserDict = [UUID: StoredUser]()
                
                users.forEach { user in
                    let storedUser = storedUserDict[user.id] ?? StoredUser(context: context)
                    storedUserDict[user.id] = storedUser
                    
                    storedUser.populate(from: user)
                    
                    user.friends.forEach { friend in
                        let storedFriend = storedUserDict[friend.id] ??
                        StoredUser(context: context)
                        storedUserDict[friend.id] = storedFriend
                        storedFriend.id = friend.id
                        storedUser.addToFriend(storedFriend)
                    }
                }
                try? context.save()
            })
        }
    }
}
