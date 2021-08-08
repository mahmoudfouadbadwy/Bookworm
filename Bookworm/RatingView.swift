//
//  RatingView.swift
//  Bookworm
//
//  Created by Mahmoud Fouad on 8/6/21.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    var label = ""
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1) { number in
                self.image(for: number)
                    .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                    .onTapGesture {
                        self.rating = number
                    }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        number > rating ? offImage ?? onImage : onImage
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
