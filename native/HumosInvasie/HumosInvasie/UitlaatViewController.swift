//
//  UitlaatViewController.swift
//  NavigationTests
//
//  Created by Thorr Stevens on 05/06/15.
//  Copyright (c) 2015 Thorr Stevens. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class UitlaatViewController: UIViewController {
    
    var charData:CharacterData!;
    
    var uitlaatView:UitlaatView {
        get{
            return self.view as! UitlaatView;
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        
        println("[UitlaatVC] Initialising ViewController");
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCharacterData(userData:CharacterData){
        
        self.charData = userData;
        self.uitlaatView.updateCharacterButton(self.charData.image);
        
    }
    
    override func loadView() {
        
        println("[UitlaatVC] Loading View");
        
        let containerRect = CGRectMake(0, 0, 488, 320);
        
        self.view = UitlaatView(frame: containerRect);
        
    }
    
    func loadUitlaatMessages(){
        
        Alamofire.request(.GET, "http://student.howest.be/thorr.stevens/20142015/MA4/BADGET/api/uitlaat/filter/hours/60/min_lat/50/max_lat/60/min_long/5/max_long/6").responseJSON { (_, _, data, _) in
            
            
            
        }
        
    }
    
    override func viewDidLoad() {
        
        println("[UitlaatVC] View did load");
        
        super.viewDidLoad();
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "postUitlaat:",
            name: "POST_TAPPED",
            object: self.uitlaatView.inputField
        );
        
    }
    
    func postUitlaat(notification:NSNotification){
        
        let alert = UIAlertController(title: "Waarschijnlijk dronken", message: "Zeker dat u dit bericht wil posten? \n -\"\(self.uitlaatView.inputField.text)\"-", preferredStyle: UIAlertControllerStyle.Alert);
        
        let yesAction = UIAlertAction(title: "euh...ja zeker?", style: UIAlertActionStyle.Default) { (action) -> Void in
            
            println("[UitlaatVC] Posting message: \(self.uitlaatView.inputField.text)");
            
            var locManager = CLLocationManager()
            locManager.requestWhenInUseAuthorization()
            var latitude = 50.960406;
            var longitude = 5.354287;
            var currentLocation = CLLocation();
            
            if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
                CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways
                ){
                    
                    currentLocation = locManager.location;
                    
                    latitude = currentLocation.coordinate.latitude;
                    longitude = currentLocation.coordinate.longitude;
                    
            }
            
            var postsEndpoint: String = "http://student.howest.be/thorr.stevens/20142015/MA4/BADGET/api/uitlaat/"
            var parameters = ["character_id": 0, "title": "Pukkelpop 2015", "message": self.uitlaatView.inputField.text, "latitude": latitude, "longitude": longitude];
            Alamofire.request(.POST, postsEndpoint, parameters: parameters as! [String : AnyObject], encoding: .JSON)
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
                        
                        let successAlert = UIAlertController(title: "Success!", message: "Je uitlaatbericht is met succes gepost. Dansen dansen!", preferredStyle: UIAlertControllerStyle.Alert);
                        self.presentViewController(successAlert, animated: true, completion: nil);
                        
                    }
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "toch nog aanpassen", style: UIAlertActionStyle.Cancel) { (action) -> Void in
            println("[UitlaatVC] Post was cancelled.");
        }
        
        let destroyAction = UIAlertAction(title: "vernietig het bewijs", style: UIAlertActionStyle.Destructive) { (action) -> Void in
            
            println("[UitlaatVC] Post was destroyed.");
            
            self.uitlaatView.inputField.text = "";
            self.uitlaatView.hideInput();
            
        }
        
        alert.addAction(cancelAction);
        alert.addAction(yesAction);
        alert.addAction(destroyAction);
        
        self.presentViewController(alert, animated: true, completion: nil);
        
        
    }
    
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(
            self,
            name: "POST_TAPPED",
            object: self.uitlaatView.inputField
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
