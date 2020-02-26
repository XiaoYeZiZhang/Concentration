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
            FlipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet private var cardButtonArray: [UIButton]!
    @IBOutlet private weak var FlipCountLabel: UILabel!
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
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    private var emojiDictionary = [Int:String]()
    private var emojiChoices = ["👹","👺","👿","😳","😊","☺️"]
    private func emoji(for card: Card)->String{
        if emojiDictionary[card.identifier] == nil, emojiChoices.count > 0 {
            emojiDictionary[card.identifier] = emojiChoices.remove(at: emojiChoices.count.randomValue)
        }
        return emojiDictionary[card.identifier] ?? "?"
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

