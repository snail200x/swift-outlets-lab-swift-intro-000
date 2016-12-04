//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    let numberOfColorsToMatch:Int = 3
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    @IBAction func btnRedAction(_ sender: Any) {
        simonSaysGame.guessRed()
        isWin()
    }
    
    @IBAction func btnGreenAction(_ sender: Any) {
        simonSaysGame.guessGreen()
        isWin()
    }

    @IBAction func btnYellowAction(_ sender: Any) {
        simonSaysGame.guessYellow()
        isWin()
    }
    
    @IBAction func btnBlueAction(_ sender: Any) {
        simonSaysGame.guessBlue()
        isWin()
    }
    
    func isWin() {
        buttonsClicked += 1
        if buttonsClicked == numberOfColorsToMatch {
            
            if simonSaysGame.wonGame() {
                winLabel.text = "You Win!"
            } else {
                winLabel.text = "You lose, please try again"
            }
            winLabel.isHidden = false
        }
        print(buttonsClicked)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        
        displayTheColors()
    }
    
    fileprivate func displayTheColors() {
        self.view.isUserInteractionEnabled = false
        UIView.transition(with: displayColorView, duration: 1.5, options: .transitionCurlUp, animations: {
            self.displayColorView.backgroundColor = self.simonSaysGame.nextColor()?.colorToDisplay
            self.displayColorView.alpha = 0.0
            self.displayColorView.alpha = 1.0
            }, completion: { _ in
                if !self.simonSaysGame.sequenceFinished() {
                    self.displayTheColors()
                } else {
                    self.view.isUserInteractionEnabled = true
                    print("Pattern to match: \(self.simonSaysGame.patternToMatch)")
                }
        })
    }
}
