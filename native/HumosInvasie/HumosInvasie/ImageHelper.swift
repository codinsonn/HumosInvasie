//
//  ImageUploader.swift
//  SlidingGood
//
//  Created by MrSpijker on 08/06/15.
//  Copyright (c) 2015 MrSpijker. All rights reserved.
//

import UIKit
import Alamofire

class ImageUploader {
    
    var imageView:UIImageView = UIImageView();
    
    class func uploadImage(image:UIImageView, uploaddir:String) {
        
        //generate random filename
        let filename = NSUUID().UUIDString;
        
        let docDir:AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0];
        let imgPath = (docDir as! String) + "/\(filename).jpg";
        
        var imageData = NSData(contentsOfFile: imgPath, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: nil);
        var parameters = [
            "picture"           : NetData(pngImage: image.image!, filename: "\(filename).png"),
            "upload_directory"  : uploaddir, /* --- gewone images = "/uploads/" , characters = "/uploads/characters/" --- */
            "uploader_id"       : "0"
        ];
        
        let urlRequest = self.urlRequestWithComponents("http://student.howest.be/thorr.stevens/20142015/MA4/BADGET/upload.php", parameters: parameters);
        
        var responseJSON:AnyObject!;
        
        Alamofire.upload(urlRequest.0, urlRequest.1)
            .progress { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
                println("\(totalBytesWritten) / \(totalBytesExpectedToWrite)");
            }
            .responseJSON { (request, response, data, error) in
                var json = JSON(data!);
                
                println("REQUEST \(request)");
                println("RESPONSE \(response)");
                println("JSON \(json)");
                println("ERROR \(error)");
                
                var code = json["code"].intValue;
                
                if(code == 1){
                    var img_id = json["img_id"].intValue;
                    self.uploadResponseHandler(img_id);
                }
                
        }
        
    }
    
    class func uploadResponseHandler(img_id: Int) {
        
        let infoDict = ["img_id" : img_id];
        
        NSNotificationCenter.defaultCenter().postNotificationName("UPLOAD_FINISHED", object: nil, userInfo: infoDict);
        
    }
    
    class func createImageFromUrlAndFilename(imgdir:String, imgname:String) -> UIImage{
        
        println("[ImageUploader] Creating Image from \(imgdir)\(imgname)");
        
        let url = NSURL(string: imgdir + String(imgname));
        let data = NSData(contentsOfURL: url!);
        let image = UIImage(data: data!);
    
        return image!;
        
    }
    
    class func urlRequestWithComponents(urlString:String, parameters:NSDictionary) -> (URLRequestConvertible, NSData) {
        
        // create url request to send
        var mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        mutableURLRequest.HTTPMethod = Alamofire.Method.POST.rawValue
        let boundaryConstant = "NET-POST-boundary-\(arc4random())-\(arc4random())"
        let contentType = "multipart/form-data;boundary="+boundaryConstant
        mutableURLRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        // create upload data to send
        let uploadData = NSMutableData()
        
        // add parameters
        for (key, value) in parameters {
            
            uploadData.appendData("\r\n--\(boundaryConstant)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
            
            if value is NetData {
                // add image
                var postData = value as! NetData
                
                // append content disposition
                var filenameClause = " filename=\"\(postData.filename)\""
                let contentDispositionString = "Content-Disposition: form-data; name=\"\(key)\";\(filenameClause)\r\n"
                let contentDispositionData = contentDispositionString.dataUsingEncoding(NSUTF8StringEncoding)
                uploadData.appendData(contentDispositionData!)
                
                // append content type
                let contentTypeString = "Content-Type: \(postData.mimeType.getString())\r\n\r\n"
                let contentTypeData = contentTypeString.dataUsingEncoding(NSUTF8StringEncoding)
                uploadData.appendData(contentTypeData!)
                uploadData.appendData(postData.data)
                
            }else{
                uploadData.appendData("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n\(value)".dataUsingEncoding(NSUTF8StringEncoding)!)
            }
        }
        uploadData.appendData("\r\n--\(boundaryConstant)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        // return URLRequestConvertible and NSData
        return (Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: nil).0, uploadData)
    }
    
    init(){
        
    }

}
   

