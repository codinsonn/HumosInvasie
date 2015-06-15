//
//  InformerViewController.swift
//  HumosInvasie
//
//  Created by MrSpijker on 15/06/15.
//  Copyright (c) 2015 Thorr Stevens. All rights reserved.
//


import UIKit

class InformerViewController: UIViewController {
    var activeInformer:String = ""
    
    var theView:InformerView {
        get{
            return self.view as! InformerView;
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = InformerView(frame: UIScreen.mainScreen().bounds)

    }
    
    override func viewDidLoad() {
        println(self.theView);
        
        self.theView.userFeedbackButton.addTarget(self, action: "userFeedbackGiven:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: "tapped:");
        tap.numberOfTapsRequired = 2;
        
        self.view.addGestureRecognizer(tap);

    }
    
    func tapped(sender:UITapGestureRecognizer){
        println("tabbed");
    }

    
    func addInformer(informer:String){
        self.activeInformer = informer
        self.theView.addInformer(self.activeInformer)
        self.view.bringSubviewToFront(self.theView.userFeedbackButton);

    }
    
    func userFeedbackGiven(sender:UIButton!){
        println("feedback given")
        self.theView.removeInformerFromStage()
    }
    

}
