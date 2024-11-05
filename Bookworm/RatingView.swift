//
//  RatingView.swift
//  Bookworm
//
//  Created by Mahmoud Fouad on 8/6/21.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    private var label = ""
    
    init(rating: Binding<Int>, label: String = "") {
        self._rating = rating
        self.label = label
    }
    
    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            
            ForEach(1...5 , id: \.self) { number in
                Image(systemName: "star.fill")
                    .foregroundColor(number > self.rating ?  Color.gray : Color.yellow)
                    .onTapGesture {
                        self.rating = number
                    }
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
