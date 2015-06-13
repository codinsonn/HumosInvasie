//
//  BodyPartViewController.swift
//  SlidingGood
//
//  Created by MrSpijker on 02/06/15.
//  Copyright (c) 2015 MrSpijker. All rights reserved.
//

import UIKit

class BodyPartViewController: UIViewController {
    
    let bodyParts:Array<BodyPart>;
    let frame:CGRect;
    let originalYpos:CGFloat
    var presetView:BodyPartView {
        get{
            return self.view as! BodyPartView;
        }
    }
    
    init( bodyParts:Array<BodyPart>, frame:CGRect, originalYpos:CGFloat){
        
        self.bodyParts = bodyParts;
        self.frame = frame;
        self.originalYpos = originalYpos
        super.init(nibName: nil, bundle: nil);
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        self.view = BodyPartView(frame: self.frame);
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.presetView.createBodyParts(self.bodyParts, frame: self.frame);

        let tap = UILongPressGestureRecognizer(target: self, action: "longPress:");
        
        self.presetView.panGestureRecognizer.requireGestureRecognizerToFail(tap);
        self.presetView.addGestureRecognizer(tap);
        
    }
    
    
    func longPress(sender:UILongPressGestureRecognizer){
        println("[BodyPartVC] Tapped");
        
        if (sender.state == UIGestureRecognizerState.Changed)
        {
            let view:UIView = sender.view!;
            
            // Location of the touch within the view.
            let point:CGPoint = sender.locationInView(view);
            
            // Calculate new X position based on the amount the gesture
            // has moved plus the size of the view we want to move.
            println(view.frame.origin.y )
            let newYLoc:CGFloat = (view.frame.origin.y + point.y) - (view.frame.size.height / 2);
            if(self.checkMaxMinMoveDistance(newYLoc)){
                view.frame = CGRectMake(view.frame.origin.x,
                    newYLoc,
                    view.frame.size.width,
                    view.frame.size.height);
            }
        }
    }
    
    func checkMaxMinMoveDistance(newLocY:CGFloat) -> Bool{
        let maxMoveDistance:CGFloat = 40
        println(newLocY)
        if(newLocY > 0 &&
            (newLocY + self.view.frame.height) < UIScreen.mainScreen().bounds.height &&
            newLocY < self.originalYpos + maxMoveDistance &&
            newLocY > self.originalYpos - maxMoveDistance
            ){
                return true
        }
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
