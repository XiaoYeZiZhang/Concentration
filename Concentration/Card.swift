//
//  Card.swift
//  Concentration
//
//  Created by zhangye on 2020/2/24.
//  Copyright © 2020 zhangye. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false;
    var isMatched = false;
    var identifier: Int
    
    static var id = 0
    static func getUniqueIdentifier()->Int {
        id += 1
        return id
    }
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
