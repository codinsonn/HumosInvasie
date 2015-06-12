//
//  CharacterCreatorViewController.swift
//  NavigationTests
//
//  Created by Thorr Stevens on 05/06/15.
//  Copyright (c) 2015 Thorr Stevens. All rights reserved.
//

import UIKit
import Alamofire

class CharacterCreatorViewController: UIViewController {
    
    let imagesArray = ["1","2","3","4"];
    let bodyPartsApiArray = [
        "http://student.howest.be/thorr.stevens/20142015/MA4/BADGET/api/presets/type/head",
        "http://student.howest.be/thorr.stevens/20142015/MA4/BADGET/api/presets/type/upper_body",
        "http://student.howest.be/thorr.stevens/20142015/MA4/BADGET/api/presets/type/lower_body",
    ];
    let bodyPartSliderHeight = UIScreen.mainScreen().bounds.height/3;
    var loadedUrls:Int = 0;
    
    // nog niet gebruikt tot nu toe
    var headPresetId:Int!;
    var upperPresetId:Int!;
    var lowerPresetId:Int!;
    
    var charData:CharacterData!;
    
    var creatorView:CharacterCreatorView {
        get{
            return self.view as! CharacterCreatorView;
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        
        println("[CreatorVC] Initialising ViewController");
        
        self.loadJSON();
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCharacterData(userData:CharacterData){
        
        self.charData = userData;
        self.creatorView.txtNickname.text = self.charData.nickname;
        
    }
    
    override func loadView() {
        
        println("[CreatorVC] Loading View");
    
        let containerRect = CGRectMake(0, 0, 488, 320);
        
        self.view = CharacterCreatorView(frame: containerRect);
    
    }
    
    override func viewDidLoad() {
        
        println("[CreatorVC] View did load");
        
        super.viewDidLoad();

        let saveButton:UIButton = UIButton(frame: CGRectMake(0, 200, 100, 100));
        saveButton.addTarget(self, action: "saveAvatar", forControlEvents: UIControlEvents.TouchUpInside);
        saveButton.setTitle("save", forState: UIControlState.Normal);
        self.creatorView.addSubview(saveButton);
        
    }
    
    func loadJSON(){
        
        var yPos:CGFloat = 0
        
        for url in self.bodyPartsApiArray{
            
            var i:Int = 0;
            
            Alamofire.request(.GET, url).responseJSON{(_,_,data,_)in
                
                println(url)
                var json = JSON(data!)
                var bodyParts = Array<BodyPart>()
                
                bodyParts = AlamoFactory.createBodyPartsFromJSONData(json)
                var bodyPartViewController:BodyPartViewController
                
                if url.rangeOfString("head") != nil {
                    yPos = 0;
                }
                else if url.rangeOfString("upper_body") != nil {
                    yPos = 106;
                }
                else if url.rangeOfString("lower_body") != nil {
                    yPos = 212;
                }
                
                self.creatorView.bodyPartsContainer.addSubview(BodyPartViewController(
                    bodyParts: bodyParts,
                    frame: CGRectMake(0, yPos, UIScreen.mainScreen().bounds.width, self.bodyPartSliderHeight)
                ).view);
                
                self.loadedUrls += 1;
                if(self.loadedUrls >= 3){
                    NSNotificationCenter.defaultCenter().postNotificationName(
                        "PRESETS_LOADED",
                        object: nil
                    );
                }
                
            }
            
        }
        
    }
    
    func saveAvatar(){
        
        println("[CreatorVC] Saving Avatar");
        
        let cgCropRect:CGRect = CGRectMake((UIScreen.mainScreen().bounds.width-self.bodyPartSliderHeight)/2, 0, self.bodyPartSliderHeight, 320);
        
        UIGraphicsBeginImageContext(self.creatorView.bodyPartsContainer.frame.size);
        self.creatorView.bodyPartsContainer.layer.renderInContext(UIGraphicsGetCurrentContext());
        let roughImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        let imageRef:CGImageRef = CGImageCreateWithImageInRect(roughImage.CGImage, cgCropRect);
        println(imageRef);
        
        let croppedImage:UIImage = UIImage(CGImage: imageRef)!;
        println(croppedImage);
        
        let saveImageView:UIImageView = UIImageView(image: croppedImage)
        println(saveImageView);
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "avatarUploadedHandler:",
            name: "UPLOAD_FINISHED",
            object: nil
        );
        
        ImageUploader.uploadImage(saveImageView, uploaddir: "/uploads/characters/");
        
        self.creatorView.addSubview(saveImageView);
        
    }
    
    func avatarUploadedHandler(notification: NSNotification) {
        
        let char_img_id = notification.userInfo!["img_id"] as! Int;
        var parameters = [
            "char_img_id": char_img_id,
            "nickname": self.creatorView.txtNickname.text as String,
            "head_preset_id": 0,
            "upper_body_preset_id": 0,
            "lower_body_preset_id": 0
        ];
        var char_id:Int = 0;
        
        if( NSUserDefaults.standardUserDefaults().boolForKey("hasCreatedCharacter") ){
            
            char_id = NSUserDefaults.standardUserDefaults().integerForKey("userCharacterId");
            var apiEndpoint: String = "http://student.howest.be/thorr.stevens/20142015/MA4/BADGET/api/characters/\(char_id)/";
            
            println("[CharVC] Saving edited character to database (User ID = \(char_id))");
            
            println("---- [CharVC] Parameters: \(parameters) ------------");
            
            Alamofire.request(.PUT, apiEndpoint, parameters: parameters as! [String : AnyObject], encoding: .JSON)
                .responseJSON { (request, response, data, error) in
                    if let anError = error
                    {
                        println("error calling PUT on /puts");
                        println(error);
                    }
                    else if let data: AnyObject = data
                    {
                        let post = JSON(data);
                        println("The put is: " + post.description);
                        
                        NSNotificationCenter.defaultCenter().postNotificationName(
                            "CHARACTER_UPDATED",
                            object: nil
                        );
                    }
            }
            
        }else{
            
            println("[CharVC] Saving created character to device and database");
            
            var apiEndpoint: String = "http://student.howest.be/thorr.stevens/20142015/MA4/BADGET/api/characters/";
            
            Alamofire.request(.POST, apiEndpoint, parameters: parameters as! [String : AnyObject], encoding: .JSON)
                .responseJSON { (request, response, data, error) in
                    if let anError = error
                    {
                        println("error calling POST on /posts");
                        println(error);
                    }
                    else if let data: AnyObject = data
                    {
                        let post = JSON(data);
                        println("The post is: " + post.description);
                        
                        char_id = post["id"].intValue;
                        
                        NSUserDefaults.standardUserDefaults().setInteger(char_id, forKey: "userCharacterId");
                        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasCreatedCharacter");
                        NSUserDefaults.standardUserDefaults().synchronize();
                        
                        NSNotificationCenter.defaultCenter().postNotificationName(
                            "CHARACTER_UPDATED",
                            object: nil
                        );
                    }
            }
            
        }
        
    }
    
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(
            self,
            name: "UPLOAD_FINISHED",
            object: nil
        );
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
