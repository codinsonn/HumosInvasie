//
//  UitlaatView.swift
//  NavigationTests
//
//  Created by Thorr Stevens on 05/06/15.
//  Copyright (c) 2015 Thorr Stevens. All rights reserved.
//

import UIKit
import Gifu

class UitlaatView: UIView, UITextFieldDelegate {
    
    var inputBgImage : UIImage!;
    var uitlaatBgImgView : UIImageView!;
    var charHeadBgImgAnim : AnimatableImageView!;
    
    var characterHead : UIButton!;
    var showingInput : Int!;
    
    var txtUitlaat : UITextField!;
    var postButton : UIButton!;
    
    var currentCharacterFrame : CGRect!;
    
    var uitlaatContainer : DraggableUitlaatContainer!;
    var addedContainerToSubview = false;
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        println("[UitlaatView] Initialising View");
        
        var uitlaatMsgs:Array<UitlaatData>! = [];
        self.uitlaatContainer = DraggableUitlaatContainer(frame: CGRectMake(100, 0, 368, 300), uitlaatMessages: uitlaatMsgs);
        self.addSubview(self.uitlaatContainer);
        
        self.inputBgImage = UIImage(named: "textInputBg");
        self.uitlaatBgImgView = UIImageView(image: inputBgImage);
        self.uitlaatBgImgView.frame = CGRect(x: 65, y: 60, width: 418, height: 210);
        self.addSubview(uitlaatBgImgView);
        self.uitlaatBgImgView.transform = CGAffineTransformScale(self.transform, 0.5, 0.5);
        self.uitlaatBgImgView.alpha = 0;
        
        self.charHeadBgImgAnim = AnimatableImageView(frame: CGRectMake(-12, 230, 100, 100));
        self.charHeadBgImgAnim.animateWithImage(named: "CharHeadBg.gif");
        self.charHeadBgImgAnim.alpha = 1;
        self.addSubview(charHeadBgImgAnim);
        
        self.currentCharacterFrame = CGRect(x: -8, y: 230, width: 90, height: 90);
        self.characterHead = UIButton(frame: self.currentCharacterFrame);
        self.characterHead.setTitle(" ", forState: .Normal);
        self.characterHead.setBackgroundImage(UIImage(named: "BatCat"), forState: .Normal);
        self.characterHead.addTarget(self, action: "characterHeadTapped", forControlEvents: .TouchUpInside);
        self.addSubview(characterHead);
        
        self.postButton = UIButton(frame: CGRect(x: 270, y: 226, width: 164, height: 30));
        self.postButton.setTitle("Laat van je horen", forState: .Normal);
        self.postButton.setTitleColor(ColorHelper.colorWithHexString("#6DCFF6"), forState: .Normal);
        self.postButton.backgroundColor = UIColor.whiteColor();
        self.postButton.addTarget(self, action: "postButtonTapped", forControlEvents: .TouchUpInside);
        self.postButton.alpha = 0;
        self.addSubview(postButton);
        
               
        self.txtUitlaat = UITextField();
        self.txtUitlaat.frame = CGRect(x: 130, y: 120, width: 320, height: 100);
        self.txtUitlaat.tintColor = UIColor.whiteColor();
        self.txtUitlaat.textColor = UIColor.whiteColor();
        self.txtUitlaat.sizeToFit();
        self.txtUitlaat.contentVerticalAlignment = UIControlContentVerticalAlignment.Top;
        self.txtUitlaat.delegate = self;
        self.txtUitlaat.alpha = 0;
        self.addSubview(txtUitlaat);
        
