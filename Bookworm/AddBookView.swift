//
//  AddBookView.swift
//  Bookworm
//
//  Created by Mahmoud Fouad on 8/6/21.
//

import SwiftUI
import CoreData

struct AddBookView: View {
    //MARK: - Wrapper attributes
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationMode
    
    //MARK:- Properties
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = Genre.Fantasy
    @State private var review = ""
    private var isReadyToSave: Bool {
        !title.isEmpty && !author.isEmpty && !review.isEmpty
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(Genre.allCases, id:\.self) {
                            Text($0.text)
                        }
                    }
                }
                Section {
                    RatingView(rating: $rating)
                    TextField("Write a review", text: $review)
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(context: self.context)
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.rating = Int16(self.rating)
                        newBook.genre = self.genre.text
                        newBook.review = self.review
                        newBook.date = Date()
                        
                        try? self.context.save()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(!isReadyToSave)
                }
            }
            .navigationBarTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
