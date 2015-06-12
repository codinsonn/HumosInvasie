//
//  CharacterData.swift
//  NavigationTests
//
//  Created by Thorr Stevens on 08/06/15.
//  Copyright (c) 2015 Thorr Stevens. All rights reserved.
//

import Foundation
import UIKit

class CharacterData: NSObject {
    
    var id:Int;
    var nickname:String;
    var char_img_id:Int;
    var head_preset_id:Int;
    var upper_body_preset_id:Int;
    var lower_body_preset_id:Int;
    var imageName:String;
    var image:UIImage!;
    
    override var description:String {
        get {
            return "[Character] \(nickname) - character_image: \(imageName)";
        }
    }
    
    init( id:Int, nickname:String, char_img_id:Int, head_preset_id:Int, upper_body_preset_id:Int, lower_body_preset_id:Int, imageName:String ) {
        
        self.id = id;
        self.nickname = nickname;
        self.char_img_id = char_img_id;
        self.head_preset_id = head_preset_id;
        self.upper_body_preset_id = upper_body_preset_id;
        self.lower_body_preset_id = lower_body_preset_id;
        self.imageName = imageName;
        
        self.image = ImageUploader.createImageFromUrlAndFilename("http://student.howest.be/thorr.stevens/20142015/MA4/BADGET/img/uploads/characters/", imgname: self.imageName);
        
        super.init();
        
    }
    
}