        showingInput = 0;
        
        
    }
    
    func updateUitlaatContainer(uitlaatPostsContainer:DraggableUitlaatContainer){
        
        if(self.addedContainerToSubview == false){
            
            self.uitlaatContainer = uitlaatPostsContainer;
            self.addSubview(self.uitlaatContainer);
            
            self.addedContainerToSubview = true;
            
        }else{
            
            self.uitlaatContainer.updateUitlaatMessages(uitlaatPostsContainer.uitlaatMessages);
            
        }
        
        hideInput();
        
    }
    
    func updateCharacterButton(image: UIImage){
        
        self.characterHead.frame = self.currentCharacterFrame;
        self.characterHead.setBackgroundImage(image, forState: .Normal);
        
    }
    
    func postButtonTapped(){
        
        println("[UitlaatView] Post Button Tapped.");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            "POST_TAPPED",
            object: self.txtUitlaat
        );
        
    }
    
    func characterHeadTapped(){
        
        if(showingInput == 0){
            
            showingInput = 1;
            showInput();
            
        }else{
            
            showingInput = 0;
            hideInput();
            
        }
        
    }
    
    func showPostButtonIfValid(delay:Double){
        
        let strUitlaat = self.txtUitlaat.text;
        
        if(count(strUitlaat) > 4){
            
            UIView.animateWithDuration(0.4, delay: delay, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.postButton.alpha = 1;
                
                }, completion: nil);
            
        }else{
            
            UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.postButton.alpha = 0;
                
                }, completion: nil);
            
        }
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        self.currentCharacterFrame = CGRectMake(-8, 10, 90, 266);
        
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            self.characterHead.frame = self.currentCharacterFrame;
            self.uitlaatBgImgView.transform = CGAffineTransformTranslate(self.uitlaatBgImgView.transform, 0, -40);
            self.txtUitlaat.transform = CGAffineTransformTranslate(self.txtUitlaat.transform, 0, -40);
            
            }, completion: nil);
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.txtUitlaat.endEditing(true);
        self.currentCharacterFrame = CGRectMake(-8, 40, 90, 266);
        
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            self.characterHead.frame = self.currentCharacterFrame;
            self.uitlaatBgImgView.transform = CGAffineTransformTranslate(self.uitlaatBgImgView.transform, 0, 40);
            self.txtUitlaat.transform = CGAffineTransformTranslate(self.txtUitlaat.transform, 0, 40);
            
            }, completion: nil);
        
        showPostButtonIfValid(0.2);
        
        return false;
        
    }
    
    func showInput(){
        
        self.currentCharacterFrame = CGRectMake(-8, 40, 90, 266);
        self.txtUitlaat.frame = CGRect(x: 130, y: 120, width: 320, height: 100);
        
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            self.charHeadBgImgAnim.alpha = 0;
            self.charHeadBgImgAnim.transform = CGAffineTransformMakeScale(0.4, 0.4);
            self.charHeadBgImgAnim.startAnimating();
            
            self.uitlaatContainer.alpha = 0;
            
            }, completion: nil);
        
        UIView.animateWithDuration(0.7, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            self.characterHead.frame = self.currentCharacterFrame;
            
            }, completion: nil);
        
        UIView.animateWithDuration(0.5, delay: 0.3, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            self.uitlaatBgImgView.transform = CGAffineTransformScale(self.transform, 0.95, 0.95);
            self.uitlaatBgImgView.alpha = 1;
            
            }, completion: nil);
        
        UIView.animateWithDuration(0.4, delay: 0.8, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            self.txtUitlaat.alpha = 1;
            self.showPostButtonIfValid(0.8);
            
            }, completion: nil);
        
    }
    
    func hideInput(){
        
        self.txtUitlaat.endEditing(true);
        self.currentCharacterFrame = CGRectMake(-8, 230, 90, 266);
        
        UIView.animateWithDuration(0.4, delay: 0.8, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            self.charHeadBgImgAnim.alpha = 1;
            self.charHeadBgImgAnim.transform = CGAffineTransformMakeScale(1, 1);
            self.charHeadBgImgAnim.startAnimating();
            
            self.uitlaatContainer.alpha = 1;
            
            }, completion: nil);
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            self.txtUitlaat.alpha = 0;
            self.postButton.alpha = 0;
            
            }, completion: nil);
        
        UIView.animateWithDuration(0.4, delay: 0.1, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            self.uitlaatBgImgView.transform = CGAffineTransformScale(self.transform, 0.5, 0.5);
            self.uitlaatBgImgView.alpha = 0;
            
            }, completion: nil);
        
        UIView.animateWithDuration(0.7, delay: 0.2, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            self.characterHead.frame = self.currentCharacterFrame;
            
            }, completion: nil);
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
