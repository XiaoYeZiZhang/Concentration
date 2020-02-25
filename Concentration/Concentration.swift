//
//  Concentration.swift
//  Concentration
//
//  Created by zhangye on 2020/2/24.
//  Copyright © 2020 zhangye. All rights reserved.
//

import Foundation

class Concentration {
    init(numerOfPairsOfCards: Int) {
        var range = Array<Int>()
        for rangeIndex in 0..<numerOfPairsOfCards*2 {
            range += [rangeIndex]
        }
        cards = [Card](repeating: Card(), count:numerOfPairsOfCards*2)
        for _ in 1...numerOfPairsOfCards {
            let card = Card()
            //because card is a struct, value based
            var randomIndex = (Int)(arc4random_uniform(UInt32(range.count)))
            
            cards[range[randomIndex]] = card
            range.remove(at: randomIndex)
            randomIndex = (Int)(arc4random_uniform(UInt32(range.count)))
            cards[range[randomIndex]] = card
            range.remove(at: randomIndex)
        }
    }
    
    var cards = Array<Card>()
    var oneCardIsFacedUpIndexAndOnly: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let facedUpCardIndex = oneCardIsFacedUpIndexAndOnly,index != facedUpCardIndex{
                // judge if match
                if cards[index].identifier == cards[facedUpCardIndex].identifier {
                    // matched
                    cards[index].isMatched = true
                    cards[facedUpCardIndex].isMatched = true
                }
                cards[index].isFaceUp = true
                oneCardIsFacedUpIndexAndOnly = nil
            }else {
                for cardIndex in cards.indices {
                    cards[cardIndex].isFaceUp = false;
                }
                cards[index].isFaceUp = true
                oneCardIsFacedUpIndexAndOnly = index
            }
        }
        
    }
}
