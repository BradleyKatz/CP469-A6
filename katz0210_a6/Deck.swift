//
//  Deck.swift
//  katz0210_a6
//
//  Created by Bradley Katz on 2018-03-15.
//  Copyright © 2018 Bradley Katz. All rights reserved.
//

import Foundation

public class Deck
{
    private var cards: [NewsItemCard] = []
    
    public func getCardAt(index: Int) -> NewsItemCard
    {
        if !cards.isEmpty && index >= 0 && index <= cards.count
        {
            return cards[index]
        }
        else
        {
            fatalError("ERROR: Card index out of range")
        }
    }
    
    public func appendCard(card: NewsItemCard)
    {
        cards.append(card)
    }
    
    public func getSize() -> Int
    {
        return cards.count
    }
    
    public func deleteCardAt(index: Int)
    {
        if !cards.isEmpty && index >= 0 && index <= cards.count
        {
            cards.remove(at: index)
        }
        else
        {
            fatalError("ERROR: Card index out of range")
        }
    }
    
    public func isEmpty() -> Bool
    {
        return cards.isEmpty
    }
}
