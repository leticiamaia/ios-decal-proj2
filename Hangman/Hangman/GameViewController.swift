//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var hangmanImageView: UIImageView!
    @IBOutlet weak var underscoresLabel: UILabel!
    var gamePhrase: String?
    var guessedLetters = [Character]()
    var failedGuesses = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        self.gamePhrase = phrase
        self.failedGuesses = 0
        self.guessedLetters.removeAll()

        updateUnderscoresLabelText()
        print(phrase)
    }
    
    @IBAction func didGuess(sender: UIButton) {
        let letterGuess = sender.currentTitle
        sender.enabled = false
        if self.gamePhrase!.characters.contains(Character(letterGuess!)) {
            removeUnderscores(letterGuess!)
        } else {
            failedGuesses += 1
            if(failedGuesses > 6) {
                //end game
                print(failedGuesses)
            } else {
                changeHangmanImage()
            }
        }
    }
    
    func removeUnderscores(letterGuess: String) {
        guessedLetters.append(Character(letterGuess))
        updateUnderscoresLabelText()

    }
    
    func changeHangmanImage() {
        let newImageName = "hangman" + String(failedGuesses+1) + ".gif"
        hangmanImageView.image = UIImage(named: newImageName)
    }
    
    func updateUnderscoresLabelText() {
        var labelText = ""
        
        for letter in gamePhrase!.characters {
            if letter != " " {
                if self.guessedLetters.contains(letter) {
                    labelText += String(letter)
                    labelText += "  "
                } else {
                    labelText += "_  "
                }
            } else {
                labelText += "  "
            }
            
        }
        underscoresLabel.text = labelText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
