//
//  ContentView.swift
//  Bookworm
//
//  Created by Raymond Chen on 10/19/21.
//

import SwiftUI
import CoreData

struct OneStarRatingBookTitleModifier: ViewModifier {
    
    let isOneStarRating: Bool
    
    func body(content: Content) -> some View {
        Group {
            if isOneStarRating {
                content
                    .foregroundColor(Color.red)
            } else {
                content
            }
        }
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.title, ascending: true),
        NSSortDescriptor(keyPath: \Book.author, ascending: true)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    
                    NavigationLink(destination: DetailView(book: book)) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                    .isOneStarRatingBook(book.rating == 1)
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationBarTitle("Bookworm")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showingAddScreen.toggle()
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddScreen) {
                AddBookView().environment(\.managedObjectContext, self.moc)
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in or our fetch request
            let book = books[offset]
            
            // delete it from the context
            moc.delete(book)
        }
        
        // save the context
        try? moc.save()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

extension View {
    
    func isOneStarRatingBook(_ bool: Bool) -> some View {
        modifier(OneStarRatingBookTitleModifier(isOneStarRating: bool))
    }
}
