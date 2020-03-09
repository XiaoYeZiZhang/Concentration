//
//  Concentration.swift
//  Concentration
//
//  Created by zhangye on 2020/2/24.
//  Copyright © 2020 zhangye. All rights reserved.
//

import Foundation
struct Concentration {
    
    // TODO:(zhangye) improve this initialize function
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(numberOfPairsOfCards: \(numberOfPairsOfCards)): number of pairs of cards no more than zero")
        var range = Array<Int>()
        for rangeIndex in 0..<numberOfPairsOfCards*2 {
            range += [rangeIndex]
        }
        
        cards = [Card](repeating: Card(), count:numberOfPairsOfCards*2)
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            //because card is a struct, value based
            var randomIndex = range.count.randomValue
            
            cards[range[randomIndex]] = card
            range.remove(at: randomIndex)
            randomIndex = range.count.randomValue
            cards[range[randomIndex]] = card
            range.remove(at: randomIndex)
        }
    }
    
    
    
    private(set) var cards = Array<Card>()
    private var oneCardIsFacedUpIndexAndOnly: Int? {
        get {
            var oneCardFaceUpIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if oneCardFaceUpIndex == nil {
                        oneCardFaceUpIndex = index
                    }else {
                        return nil
                    }
                }
            }
            return oneCardFaceUpIndex
        }
        
        set(newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    
    // MARK: core function of Concentration
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at Index: \(index)): chosen index not in the card!" )
        if !cards[index].isMatched {
            if let facedUpCardIndex = oneCardIsFacedUpIndexAndOnly,index != facedUpCardIndex{
                // judge if match
                if cards[index] == cards[facedUpCardIndex] {
                    // matched
                    cards[index].isMatched = true
                    cards[facedUpCardIndex].isMatched = true
                }
                cards[index].isFaceUp = true
            }else {
                oneCardIsFacedUpIndexAndOnly = index
            }
        }
        
    }
}
