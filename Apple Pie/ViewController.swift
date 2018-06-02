//
//  ViewController.swift
//  Apple Pie
//
//  Created by Evan Nemetz on 6/1/18.
//  Copyright © 2018 Evan Nemetz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // List of words for user to guess
    var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program"]
    
    //  The number of incorrect moves allowed
    let incorrectMovesAllowed = 7
    
    //  Wins and losses
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
        newRound()
    }
    
    //  Reference to Game file
    var currentGame: Game!
    
    //  Establshes a new round
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRamining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        }else {
            enableLetterButtons(false)
        }
        let newWord = listOfWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRamining: incorrectMovesAllowed, guessedLetters: [])
        updateUI()
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    //  Handles interface updates
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord.characters {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        correctWordLabel.text = currentGame.formattedWord
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRamining)")
    }

    
    
    //  Outlets
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    // Actions for buttons
    @IBAction func buttonPressed(_ sender: UIButton) {
        //  This disables the button that is pressed
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateUI()
        updateGameState()
        
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRamining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord{
            totalWins += 1
        } else {
            updateUI()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

