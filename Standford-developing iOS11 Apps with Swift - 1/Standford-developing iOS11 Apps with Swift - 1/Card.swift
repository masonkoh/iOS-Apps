//
//  Card.swift
//  Standford-developing iOS11 Apps with Swift - 1
//
//  Created by Mason Ko on 2019-04-07.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init()
    {
        self.identifier = Card.getUniqueIdentifier()
    }
}
