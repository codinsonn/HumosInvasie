//
//  BodyPart.swift
//  SlidingGood
//
//  Created by MrSpijker on 02/06/15.
//  Copyright (c) 2015 MrSpijker. All rights reserved.
//

import UIKit

class BodyPart: NSObject {
    var id:Int
    var type:String
    var fileName:String
    
    init(id:Int, type:String, fileName:String){
        self.id = id
        self.type = type
        self.fileName = fileName
        
        super.init();
    }
   
}
