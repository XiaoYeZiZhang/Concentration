//
//  ViewController.swift
//  Concentration
//
//  Created by zhangye on 2020/2/24.
//  Copyright © 2020 zhangye. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numerOfPairsOfCards: cardButtonArray.count / 2)

    var flipCount = 0 {
        didSet {
            FlipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet var cardButtonArray: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNum = cardButtonArray.firstIndex(of: sender){
            game.chooseCard(at: cardNum)
            updateViewFromModel()
        }else {
            print("this button is not in the bottonArray")
        }
    }
    
    func updateViewFromModel() {
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
    
    var emojiDictionary = [Int:String]()
    var emojiChoices = ["👹","👺","👿","😳","😊","☺️"]
    
    func emoji(for card: Card)->String{
        if emojiDictionary[card.identifier] == nil, emojiChoices.count > 0 {
            let emojiIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emojiDictionary[card.identifier] = emojiChoices.remove(at: emojiIndex)
        }
        return emojiDictionary[card.identifier] ?? "?"
    }
    
    @IBOutlet weak var FlipCountLabel: UILabel!
}

