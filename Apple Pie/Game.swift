//
//  Game.swift
//  Apple Pie
//
//  Created by Evan Nemetz on 6/2/18.
//  Copyright © 2018 Evan Nemetz. All rights reserved.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRamining: Int
    var guessedLetters: [Character]
    
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.characters.contains(letter) {
            incorrectMovesRamining -= 1
        }
    }
    
    var formattedWord: String {
        var guessedWord = ""
        for letter in word.characters {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
}


