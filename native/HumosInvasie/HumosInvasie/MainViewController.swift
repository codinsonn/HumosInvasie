//
//  MainViewController.swift
//  HumosInvasie
//
//  Created by Thorr Stevens on 10/06/15.
//  Copyright (c) 2015 Thorr Stevens. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
   
    var badgeButton1 : UIButton!;
    var badgeButton2 : UIButton!;
    var badgeButton3 : UIButton!;
    
    var creatorVC : CharacterCreatorViewController!;
    var uitlaatVC : UitlaatViewController!;
    var kittenVC : KittenVisionViewController!;
    
    var userCharData:CharacterData!;
    var currentChallenge:String!;
    
    var presetsLoaded:Bool!;
    var preloaderLoopedOnce:Bool!;
    
    var mainView:MainView {
        get{
            return self.view as! MainView;
        }
    }
    
    override func loadView() {
        
        self.presetsLoaded = false;
        self.preloaderLoopedOnce = false;
        self.view = MainView(frame: UIScreen.mainScreen().bounds);
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor.whiteColor();
        let characterButtonBg:UIImage = UIImage(named: "character_locked")!
        badgeButton1 = UIButton(frame: CGRectMake(self.view.frame.width - 106, 6 ,100,100))
        badgeButton1.setBackgroundImage(characterButtonBg, forState: UIControlState.Normal)
        badgeButton1.alpha = 0;
        badgeButton1.addTarget(self, action: "badge1Tapped", forControlEvents: .TouchUpInside);
        self.view.addSubview(badgeButton1);
        
        let uitlaatButtonBg:UIImage = UIImage(named: "uitlaat_locked")!
        badgeButton2 = UIButton(frame: CGRectMake(self.view.frame.width - 106, 112 ,100,100))
        badgeButton2.setBackgroundImage(uitlaatButtonBg, forState: UIControlState.Normal)
        badgeButton2.addTarget(self, action: "badge2Tapped", forControlEvents: .TouchUpInside);
        badgeButton2.alpha = 0;
        self.view.addSubview(badgeButton2);
        
        let kittenVisionButtonBg:UIImage = UIImage(named: "kitten_locked")!
        badgeButton3 = UIButton(frame: CGRectMake(self.view.frame.width - 106, 218 ,100,100))
        badgeButton3.setBackgroundImage(kittenVisionButtonBg, forState: UIControlState.Normal)
        badgeButton3.addTarget(self, action: "badge3Tapped", forControlEvents: .TouchUpInside);
        badgeButton3.alpha = 0;
        self.view.addSubview(badgeButton3);
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "presetsLoadedHandler:",
            name: "PRESETS_LOADED",
            object: nil
        );
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "characterUpdatedHandler:",
            name: "CHARACTER_UPDATED",
            object: nil
        );
        
        var delay = 1 * Double(NSEC_PER_SEC);
        var time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay));
        dispatch_after(time, dispatch_get_main_queue()) {
            
            self.creatorVC = CharacterCreatorViewController(nibName: nil, bundle: nil);
            self.uitlaatVC = UitlaatViewController(nibName: nil, bundle: nil);
            self.kittenVC = KittenVisionViewController(nibName: nil, bundle: nil);
            
            self.checkUserData();
            
        }
        
        // Let preloader loop at least once
        delay = 5 * Double(NSEC_PER_SEC);
        time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay));
        dispatch_after(time, dispatch_get_main_queue()) {
            
            self.preloaderLoopedOnce = true;
            self.initIfPresetsLoaded();
            
        }
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "achievementCompletedHandler:",
            name: "ACHIEVEMENT_COMPLETED",
            object: nil
        );
        
    }
    
    func characterUpdatedHandler(notification: NSNotification){
        
        self.checkUserData();
        
    }
    
    func checkUserData(){
        
        if NSUserDefaults.standardUserDefaults().boolForKey("hasCreatedCharacter"){
            self.showBadges()
            var char_id = NSUserDefaults.standardUserDefaults().integerForKey("userCharacterId");
            
            println("[MainVC] Loading Character (ID = \(char_id))");
            
            var requestUrl = "http://student.howest.be/thorr.stevens/20142015/MA4/BADGET/api/characters/\(char_id)/";
            
            Alamofire.request(.GET, requestUrl).responseJSON{(_,_,data,_)in
                
                println("[MainVC] Character api response: \(data!)");
                
                let jsonData = JSON(data!);
                
                var err:NSErrorPointer! = NSErrorPointer();
                let userData = NSJSONSerialization.dataWithJSONObject(jsonData.object, options: nil, error: err);
                
                self.userCharData = CharacterFactory.createCharacterFromJSONData(userData!);
                self.creatorVC.setCharacterData(self.userCharData);
                self.uitlaatVC.setCharacterData(self.userCharData);
                
            }
            
        }
        
    }
    
    func presetsLoadedHandler(notification: NSNotification){
        
        self.presetsLoaded = true;
        self.initIfPresetsLoaded();
        
    }
    
    func initIfPresetsLoaded(){
        
        if(self.presetsLoaded == true && self.preloaderLoopedOnce == true){
            self.mainView.dismissPreloader();
            showBadges();
        }
        
    }
    
    func flushViewControllers(){
        
        self.creatorVC.removeFromParentViewController();
        self.creatorVC.view.removeFromSuperview();
        
        self.uitlaatVC.removeFromParentViewController();
        self.uitlaatVC.view.removeFromSuperview();
        
        self.kittenVC.removeFromParentViewController();
        self.kittenVC.view.removeFromSuperview();
        
    }
    
    func showBadges(){
        if(self.presetsLoaded == true){
            UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
            
                self.badgeButton1.alpha = 1;
                
                // Only show 2nd and 3rd buttons/badges when a character has been created and saved to the device and database
                if NSUserDefaults.standardUserDefaults().boolForKey("hasCreatedCharacter"){
                    self.changeButtonBg("character")
                    self.badgeButton2.alpha = 1;
                    self.badgeButton3.alpha = 1;
                }
                
                if NSUserDefaults.standardUserDefaults().boolForKey("hasPostedMessage"){
                    self.changeButtonBg("uitlaat")
                }
            
            }, completion: nil);
        }
    }
    
    func changeButtonBg(badge:String){
        if(badge == "character"){
            let character_unlockedButtonBg:UIImage = UIImage(named: "character_unlocked")!
            badgeButton1.setBackgroundImage(character_unlockedButtonBg, forState: UIControlState.Normal)
        }
        if(badge == "uitlaat"){
            let character_unlockedButtonBg:UIImage = UIImage(named: "uitlaat_unlocked")!
            badgeButton2.setBackgroundImage(character_unlockedButtonBg, forState: UIControlState.Normal)
        }

    }
    
    func hideBadgess(){
        UIView.animateWithDuration(0.8, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
            
            self.badgeButton1.alpha = 0;
            self.badgeButton2.alpha = 0;
            self.badgeButton3.alpha = 0;
            
        }, completion: nil)
    }
    
    func badge1Tapped(){
        
        println("[MainVC] Badge 1 Tapped : Character Creator");
        
        if(self.currentChallenge != "Character Creator"){
            
            flushViewControllers();
            
            self.mainView.changeBackgroundAnimation("CreatorBg");
            //self.mainView.updateBackground("CharCreatorBg");
            self.addChildViewController(creatorVC);
            self.view.addSubview(creatorVC.view);
        }
        
        self.currentChallenge = "Character Creator";
        
    }
    
    func badge2Tapped(){
        
        println("[MainVC] Badge 2 Tapped : Uitlaat Pagina");
        
        if(self.currentChallenge != "Uitlaat"){
            
            flushViewControllers();
            
            self.uitlaatVC.loadUitlaatMessages();
            
            self.mainView.changeBackgroundAnimation("UitlaatBg");
            //self.mainView.updateBackground("UitlaatBg");
            self.addChildViewController(uitlaatVC);
            self.view.addSubview(uitlaatVC.view);
            
        }
        
        self.currentChallenge = "Uitlaat";
        
    }
    
    func badge3Tapped(){
        
        println("[MainVC] Badge 3 Tapped : Kittenvision");
        
        if(self.currentChallenge != "KittenVision"){
            
            flushViewControllers();
            
            self.mainView.changeBackgroundAnimation("KittenVisionBg");
            self.addChildViewController(kittenVC);
            self.view.addSubview(kittenVC.view);
            
        }
        
        self.currentChallenge = "KittenVision";
        
    }
    
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(
            self,
            name: "PRESETS_LOADED",
            object: nil
        );
        
        NSNotificationCenter.defaultCenter().removeObserver(
            self,
            name: "CHARACTER_UPDATED",
            object: nil
        );
        
    }
    
    func achievementCompletedHandler(notification: NSNotification){
        println("achievement completed in Mainvc")
        
        var notification = notification.object as! String
        println(notification)
        self.showBadges()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}