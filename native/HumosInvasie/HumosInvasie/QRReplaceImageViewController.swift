//
//  QRReplaceImageViewController.swift
//  HumosInvasie
//
//  Created by Thorr Stevens on 10/06/15.
//  Copyright (c) 2015 Thorr Stevens. All rights reserved.
//

import UIKit

class QRReplaceImageViewController: UIViewController {
    var avatar:QRReplaceImageModel
    var url:String
    
    var theView: QRReplaceImageView!{
        get{
            return self.view as! QRReplaceImageView
        }
    }
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        //self.view = QRReplaceImageView(frame: )
        self.view = QRReplaceImageView(frame: CGRectMake(0, 0, 568, 568))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.theView.makeImage(self.url,avatar: self.avatar)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    init(avatar:QRReplaceImageModel,url:String){
        
        self.url = url
        self.avatar = avatar
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
