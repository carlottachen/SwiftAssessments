//
//  Book.swift
//  Bookshelf
//
//  Created by Carlotta Chen on 1/14/22.
//

import Foundation

class Book {
    
    init(bookTitle: String, authorName: String, coverImg: String, releaseYear: Int, description: String){
        self.bookTitle = bookTitle
        self.authorName = authorName
        self.coverImg = coverImg
        self.releaseYear = releaseYear
        self.description = description
    }
    let bookTitle: String
    let authorName: String
    let coverImg: String
    let releaseYear: Int
    let description: String
    
}
