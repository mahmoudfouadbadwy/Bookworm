//
//  DetailView.swift
//  Bookworm
//
//  Created by Mahmoud Fouad on 8/7/21.
//

import SwiftUI
import CoreData

struct DetailView: View {
    //MARK: - wrapper attributs
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationMode
    
    //MARK: - Properties
    let book: Book
    @State private var showingDeleteAlert = false
    private var bookDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        return formatter.string(from: book.date ?? Date())
    }
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre?.capitalized ?? "Fantasy")
                        .frame(maxWidth: geo.size.width)
                    
                    Text(self.book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -10, y: -5)
                }
                
                Text(self.book.author ?? "Unknown")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Text(self.book.review ?? "No review")
                    .padding()
                
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                
                Text(bookDate)
                    .font(.body)
                    .padding()
            }
        }
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete"),
                  message: Text("Are you sure you want to delete?"),
                  primaryButton: .default(Text("Delete"), action: {
                    deleteBook()
                  }), secondaryButton: .cancel())
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert.toggle()
        }, label: {
           Image(systemName: "trash")
        }))
    }
    
    private func deleteBook() {
        context.delete(book)
        try? context.save()
        self.presentationMode.wrappedValue.dismiss()
    }
}
    
struct DetailView_Previews: PreviewProvider {
    static let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let book = Book(context: context)
        book.title = ""
        book.author = ""
        book.genre = ""
        book.rating = 4
        book.review = ""
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}
