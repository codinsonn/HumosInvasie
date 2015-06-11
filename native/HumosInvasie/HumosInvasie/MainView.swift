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
    var preloadWebView:UIWebView!;
    
    override init(frame: CGRect){
        
        super.init(frame: frame);
        
        self.bgImage = UIImage(named: "IntroScreenBg");
        self.bgImageView = UIImageView(image: self.bgImage);
        self.bgImageView.frame = frame;
        self.addSubview(self.bgImageView);
        
        var filePath = NSBundle.mainBundle().pathForResource("LogoPreloader", ofType: "gif");
        var gif = NSData(contentsOfFile: filePath!);
        self.preloadWebView = UIWebView(frame: frame);
        self.preloadWebView.loadData(gif, MIMEType: "image/gif", textEncodingName: nil, baseURL: nil);
        self.addSubview(preloadWebView);
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dismissPreloader(){
        
        UIView.animateWithDuration(0.8, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            self.preloadWebView.alpha = 0;
            
        }, completion: nil);
        
        UIView.animateWithDuration(0.1, delay: 0.8, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            self.preloadWebView.removeFromSuperview();
            
        }, completion: nil);
        
    }
    
    func updateBackground(imageName:String) {
        
        self.bgImage = UIImage(named: imageName);
        self.bgImageView.image = self.bgImage;
        
    }

}
