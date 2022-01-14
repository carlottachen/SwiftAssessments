//
//  BookController.swift
//  Bookshelf
//
//  Created by Carlotta Chen on 1/14/22.
//

import Foundation

class BookController {
    static var books: [Book] {
        return [
            Book(bookTitle: "1984", authorName: "George Orwell", coverImg: "1984", releaseYear: 1948, description: "1984 tells the futuristic story of a dystopian, totalitarian world where free will and love are forbidden. Although the year 1984 has long since passed, the prophecy of a society controlled by fear and lies is arguably more relevant now than ever."),
            Book(bookTitle: "The Lord of the Rings", authorName: "J.R.R. Tolkien", coverImg: "LordOfTheRings", releaseYear: 1954, description: "Tolkien’s fantasy epic is one of the top must-read books out there. Set in Middle Earth – a world full of hobbits, elves, orcs, goblins, and wizards – The Lord of the Rings will take you on an unbelievable adventure."),
            Book(bookTitle: "The Kite Runner", authorName: "Khaled Hosseini", coverImg: "KiteRunner", releaseYear: 2003, description: "The Kite Runner is a moving story of an unlikely friendship between a wealthy boy and the son of his father’s servant. Set in Afghanistan during a time of tragedy and destruction, this unforgettable novel will have you hooked from start to finish."),
            Book(bookTitle: "Harry Potter and the Philosopher’s Stone", authorName: "J.K. Rowling", coverImg: "harrypotter", releaseYear: 1997, description: "This global bestseller took the world by storm. So, if you haven’t read J.K. Rowling’s Harry Potter, now may be the time. Join Harry Potter and his schoolmates as this must-read book transports you deep into a world of magic and monsters."),
            Book(bookTitle: "The Lion, the Witch, and the Wardrobe", authorName: "C.S. Lewis", coverImg: "lionWitch", releaseYear: 1950, description: "The Lion, The Witch, and the Wardrobe is undoubtedly one of the great books of all time. This renowned fantasy novel is set in Narnia, home to mythical beasts, talking animals, and warring kingdoms. The story follows a group of school children as they become entangled in this incredible world’s fate."),
            Book(bookTitle: "To Kill a Mockingbird", authorName: "Harper Lee", coverImg: "killMockingBird", releaseYear: 1960, description: "To Kill a Mockingbird is one of the top must-read books of all time. Published in 1960, the story explores life in the Deep South during the early 20th century through the story of a man accused of a terrible crime. It’s poignant, humorous, and gripping.")
        ]
    }
}
