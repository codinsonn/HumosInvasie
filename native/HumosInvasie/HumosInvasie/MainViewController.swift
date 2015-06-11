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
    
    var userCharData : CharacterData!;
    
    var mainView:MainView {
        get{
            return self.view as! MainView;
        }
    }
    
    override func loadView() {
        
        self.view = MainView(frame: UIScreen.mainScreen().bounds);
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor();
        
        badgeButton1 = UIButton(frame: CGRectMake(self.view.frame.width - 65, self.view.frame.height/4 * 1 - 25, 50, 50));
        badgeButton1.setTitle("Ch1", forState: .Normal);
        badgeButton1.backgroundColor = UIColor.redColor();
        badgeButton1.alpha = 0;
        badgeButton1.addTarget(self, action: "badge1Tapped", forControlEvents: .TouchUpInside);
        self.view.addSubview(badgeButton1);
        
        badgeButton2 = UIButton(frame: CGRectMake(self.view.frame.width - 65, self.view.frame.height/4 * 2 - 25, 50, 50));
        badgeButton2.setTitle("Ch2", forState: .Normal);
        badgeButton2.backgroundColor = UIColor.greenColor();
        badgeButton2.addTarget(self, action: "badge2Tapped", forControlEvents: .TouchUpInside);
        badgeButton2.alpha = 0;
        self.view.addSubview(badgeButton2);
        
        badgeButton3 = UIButton(frame: CGRectMake(self.view.frame.width - 65, self.view.frame.height/4 * 3 - 25, 50, 50));
        badgeButton3.setTitle("Ch3", forState: .Normal);
        badgeButton3.backgroundColor = UIColor.blueColor();
        badgeButton3.addTarget(self, action: "badge3Tapped", forControlEvents: .TouchUpInside);
        badgeButton3.alpha = 0;
        self.view.addSubview(badgeButton3);
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "presetsLoadedHandler:",
            name: "PRESETS_LOADED",
            object: nil
        );
        
        // Let preloader loop at least once
        let delay = 4 * Double(NSEC_PER_SEC);
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay));
        
        dispatch_after(time, dispatch_get_main_queue()) {
            
            self.uitlaatVC = UitlaatViewController(nibName: nil, bundle: nil);
            self.kittenVC = KittenVisionViewController(nibName: nil, bundle: nil);
            self.creatorVC = CharacterCreatorViewController(nibName: nil, bundle: nil);
            
        }
        
    }
    
    func presetsLoadedHandler(notification: NSNotification){
        
        self.mainView.dismissPreloader();
        showBadges();
        
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
        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
            
            self.badgeButton1.alpha = 1;
            self.badgeButton2.alpha = 1;
            self.badgeButton3.alpha = 1;
            
            }, completion: nil);
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
        
        flushViewControllers();
        
        self.mainView.updateBackground("CharCreatorBg");
        self.addChildViewController(creatorVC);
        self.view.addSubview(creatorVC.view);
        
    }
    
    func badge2Tapped(){
        
        println("[MainVC] Badge 2 Tapped : Uitlaat Pagina");
        
        flushViewControllers();
        
        self.mainView.updateBackground("UitlaatBg");
        self.addChildViewController(uitlaatVC);
        self.view.addSubview(uitlaatVC.view);
        
    }
    
    func badge3Tapped(){
        
        println("[MainVC] Badge 3 Tapped : Kittenvision");
        
        flushViewControllers();
        
        self.addChildViewController(kittenVC);
        self.view.addSubview(kittenVC.view);
        
    }
    
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(
            self,
            name: "PRESETS_LOADED",
            object: nil
        );
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
