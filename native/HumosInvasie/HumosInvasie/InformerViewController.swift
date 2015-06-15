//
//  InformerViewController.swift
//  HumosInvasie
//
//  Created by MrSpijker on 15/06/15.
//  Copyright (c) 2015 Thorr Stevens. All rights reserved.
//


import UIKit

class InformerViewController: UIViewController {
    var yoloJezusWebView:UIWebView
    var putinWebView:UIWebView
    var userFeedbackButton:UIButton
    var theView:InformerView {
        get{
            return self.view as! InformerView;
        }
    }

    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.yoloJezusWebView = UIWebView(frame: UIScreen.mainScreen().bounds);
        self.putinWebView = UIWebView(frame: UIScreen.mainScreen().bounds);
        self.userFeedbackButton = UIButton(frame: UIScreen.mainScreen().bounds)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func userFeedbackGiven(){
        println("feedback given")
    }
    
    override func loadView() {
        self.view = InformerView()
    }
    
    override func viewDidLoad() {
        
        var jezusPath = NSBundle.mainBundle().pathForResource("Jesus_568x320_once", ofType: "gif");
        let yoloJezusGif = NSData(contentsOfFile: jezusPath!);
        self.yoloJezusWebView.scalesPageToFit = true
        self.yoloJezusWebView.opaque = false
        self.yoloJezusWebView.backgroundColor = UIColor.clearColor()
        self.yoloJezusWebView.loadData(yoloJezusGif, MIMEType: "image/gif", textEncodingName: nil, baseURL: nil);
        
        var putinPath = NSBundle.mainBundle().pathForResource("Putin_568x320_once", ofType: "gif");
        let putinGif = NSData(contentsOfFile: putinPath!);
        self.putinWebView.scalesPageToFit = true
        self.putinWebView.opaque = false
        self.putinWebView.backgroundColor = UIColor.clearColor()
        self.putinWebView.loadData(putinGif, MIMEType: "image/gif", textEncodingName: nil, baseURL: nil);
        
        self.userFeedbackButton.backgroundColor = UIColor.blackColor()
        //self.userFeedbackButton.alpha = 0
        self.userFeedbackButton.addTarget(self, action: "userFeedbackGiven", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.userFeedbackButton)
    }
    
    func addInformer(informer:String){
        if (informer == "jezus"){
            self.view.addSubview(self.yoloJezusWebView)
        }
        if (informer == "putin"){
            self.view.addSubview(self.putinWebView)
        }
    }
    
    
    

}
