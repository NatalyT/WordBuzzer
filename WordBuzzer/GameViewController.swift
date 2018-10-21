//
//  GameViewController.swift
//  WordBuzzer
//
//  Created by Nataly Tatarintseva on 10/21/18.
//  Copyright © 2018 Nataly Tatarintseva. All rights reserved.
//

import UIKit

struct WordToShow {
    var wordInLanguageOne: String
    var wordInLanguageTwo: String
    var wordToDisplay: String
}

class GameViewController: UIViewController {
    
    @IBOutlet weak var playerFourButton: UIButton!
    @IBOutlet weak var playerThreeButton: UIButton!
    @IBOutlet weak var playerTwoButton: UIButton!
    @IBOutlet weak var playerOneButton: UIButton!
    @IBOutlet weak var labelOne: UILabel!
    
    @IBAction func unwindToGameScreen(segue:UIStoryboardSegue) {
    }
    
    var labelTwo: UILabel?
    
    var wordsArrayFromJSON = [Word]()
    let amountOfWords: Int = 3
    var amountOfShownWords: Int = 0
    var wordToShow: WordToShow?
    var wordsToShowArray = [WordToShow]()
    var correctAnswers: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let w = Word.fetchJson() {
            wordsArrayFromJSON = w
        }
        
        playerOneButton.backgroundColor = .cyan
        playerTwoButton.backgroundColor = .magenta
        playerThreeButton.backgroundColor = .yellow
        playerFourButton.backgroundColor = .blue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        amountOfShownWords = 0
        correctAnswers = 0
        
        labelTwo = UILabel(frame: CGRect(x: -200, y: Int(self.view.frame.height / 2 + 25), width: 200, height: 27))
        labelTwo?.textAlignment = .right
        labelTwo?.text = "LabelTwo"
        labelTwo?.backgroundColor = .clear
        labelTwo?.font = UIFont.systemFont(ofSize: 22)
        labelTwo?.numberOfLines = 0
//        labelTwo?.sizeToFit()
        self.view.addSubview(labelTwo!)
        
        getWordsToShow()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.labelTwo?.removeFromSuperview()
    }
    
    func getWordsToShow() {
        labelOne.textColor = .gray
        labelTwo?.textColor = .gray
        if amountOfShownWords < amountOfWords {
            amountOfShownWords += 1
            getWordToShow()
        } else {
            performSegue(withIdentifier: "segueToFinalScene", sender: self)
        }
    }
    
    func getWordToShow() {
        var wordsArray = [Word]()
        var randomNumber = 0
        for _ in 0 ... 2 {
            randomNumber = Int.random(in: 0 ..< wordsArrayFromJSON.count)
            wordsArray.append(wordsArrayFromJSON[randomNumber])
        }
        wordsToShowArray = []
        for _ in 0 ... 2 {
            randomNumber = Int.random(in: 0 ... 2)
            wordToShow = WordToShow(wordInLanguageOne: wordsArray[0].text_eng ?? "", wordInLanguageTwo: wordsArray[0].text_spa ?? "", wordToDisplay: wordsArray[randomNumber].text_spa ?? "")
            wordsToShowArray.append(wordToShow!)
            print(wordToShow?.wordInLanguageOne as Any, "   ", wordToShow?.wordInLanguageTwo as Any, "   ", wordToShow?.wordToDisplay as Any)
        }
        showWord()
    }
    
    func showWord() {
        if wordsToShowArray.count > 0 {
            wordToShow = wordsToShowArray[0]
            wordsToShowArray.remove(at: 0)
            labelOne.text = wordToShow?.wordInLanguageOne
            labelTwo?.text = wordToShow?.wordToDisplay
            labelTwo?.frame = CGRect(x: -200, y: Int(self.view.frame.height / 2 + 25), width: 200, height: 27)
//            self.view.layoutIfNeeded()
            self.addAnimation()
        }
    }
    
    func addAnimation() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 5.0, delay: 0.0, options: .curveEaseInOut, animations: {
                self.labelTwo?.center.x = self.view.frame.width + 200
//                self.view.layoutIfNeeded()
            }, completion: { (finished: Bool) in
                self.showWord()
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
