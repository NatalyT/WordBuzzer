//
//  FinalViewController.swift
//  WordBuzzer
//
//  Created by Nataly Tatarintseva on 10/21/18.
//  Copyright © 2018 Nataly Tatarintseva. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {
    
    var correctAnswers: [Int]?
    
    @IBOutlet weak var playerOneResult: UILabel!
    @IBOutlet weak var playerFourResult: UILabel!
    @IBOutlet weak var playerThreeResult: UILabel!
    @IBOutlet weak var playerTwoResult: UILabel!
    
    @IBAction func playAgain(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToGameScreen", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let answers = correctAnswers {
            playerOneResult.text = "Player 1:\t\(answers[0])"
            playerTwoResult.text = "Player 2:\t\(answers[1])"
            playerThreeResult.text = "Player 3:\t\(answers[2])"
            playerFourResult.text = "Player 4:\t\(answers[3])"
        }
    }
    
}
