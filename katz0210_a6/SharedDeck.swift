//
//  SharedDeck.swift
//  katz0210_a6
//
//  Created by Bradley Katz on 2018-03-15.
//  Copyright © 2018 Bradley Katz. All rights reserved.
//

import Foundation

class SharedDeck
{
    private static let instance = SharedDeck()
    
    private var deck: Deck
    
    private init()
    {
        self.deck = Deck()
    }
    
    public static func isEmpty() -> Bool
    {
        return SharedDeck.instance.deck.isEmpty()
    }
    
    public static func getSize() -> Int
    {
        return SharedDeck.instance.deck.getSize()
    }
    
    public static func appendCard(card: NewsItemCard)
    {
        SharedDeck.instance.deck.appendCard(card: card)
    }
    
    public static func deleteCardAt(index: Int)
    {
        SharedDeck.instance.deck.deleteCardAt(index: index)
    }
    
    public static func getCardAt(index: Int) -> NewsItemCard
    {
        return SharedDeck.instance.deck.getCardAt(index: index)
    }
}
