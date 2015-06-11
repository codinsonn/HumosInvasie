//
//  UitlaatPostsFactory.swift
//  NavigationTests
//
//  Created by Thorr Stevens on 08/06/15.
//  Copyright (c) 2015 Thorr Stevens. All rights reserved.
//

import Foundation

class TourFactory: NSObject {
    
    class func createFromJSONData( data:NSData ) -> Array<UitlaatData> {
        
        var uitlaatArray = Array<UitlaatData>();
        
        let json = JSON(data: data);
        
        //println(json);
        
        for (i: String, subJSON: JSON) in json {
            
            let id = subJSON["id"];
            let character_id = subJSON["character_id"];
            let title = subJSON["title"];
            let message = subJSON["message"];
            let latitude = subJSON["latitude"];
            let longitude = subJSON["longitude"];
            let time_posted = subJSON["time_posted"];
            let score = subJSON["score"];
            let character = CharacterData(
                id: subJSON["character"]["id"].intValue,
                nickname: subJSON["character"]["nickname"].stringValue,
                char_img_id: subJSON["character"]["char_img_id"].intValue,
                head_preset_id: subJSON["character"]["head_preset_id"].intValue,
                upper_body_preset_id: subJSON["character"]["upper_body_preset_id"].intValue,
                lower_body_preset_id: subJSON["character"]["lower_body_preset_id"].intValue,
                imageName: subJSON["character"]["filename"].stringValue
            );
            
            let uitlaatData = UitlaatData(
                id: id.intValue,
                character_id: character_id.intValue,
                title: title.stringValue,
                message: message.stringValue,
                latitude: latitude.floatValue,
                longitude: longitude.floatValue,
                time_posted: time_posted.stringValue,
                score: score.intValue,
                character: character
            );
            
            uitlaatArray.append(uitlaatData);
            
        }
        
        return uitlaatArray;
        
    }
    
}