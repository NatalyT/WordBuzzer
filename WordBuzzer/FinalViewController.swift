//
//  FinalViewController.swift
//  WordBuzzer
//
//  Created by Nataly Tatarintseva on 10/21/18.
//  Copyright © 2018 Nataly Tatarintseva. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {
    
    @IBOutlet weak var playerOneResult: UILabel!
    @IBOutlet weak var playerFourResult: UILabel!
    @IBOutlet weak var playerThreeResult: UILabel!
    @IBOutlet weak var playerTwoResult: UILabel!
    
    @IBAction func playAgain(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToGameScreen", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
