//
//  WelcomeViewController.swift
//  WordBuzzer
//
//  Created by Nataly Tatarintseva on 10/21/18.
//  Copyright © 2018 Nataly Tatarintseva. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeLabel.text = "Welcome" + "\n" + "to" + "\n" + "WordBuzzer"
    }


}

