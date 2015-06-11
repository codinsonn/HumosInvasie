//
//  KittenVisionView.swift
//  NavigationTests
//
//  Created by Thorr Stevens on 05/06/15.
//  Copyright (c) 2015 Thorr Stevens. All rights reserved.
//

import UIKit

class KittenVisionView: UIView {

    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        self.backgroundColor = UIColor.blueColor();
        
        println("[KittenView] Initialising View");
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
