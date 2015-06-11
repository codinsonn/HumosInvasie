//
//  MainView.swift
//  NavigationTests
//
//  Created by Thorr Stevens on 05/06/15.
//  Copyright (c) 2015 Thorr Stevens. All rights reserved.
//

import UIKit
import Gifu

class MainView: UIView {
    
    var bgImageView:UIImageView!;
    var bgImage:UIImage!;
    var preloadAnim:AnimatableImageView!;
    
    override init(frame: CGRect){
        
        super.init(frame: frame);
        
        self.bgImage = UIImage(named: "IntroScreenBg");
        self.bgImageView = UIImageView(image: self.bgImage);
        self.bgImageView.frame = frame;
        self.addSubview(self.bgImageView);
        
        self.preloadAnim = AnimatableImageView(frame: frame);
        self.preloadAnim.animateWithImage(named: "LogoPreloader.gif");
        self.preloadAnim.startAnimating();
        self.preloadAnim.alpha = 1;
        self.addSubview(preloadAnim);
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dismissPreloader(){
        
        self.preloadAnim.stopAnimating();
        
        UIView.animateWithDuration(0.6, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            self.preloadAnim.alpha = 0;
            
        }, completion: nil);
        
        UIView.animateWithDuration(0.1, delay: 0.8, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            self.preloadAnim.removeFromSuperview();
            
        }, completion: nil);
        
    }
    
    func updateBackground(imageName:String) {
        
        self.bgImage = UIImage(named: imageName);
        self.bgImageView.image = self.bgImage;
        
    }

}
