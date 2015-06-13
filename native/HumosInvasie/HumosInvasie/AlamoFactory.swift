//
//  AlamoFactory.swift
//  SlidingGood
//
//  Created by MrSpijker on 02/06/15.
//  Copyright (c) 2015 MrSpijker. All rights reserved.
//

import UIKit

class AlamoFactory {
    
    class func createBodyPartsFromJSONData(data:JSON) -> Array<BodyPart> {
        
        var bodyParts = Array<BodyPart>()
        
        for(index:String, subJson: JSON) in data{
            
            let id = subJson["id"];
            let type = subJson["type"];
            let fileName = subJson["filename"];
            
            let bodyPart = BodyPart(id: id.intValue, type: type.stringValue, fileName: fileName.stringValue);
            
            bodyParts.append(bodyPart);
        }
        
        return bodyParts;
        
    }

    class func createAvatarPreviewsFromJSONData(data:JSON) -> QRReplaceImageModel {
            var qRReplaceImageModel:QRReplaceImageModel
            qRReplaceImageModel = QRReplaceImageModel(id: data["id"].intValue, imageUrl: data["filename"].stringValue);
            return qRReplaceImageModel;
        }
    
    
}

   

