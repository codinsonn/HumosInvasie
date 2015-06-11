//
//  QRReplaceImageView.swift
//  SlidingGood
//
//  Created by MrSpijker on 07/06/15.
//  Copyright (c) 2015 MrSpijker. All rights reserved.
//

import UIKit

class QRReplaceImageView: UIView {
    var myId:Int = 0
    var imageView:UIImageView = UIImageView()

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override var frame: CGRect {
        didSet {
            // Do stuff here
            self.imageView.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.hidden = true
    }
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeImage(url:String, avatar:QRReplaceImageModel){
        println("making image")
        self.myId = avatar.id
        
        let url = NSURL(string: url + String(avatar.imageUrl))
        println(url)
        let data = NSData(contentsOfURL: url!)
        let image = UIImage(data: data!)
        self.imageView = UIImageView(image: image)
        self.imageView.contentMode = UIViewContentMode.Center
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFit


        self.addSubview(imageView)
    }
    
    
    


}
