//
//  Genre.swift
//  Bookworm
//
//  Created by Mahmoud Fouad on 8/7/21.
//

import Foundation

enum Genre: Int, CaseIterable {
    case Fantasy = 0
    case Horror
    case Kids
    case Mystery
    case Poetry
    case Thriller
    
    init(type: Int) {
        switch type {
        case 0: self = .Fantasy
        case 1: self = .Horror
        case 2: self = .Kids
        case 3: self = .Mystery
        case 4: self = .Poetry
        default:
            self = .Thriller
        }
    }
    
    var text: String {
        switch self {
        case .Fantasy:
            return "Fantasy".uppercased()
        case .Horror:
            return "Horror".uppercased()
        case .Kids:
            return "Kids".uppercased()
        case .Mystery:
            return "Mystery".uppercased()
        case .Poetry:
            return "Poetry".uppercased()
        default:
            return "Thriller".uppercased()
        }
    }
}
