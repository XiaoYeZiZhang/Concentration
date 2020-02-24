//
//  ViewController.swift
//  Concentration
//
//  Created by zhangye on 2020/2/24.
//  Copyright © 2020 zhangye. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var cardArray = ["😁","👺","👿","👹"]
    var flipCount = 0 {
        didSet {
            FlipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet var cardButtonArray: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNum = cardButtonArray.firstIndex(of: sender){
            flipCard(withEmoji: cardArray[cardNum], on: sender)
        }else {
            print("this button is not in the bottonArray")
        }
    }
    
    @IBOutlet weak var FlipCountLabel: UILabel!
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        //print("flipCard withEmoji \(emoji)")
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
    }
}

