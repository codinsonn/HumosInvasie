//
//  UitlaatData.swift
//  NavigationTests
//
//  Created by Thorr Stevens on 08/06/15.
//  Copyright (c) 2015 Thorr Stevens. All rights reserved.
//

import Foundation

class UitlaatData: NSObject {
    
    var id:Int;
    var character_id:Int;
    var title:String;
    var message:String;
    var latitude:Float;
    var longitude:Float;
    var time_posted:String;
    var score:Int;
    var character:CharacterData;
    
    override var description:String {
        get {
            return "[Uitlaat] \(title) - \(message), posted by \(character.nickname) on \(time_posted), with a score of \(score)";
        }
    }
    
    init( id:Int, character_id:Int, title:String, message:String, latitude:Float, longitude:Float, time_posted:String, score:Int, character:CharacterData ) {
        
        self.id = id;
        self.character_id = character_id;
        self.title = title;
        self.message = message;
        self.latitude = latitude;
        self.longitude = longitude;
        self.time_posted = time_posted;
        self.score = score;
        self.character = character;
        
        super.init();
        
    }
    
}