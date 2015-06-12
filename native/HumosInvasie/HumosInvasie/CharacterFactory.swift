//
//  CharacterFactory.swift
//  HumosInvasie
//
//  Created by Thorr Stevens on 11/06/15.
//  Copyright (c) 2015 Thorr Stevens. All rights reserved.
//

import Foundation

class CharacterFactory: NSObject {
    
    class func createCharacterFromJSONData( data:NSData ) -> CharacterData {
        
        let json = JSON(data: data);
        
        println(json);
            
        let id = json["id"];
        let nickname = json["nickname"];
        let char_img_id = json["char_img_id"];
        let head_preset_id = json["head_preset_id"];
        let upper_body_preset_id = json["torso_preset_id"];
        let lower_body_preset_id = json["legs_preset_id"];
        let imageName = json["filename"];
            
        let characterData = CharacterData(
            id: id.intValue,
            nickname: nickname.stringValue,
            char_img_id: char_img_id.intValue,
            head_preset_id: head_preset_id.intValue,
            upper_body_preset_id: upper_body_preset_id.intValue,
            lower_body_preset_id: lower_body_preset_id.intValue,
            imageName: imageName.stringValue
        );
        
        return characterData;
        
    }
    
}