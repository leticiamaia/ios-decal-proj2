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
    var disabledButtons = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initGame()
    }
    
    func initGame() {
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        self.gamePhrase = phrase
        self.failedGuesses = 0
        self.guessedLetters.removeAll()
        for button in disabledButtons {
            button.enabled = true
        }
        disabledButtons.removeAll()
        updateUnderscoresLabelText()
        print(phrase)
    }
    
    @IBAction func didGuess(sender: UIButton) {
        let letterGuess = sender.currentTitle
        sender.enabled = false
        disabledButtons.append(sender)
        if self.gamePhrase!.characters.contains(Character(letterGuess!)) {
            guessedLetters.append(Character(letterGuess!))
            updateUnderscoresLabelText()
            checkGameWinCondition()
        } else {
            failedGuesses += 1
            if(failedGuesses > 6) {
                showEndGameAlert("Lost")
            } else {
                changeHangmanImage()
            }
        }
    }
    
    func checkGameWinCondition() {
        for letter in gamePhrase!.characters {
            if letter != " " && !guessedLetters.contains(letter) {
                return
            }
        }
        showEndGameAlert("Won")
    }
    
    func showEndGameAlert(gameEndStatus: String) {
        let alert = UIAlertController(title: "You " + gameEndStatus + "!", message:  "Click to play again or to go back to the menu.", preferredStyle: UIAlertControllerStyle.Alert)
        let playAgainAction = UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default) {
            (action: UIAlertAction) -> Void in self.initGame()
        }
        alert.addAction(playAgainAction)
        let goToMenuAction = UIAlertAction(title: "Menu", style: UIAlertActionStyle.Default) {
            (action: UIAlertAction) -> Void in self.dismissViewControllerAnimated(true, completion: nil)
        }
        alert.addAction(goToMenuAction)
        self.presentViewController(alert, animated: true, completion: nil)
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
