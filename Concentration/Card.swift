//
//  Card.swift
//  Concentration
//
//  Created by zhangye on 2020/2/24.
//  Copyright © 2020 zhangye. All rights reserved.
//

import Foundation

struct Card : Hashable {
    var isFaceUp = false;
    var isMatched = false;
    private var identifier: Int
    
    var hashable: Int  {
        return identifier
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    private static var id = 0
    private static func getUniqueIdentifier()->Int {
        id += 1
        return id
    }
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
