//
//  MainView.swift
//  NavigationTests
//
//  Created by Thorr Stevens on 05/06/15.
//  Copyright (c) 2015 Thorr Stevens. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    var bgImageView:UIImageView!;
    var bgImage:UIImage!;
    
    override init(frame: CGRect){
        
        super.init(frame: frame);
        
        self.bgImage = UIImage(named: "IntroScreenBg");
        self.bgImageView = UIImageView(image: self.bgImage);
        self.bgImageView.frame = frame;
        self.addSubview(self.bgImageView);
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateBackground(imageName:String) {
        
        self.bgImage = UIImage(named: imageName);
        self.bgImageView.image = self.bgImage;
        
    }

}
