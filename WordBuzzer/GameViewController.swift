//
//  GameViewController.swift
//  WordBuzzer
//
//  Created by Nataly Tatarintseva on 10/21/18.
//  Copyright © 2018 Nataly Tatarintseva. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var playerFourButton: UIButton!
    @IBOutlet weak var playerThreeButton: UIButton!
    @IBOutlet weak var playerTwoButton: UIButton!
    @IBOutlet weak var playerOneButton: UIButton!
    @IBOutlet weak var labelOne: UILabel!
    
    @IBAction func unwindToGameScreen(segue:UIStoryboardSegue) {
    }
    
    var labelTwo: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerOneButton.backgroundColor = .cyan
        playerTwoButton.backgroundColor = .magenta
        playerThreeButton.backgroundColor = .yellow
        playerFourButton.backgroundColor = .blue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let y = self.view.frame.height / 2 + 25
        let x = -150
        labelTwo = UILabel(frame: CGRect(x: x, y: Int(y), width: 150, height: 27))
        labelTwo?.textAlignment = .right
        labelTwo?.text = "LabelTwo"
        labelTwo?.backgroundColor = .clear
        labelTwo?.font = UIFont.systemFont(ofSize: 22)
        labelTwo?.numberOfLines = 0
        labelTwo?.lineBreakMode = .byWordWrapping
        labelTwo?.sizeToFit()
        self.view.addSubview(labelTwo!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addAnimation()
    }
    
    func addAnimation() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 5.0, delay: 0.0, options: .curveEaseInOut, animations: {
                self.labelTwo?.center.x = self.view.frame.width + 150
                self.view.layoutIfNeeded()
            }, completion: { (finished: Bool) in
                
            })
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
