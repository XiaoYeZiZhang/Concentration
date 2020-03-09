//
//  ViewController.swift
//  Concentration
//
//  Created by zhangye on 2020/2/24.
//  Copyright © 2020 zhangye. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        get {
            return cardButtonArray.count / 2
        }
    }

    private(set) var flipCount = 0 {
        didSet {
            UpdateFlipCountLabel()
        }
    }
    
    private func UpdateFlipCountLabel() {
        let attributed : [NSAttributedString.Key : Any] = [
                .strokeWidth : 5.0,
                .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            ]
        
            let attrbutedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributed)
            FlipCountLabel.attributedText = attrbutedString
    }
    
    @IBOutlet private var cardButtonArray: [UIButton]!
    @IBOutlet private weak var FlipCountLabel: UILabel! {
        didSet {
            UpdateFlipCountLabel()
        }
    }
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNum = cardButtonArray.firstIndex(of: sender){
            game.chooseCard(at: cardNum)
            updateViewFromModel()
        }else {
            print("this button is not in the bottonArray")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtonArray.indices {
            let button = cardButtonArray[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else {
                button.setTitle("", for: UIControl.State.normal)
                if card.isMatched {
                    button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                }else {
                    button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                }
            
            }
        }
    }
    
    private var emojiDictionary = [Card:String]()
    private var emojiChoices = "👹👺👿😳😊☺️"
    private func emoji(for card: Card)->String{
        if emojiDictionary[card] == nil, emojiChoices.count > 0 {
            let stringRandomIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.randomValue)
            emojiDictionary[card] = String(emojiChoices.remove(at: stringRandomIndex))
        }
        return emojiDictionary[card] ?? "?"
    }
    
}

extension Int {
    var randomValue: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0 {
            return -1 * Int(arc4random_uniform(UInt32(abs(self))))
        }else {
            return 0
        }
    }
}

