//
//  BooksView.swift
//  Bookworm
//
//  Created by Mahmoud Fouad on 8/6/21.
//

import SwiftUI
import CoreData

struct BooksView: View {
    
    //MARK:- Wrapper attributes
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Book.entity(),
                  sortDescriptors: [
                    NSSortDescriptor(keyPath: \Book.title, ascending: true),
                    NSSortDescriptor(keyPath: \Book.author, ascending: true)
                  ]) var books: FetchedResults<Book>
    
    //MARK:- Properties
    @State private var showingAddScreen = false
    var body: some View {
        NavigationView {
            List {
                if books.isEmpty {
                    Text("No books available!")
                        .font(.title)
                }
                ForEach(books, id:\.self) { book in
                    NavigationLink(
                        destination: DetailView(book: book))
                    {
                        HStack {
                            Text(book.title ?? "Unknown")
                                .foregroundColor(book.rating == 1 ? .red : .black)
                            EmojiRatingView(rating: book.rating)
                        }
                    }
                }
                .onDelete(perform: deleteBooks(at:))
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
                    .environment(\.managedObjectContext, self.context)
            }
            .navigationBarTitle("Bookworm")
            .navigationBarItems(leading: EditButton()
                                    .disabled(books.isEmpty),
                                trailing: Button(action: {
                                    self.showingAddScreen.toggle()
                                }) {
                                    Image(systemName: "plus")
                                })
        }
    }
    
    //MARK:- Delete
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            context.delete(book)
        }
        try? context.save()
    }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        BooksView()
    }
}
