//
//  CharacterCreatorView.swift
//  NavigationTests
//
//  Created by Thorr Stevens on 05/06/15.
//  Copyright (c) 2015 Thorr Stevens. All rights reserved.
//

import UIKit

class CharacterCreatorView: UIView, UITextFieldDelegate {
    
    var bodyPartsContainer:UIView!;
    var txtNickname:UITextField!;

    override init(frame: CGRect) {
        
        println("[CreatorView] Initialising View");
        
        super.init(frame: frame);
        
        //self.backgroundColor = UIColor.redColor();
        
        self.bodyPartsContainer = UIView(frame: frame);
        self.addSubview(bodyPartsContainer);
        
        let nameTag:UIImage = UIImage(named: "nameTag")!
        let nameTagView:UIImageView = UIImageView(image: nameTag)
        nameTagView.frame = CGRectMake(0, 0, nameTag.size.width/3, nameTag.size.height/3)
        self.addSubview(nameTagView)

        
        self.txtNickname = UITextField();
        self.txtNickname.frame = CGRect(x: 15, y: 30, width: 100, height: 25);
        self.txtNickname.tintColor = UIColor.blackColor();
        self.txtNickname.textColor = UIColor.redColor();
        self.txtNickname.backgroundColor = UIColor.whiteColor();
        self.txtNickname.contentVerticalAlignment = UIControlContentVerticalAlignment.Center;
        self.txtNickname.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center;
        self.txtNickname.text = "Nickname";
        self.txtNickname.delegate = self;
        self.txtNickname.alpha = 1;
        self.addSubview(self.txtNickname);
                
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.txtNickname.endEditing(true);
        
        return false;
        
    }

}
