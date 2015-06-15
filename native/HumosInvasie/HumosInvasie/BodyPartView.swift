//
//  BodyPartView.swift
//  SlidingGood
//
//  Created by MrSpijker on 02/06/15.
//  Copyright (c) 2015 MrSpijker. All rights reserved.
//

import UIKit

class BodyPartView: UIScrollView {
    let imagesArray = ["1","2","3","4"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createBodyParts(bodyParts:Array<BodyPart>, frame:CGRect){
        
        //println("[BodyPartView] --- createBodyParts --- ");
        
        self.frame = frame
        var xPosition = 0
        
        for bodyPart in bodyParts{
            let url = NSURL(string: "http://student.howest.be/thorr.stevens/20142015/MA4/BADGET/img/presets/" + bodyPart.fileName)
            let data = NSData(contentsOfURL: url!)
            let image = UIImage(data: data!)
            let imageView = UIImageView(image: image)
            imageView.frame = CGRectMake(CGFloat(xPosition), 0, frame.width, frame.height);
            imageView.contentMode = .ScaleAspectFit
            
            imageView.userInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: "tapped:");
            tap.numberOfTapsRequired = 2;
            
            imageView.addGestureRecognizer(tap);

            self.addSubview(imageView)
            xPosition += Int(imageView.bounds.width)
            //let pinch = UIPinchGestureRecognizer(target: self, action: "pinched:");
        }
        
        contentSize = CGSizeMake(CGFloat(xPosition),0);
        pagingEnabled = true;
        self.bounces = false;
        
    }
    
    func tapped(sender:UITapGestureRecognizer){
        println("tabbed");
    }

}
