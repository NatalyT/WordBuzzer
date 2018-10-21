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
    
    @IBAction func tapPlayerOneButton(_ sender: Any) {
        handleButtonTap(buttonTag: playerOneButton.tag)
    }
    
    @IBAction func tapPlayerTwoButton(_ sender: Any) {
        handleButtonTap(buttonTag: playerTwoButton.tag)
    }
    
    @IBAction func tapPlayerThreeButton(_ sender: Any) {
        handleButtonTap(buttonTag: playerThreeButton.tag)
    }
    
    @IBAction func tapPlayerFourButton(_ sender: Any) {
        handleButtonTap(buttonTag: playerFourButton.tag)
    }
    
    var labelTwo: UILabel?
    
    var wordsArrayFromJSON = [Word]()
    let amountOfWords: Int = 5
    var amountOfShownWords: Int = 0
    var wordToShow: WordToShow?
    var wordsToShowArray = [WordToShow]()
    var correctAnswers = [Int]()
    var showNextWord: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let w = Word.fetchJson() {
            wordsArrayFromJSON = w
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        amountOfShownWords = 0
        correctAnswers = []
        for _ in 0 ... 3 {
            correctAnswers.append(0)
        }
        
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
    
    func handleButtonTap(buttonTag: Int) {
        showNextWord = true
        if let w = self.wordToShow {
            let correctAnswer = self.isCorrectAnswer(word: w)
            updateUIView(correctAnswer: correctAnswer, buttonTag: buttonTag)
        }
    }
    
    func updateUIView(correctAnswer: Bool, buttonTag: Int) {
        playerOneButton.isEnabled = false
        playerTwoButton.isEnabled = false
        playerThreeButton.isEnabled = false
        playerFourButton.isEnabled = false
        playerOneButton.backgroundColor = .gray
        playerTwoButton.backgroundColor = .gray
        playerThreeButton.backgroundColor = .gray
        playerFourButton.backgroundColor = .gray
        if correctAnswer {
            labelOne.textColor = .green
            labelTwo?.textColor = .green
            self.correctAnswers[buttonTag] += 1
        } else {
            labelOne.textColor = .red
            labelTwo?.textColor = .red
            self.correctAnswers[buttonTag] -= 1
        }
    }
    
    func getWordsToShow() {
        if amountOfShownWords < amountOfWords {
            amountOfShownWords += 1
            getWordToShow()
        } else {
            performSegue(withIdentifier: "segueToFinalScreen", sender: self)
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
        }
        showWord()
    }
    
    func showWord() {
        labelOne.textColor = .gray
        labelTwo?.textColor = .gray
        playerOneButton.isEnabled = true
        playerTwoButton.isEnabled = true
        playerThreeButton.isEnabled = true
        playerFourButton.isEnabled = true
        playerOneButton.backgroundColor = .cyan
        playerTwoButton.backgroundColor = .magenta
        playerThreeButton.backgroundColor = .yellow
        playerFourButton.backgroundColor = .blue
        
        if wordsToShowArray.count > 0 {
            wordToShow = wordsToShowArray[0]
            wordsToShowArray.remove(at: 0)
            labelOne.text = wordToShow?.wordInLanguageOne
            labelTwo?.text = wordToShow?.wordToDisplay
            labelTwo?.frame = CGRect(x: -200, y: Int(self.view.frame.height / 2 + 25), width: 200, height: 27)
            self.addAnimation()
        } else {
            getWordsToShow()
        }
    }
    
    func addAnimation() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 5.0, delay: 0.0, options: .curveEaseInOut, animations: {
                self.labelTwo?.center.x = self.view.frame.width + 200
            }, completion: { (finished: Bool) in
                if self.showNextWord {
                    self.showNextWord = false
                    self.getWordsToShow()
                } else {
                    self.showWord()
                }
            })
        }
    }
    
    func isCorrectAnswer(word: WordToShow) -> Bool {
        return word.wordInLanguageTwo == word.wordToDisplay
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToFinalScreen" {
            if let destinationVC = segue.destination as? FinalViewController {
                destinationVC.correctAnswers = correctAnswers
            }
        }
    }
}
