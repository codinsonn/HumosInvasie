//
//  UitlaatView.swift
//  NavigationTests
//
//  Created by Thorr Stevens on 05/06/15.
//  Copyright (c) 2015 Thorr Stevens. All rights reserved.
//

import UIKit

class UitlaatView: UIView, UITextFieldDelegate {
    
    var inputBgImage : UIImage!;
    var uitlaatBgImgView : UIImageView!;
    
    var characterHead : UIButton!;
    var showingInput : Int!;
    
    var inputField : UITextField!;
    var postButton : UIButton!;
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        //self.backgroundColor = UIColor.greenColor();
        
        println("[UitlaatView] Initialising View");
        
        self.inputBgImage = UIImage(named: "textInputBg");
        self.uitlaatBgImgView = UIImageView(image: inputBgImage);
        self.uitlaatBgImgView.frame = CGRect(x: 65, y: 60, width: 418, height: 210);
        self.addSubview(uitlaatBgImgView);
        self.uitlaatBgImgView.transform = CGAffineTransformScale(self.transform, 0.5, 0.5);
        self.uitlaatBgImgView.alpha = 0;
        
        self.characterHead = UIButton(frame: CGRect(x: -8, y: 230, width: 90, height: 90));
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
        
        self.inputField = UITextField();
        self.inputField.frame = CGRect(x: 130, y: 120, width: 320, height: 100);
        self.inputField.tintColor = UIColor.whiteColor();
        self.inputField.textColor = UIColor.whiteColor();
        self.inputField.contentVerticalAlignment = UIControlContentVerticalAlignment.Top;
        self.inputField.delegate = self;
        self.inputField.alpha = 0;
        self.addSubview(inputField);
        
        showingInput = 0;
        hideInput();
        
    }
    
    func postButtonTapped(){
        
        println("[UitlaatView] Post Button Tapped.");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            "POST_TAPPED",
            object: self.inputField
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
        
        let strUitlaat = self.inputField.text;
        
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
        
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            self.characterHead.frame = CGRectMake(-8, 10, 90, 90);
            self.uitlaatBgImgView.transform = CGAffineTransformTranslate(self.uitlaatBgImgView.transform, 0, -40);
            self.inputField.transform = CGAffineTransformTranslate(self.inputField.transform, 0, -40);
            
        }, completion: nil);
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.inputField.endEditing(true);
        
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            self.characterHead.frame = CGRectMake(-8, 40, 90, 90);
            self.uitlaatBgImgView.transform = CGAffineTransformTranslate(self.uitlaatBgImgView.transform, 0, 40);
            self.inputField.transform = CGAffineTransformTranslate(self.inputField.transform, 0, 40);
            
        }, completion: nil);
        
        showPostButtonIfValid(0.2);
        
        return false;
        
    }
    
    func showInput(){
        
        UIView.animateWithDuration(0.7, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            self.characterHead.frame = CGRectMake(-8, 40, 90, 90);
            
        }, completion: nil);
        
        UIView.animateWithDuration(0.5, delay: 0.3, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            self.uitlaatBgImgView.transform = CGAffineTransformScale(self.transform, 0.95, 0.95);
            self.uitlaatBgImgView.alpha = 1;
            
        }, completion: nil);
        
        UIView.animateWithDuration(0.4, delay: 0.8, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            self.inputField.alpha = 1;
            self.showPostButtonIfValid(0.8);
            
        }, completion: nil);
        
    }
    
    func hideInput(){
        
        self.inputField.endEditing(true);
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            self.inputField.alpha = 0;
            self.postButton.alpha = 0;
            
        }, completion: nil);
        
        UIView.animateWithDuration(0.4, delay: 0.1, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            self.uitlaatBgImgView.transform = CGAffineTransformScale(self.transform, 0.5, 0.5);
            self.uitlaatBgImgView.alpha = 0;
            
        }, completion: nil);
        
        UIView.animateWithDuration(0.7, delay: 0.2, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            self.characterHead.frame = CGRectMake(-8, 230, 90, 90);
            
        }, completion: nil);
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
