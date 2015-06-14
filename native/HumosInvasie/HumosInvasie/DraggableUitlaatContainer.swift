//
//  DraggableViewBackground.swift
//  SwiftTinderCards
//
//  Created by Lukasz Gandecki on 3/23/15.
//  Copyright (c) 2015 Lukasz Gandecki. All rights reserved.
//
//  Edited to DraggableUitlaatContainer.swift
//  Edit by Thorr Stevens on 13/06/15 for HumosInvasie
//

import Foundation
import UIKit


class DraggableUitlaatContainer: UIView, DraggableUitlaatViewDelegate {
    
    let MAX_BUFFER_SIZE = 1
    let CARD_HEIGHT = CGFloat(260.0)
    let CARD_WIDTH = CGFloat(320.0)
    
    let menuButton = UIButton()
    let messageButton = UIButton()
    let checkButton = UIButton()
    let xButton = UIButton()
    
    var loadedCards = NSMutableArray()
    var allCards:Array<DraggableUitlaatView>!;
    var cardsLoadedIndex = 0
    var numLoadedCardsCap = 0
    
    var uitlaatMessages:Array<UitlaatData>!;
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, uitlaatMessages: Array<UitlaatData>) {
        
        super.init(frame: frame);
        super.layoutSubviews();
        
        self.allCards = Array<DraggableUitlaatView>();
        
        self.updateUitlaatMessages(uitlaatMessages);
        
    }
    
    func updateUitlaatMessages(uitlaatMessages: Array<UitlaatData>){
        
        self.uitlaatMessages = uitlaatMessages;
        
        setLoadedCardsCap();
        createCards();
        displayCards();
        
    }
    
    func setLoadedCardsCap() {
        
        numLoadedCardsCap = 0;
        
        if (self.uitlaatMessages.count > MAX_BUFFER_SIZE) {
            numLoadedCardsCap = MAX_BUFFER_SIZE
        } else {
            numLoadedCardsCap = self.uitlaatMessages.count
        }
        
    }
    
    func createCards() {
        
        if (numLoadedCardsCap > 0) {
            
            let cardFrame = CGRectMake((self.frame.size.width - CARD_WIDTH)/2, (self.frame.size.height - CARD_HEIGHT)/2 + 20, CARD_WIDTH, CARD_HEIGHT);
            
            for uitlaatData in self.uitlaatMessages {
                
                var doesExist = false;
                for(var i = 0; i < self.allCards.count; i++) {
                    if(self.allCards[i].uitlaatData.id == uitlaatData.id){
                        println("[DragUitlaatVC] Card exists");
                        doesExist = true;
                    }
                }
                
                if(doesExist == false){
                    var newCard = DraggableUitlaatView(frame: cardFrame, uitlaatData: uitlaatData);
                    newCard.delegate = self;
                    self.allCards.append(newCard);
                }
                
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
        loadedCards.removeObjectAtIndex(0);
        
        NSUserDefaults.standardUserDefaults().setInteger(self.uitlaatMessages[0].id, forKey: "lastSwipedUitlaatId");
        NSUserDefaults.standardUserDefaults().synchronize();
        
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
            insertSubview(loadedCards[loadedCards.count-1] as! DraggableUitlaatView, belowSubview: loadedCards[loadedCards.count-2] as! DraggableUitlaatView);
        } else {
            addSubview(loadedCards[0] as! DraggableUitlaatView);
            //addSubview(loadedCards[0] as! DraggableUitlaatView);
        }
        cardsLoadedIndex++;
    }
    
    func swipeRight() {
        let dragView = loadedCards[0] as! DraggableUitlaatView
        print ("[DragUitlaatVC] Swiped right")
        dragView.rightAction()
    }
    
    func swipeLeft() {
        let dragView = loadedCards[0] as! DraggableUitlaatView
        print ("[DragUitlaatVC] Swiped left")
        dragView.leftAction()
    }
    
    
    
}