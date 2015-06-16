//
//  InformerView.swift
//  HumosInvasie
//
//  Created by MrSpijker on 15/06/15.
//  Copyright (c) 2015 Thorr Stevens. All rights reserved.
//

import UIKit

class InformerView: UIView {
    var activeInformer: UIWebView
    var informerNotificationString:String = ""
    
    var userFeedbackButton:UIButton
    var yoloJezusWebView:UIWebView
    var putinWebView:UIWebView
    
    var jezusIntructieView:UIImageView!
    var jezusInstructie:UIImage!
    
    var activeInstruction:UIImageView!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        self.userFeedbackButton = UIButton(frame: frame)
        self.yoloJezusWebView = UIWebView(frame: UIScreen.mainScreen().bounds);
        self.yoloJezusWebView.userInteractionEnabled = false;
        self.putinWebView = UIWebView(frame: UIScreen.mainScreen().bounds);
        self.yoloJezusWebView.userInteractionEnabled = false;
        self.activeInformer = UIWebView(frame: UIScreen.mainScreen().bounds);
        
        super.init(frame: frame)
        self.makeInformers()
        self.makePamphlets()
        self.userFeedbackButton.backgroundColor = UIColor.clearColor()
        self.addSubview(self.userFeedbackButton)
    }
    
    func makeInformers(){
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
    }
    
    func makePamphlets(){
        self.jezusInstructie = UIImage(named: "jezus_instructie")!
        self.jezusIntructieView = UIImageView(image: jezusInstructie)
        jezusIntructieView.frame = CGRectMake(
            (UIScreen.mainScreen().bounds.width - jezusInstructie.size.width/2)/2,
            -640,
            jezusInstructie.size.width/2,
            jezusInstructie.size.height/2)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addInformer(informer:String){
        self.informerNotificationString = informer
        if(informer == "jezus"){
            self.addSubview(self.yoloJezusWebView)
            self.activeInformer = self.yoloJezusWebView
            
            self.addSubview(self.jezusIntructieView)
            self.activeInstruction = self.jezusIntructieView
           
            let jezusRect:CGRect = CGRectMake(
                (UIScreen.mainScreen().bounds.width - self.jezusInstructie.size.width/2)/2,
                0,
                self.jezusInstructie.size.width/2,
                self.jezusInstructie.size.height/2)
            self.makeInstructionVisible(4,theFrame: jezusRect)
            
        }
        if(informer == "putin"){
            self.addSubview(self.putinWebView)
            self.activeInformer = self.putinWebView
        }

    }
    
    func removeInformerFromStage(){
        UIView.animateWithDuration(0.6, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.activeInformer.frame = CGRectMake(-640, 0, self.frame.width, self.frame.height)
            }, completion: {
                (value: Bool) in
                self.notifyComplete()
        });
    }
    
    func makeInstructionVisible(theDelay:Double, theFrame:CGRect){
        UIView.animateWithDuration(0.6, delay: theDelay, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.activeInstruction.frame = theFrame}, completion: {
                (value: Bool) in
                
        });
    }
    
    func notifyComplete(){
        println("animation complete")
        NSNotificationCenter.defaultCenter().postNotificationName(
            "INSTRUCTIONS_AGREED_UPON",
            object: self.informerNotificationString
        );

    }
    

}
