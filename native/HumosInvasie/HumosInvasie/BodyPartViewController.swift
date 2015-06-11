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
    
    var presetView:BodyPartView {
        get{
            return self.view as! BodyPartView;
        }
    }
    
    init( bodyParts:Array<BodyPart>, frame:CGRect){
        
        self.bodyParts = bodyParts;
        self.frame = frame;
        
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
