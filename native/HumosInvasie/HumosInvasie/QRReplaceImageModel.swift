
//
//  QRReplaceImageModel.swift
//  QRdetection
//
//  Created by MrSpijker on 06/06/15.
//  Copyright (c) 2015 MrSpijker. All rights reserved.
//

import UIKit

class QRReplaceImageModel: NSObject {
    var id:Int
    var imageUrl:String
    
    init(id:Int, imageUrl:String) {
        self.id = id
        self.imageUrl = imageUrl
    }
   
}
