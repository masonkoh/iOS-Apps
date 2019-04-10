//
//  Concentration.swift
//  Standford-developing iOS11 Apps with Swift - 1
//
//  Created by Mason Ko on 2019-04-07.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
    func chooseCard(at index: Int)
    {
        if cards[index].isFaceUp
        {
            cards[index].isFaceUp = false
        } else {
            cards[index].isFaceUp = true
        }
    }
    
    init(numberOfPairsOfCards: Int)
    {
        for _ in 1...numberOfPairsOfCards
        {
            let card = Card()
            cards += [card, card]
        }
        // TODO: Shuffle the cards
        
        
    }
}
