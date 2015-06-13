//
//  DraggableViewBackground.swift
//  SwiftTinderCards
//
//  Created by Lukasz Gandecki on 3/23/15.
//  Copyright (c) 2015 Lukasz Gandecki. All rights reserved.
//

import Foundation
import UIKit


class DraggableUitlaatContainer: UIView, DraggableUitlaatViewDelegate {
    
    let MAX_BUFFER_SIZE = 2;
    let CARD_HEIGHT = CGFloat(260.0);
    let CARD_WIDTH = CGFloat(320.0);
    
    let menuButton = UIButton()
    let messageButton = UIButton()
    let checkButton = UIButton()
    let xButton = UIButton()
    
    let exampleCardLabels = ["first", "second", "third", "fourth", "last"]
    var loadedCards = NSMutableArray()
    var allCards =  NSMutableArray()
    var cardsLoadedIndex = 0
    var numLoadedCardsCap = 0
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.layoutSubviews()
        setLoadedCardsCap()
        createCards()
        displayCards()
    }
    
    func setLoadedCardsCap() {
        numLoadedCardsCap = 0;
        if (exampleCardLabels.count > MAX_BUFFER_SIZE) {
            numLoadedCardsCap = MAX_BUFFER_SIZE
        } else {
            numLoadedCardsCap = exampleCardLabels.count
        }
        
    }
    
    func createCards() {
        if (numLoadedCardsCap > 0) {
            let cardFrame = CGRectMake((self.frame.size.width - CARD_WIDTH)/2, (self.frame.size.height - CARD_HEIGHT)/2 + 20, CARD_WIDTH, CARD_HEIGHT)
            
            for cardLabel in exampleCardLabels {
                var newCard = DraggableUitlaatView(frame: cardFrame, information: cardLabel)
                newCard.delegate = self;
                allCards.addObject(newCard)
            }
        }
    }

    func displayCards() {
        for(var i = 0; i < numLoadedCardsCap; i++) {
            loadACardAt(i)
        }
    }
    
    func cardSwipedLeft(card: DraggableUitlaatView) {
        processCardSwipe()
    }
    
    func cardSwipedRight(card: DraggableUitlaatView) {
        processCardSwipe()
    }

    
    func processCardSwipe() {
        loadedCards.removeObjectAtIndex(0)
        
        if (moreCardsToLoad()) {
            loadNextCard()
        }
    }
    
    func moreCardsToLoad() -> Bool {
        return cardsLoadedIndex < allCards.count;
    }
    
    func loadNextCard() {
        loadACardAt(cardsLoadedIndex)
    }
    
    func loadACardAt(index: Int) {
        loadedCards.addObject(allCards[index])
        if (loadedCards.count > 1) {
            insertSubview(loadedCards[loadedCards.count-1] as! DraggableUitlaatView, belowSubview: loadedCards[loadedCards.count-2] as! DraggableUitlaatView)
            // is there a way to define the array with UIView elements so I don't have to cast?
        } else {
            addSubview(loadedCards[0] as! DraggableUitlaatView)
        }
        cardsLoadedIndex++;
    }
    
    func swipeRight() {
        let dragView = loadedCards[0] as! DraggableUitlaatView
        print ("Clicked right")
        dragView.rightAction()
    }
    
    func swipeLeft() {
        let dragView = loadedCards[0] as! DraggableUitlaatView
        print ("clicked left")
        dragView.leftAction()
    }
    

    
}