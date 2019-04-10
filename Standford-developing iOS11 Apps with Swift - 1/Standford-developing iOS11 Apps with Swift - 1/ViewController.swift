//
//  ViewController.swift
//  Standford-developing iOS11 Apps with Swift - 1
//
//  Created by Mason Ko on 2019-04-07.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game: Concentration = Concentration(numberOfPairsOfCards: cardButtons.count + 1 / 2)
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            print("card pressed: \(cardNumber)")
        } else {
            print("chosen card was not in cardButtons")
        }
        
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
            
            
        }
    }
    
    var emojiChoices: [String] = ["🎃","👻","🎃","👻","🎃","👻","🎃","👻","🎃"]
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
//        if emoji[card.identifier] != nil
//        {
//            return emoji[card.identifier]!
//        } else {
//            return "?"
//        }
        if emoji[card.identifier] == nil
        {
            
        }
        return emoji[card.identifier] ?? "?" // exactly same as above lines
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

