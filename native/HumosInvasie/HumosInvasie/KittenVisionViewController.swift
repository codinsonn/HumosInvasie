//
//  KittenVisionViewController.swift
//  NavigationTests
//
//  Created by Thorr Stevens on 05/06/15.
//  Copyright (c) 2015 Thorr Stevens. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire

class KittenVisionViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession:AVCaptureSession?;
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?;
    var qrCodeFrameView:UIView?;
    var QRSerializer:Array<AnyObject> = [];
    var avatarImageArray:Array<UIImageView> = [];
    
    var url:String = "http://student.howest.be/thorr.stevens/20142015/MA4/BADGET/api/characters/";
    var imgUrl:String = "http://student.howest.be/thorr.stevens/20142015/MA4/BADGET/img/uploads/characters/";
    
    let supportedBarCodes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeUPCECode, AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeAztecCode]

    
    var kittenView:KittenVisionView {
        get{
            return self.view as! KittenVisionView;
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        
        println("[KittenVC] Initialising ViewController");
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        println("[KittenVC] Loading View");
        
        let containerRect = CGRectMake(0, 0, 488, 320);
        
        self.view = KittenVisionView(frame: containerRect);
    }
    
    override func viewDidLoad() {
        
        println("[KittenVC] View did load");
        
        super.viewDidLoad();
        
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo);
        
        var error:NSError?;
        let input: AnyObject! = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: &error);
        
        if (error != nil) {
            println("\(error?.localizedDescription)");
            return
        }
        
        
        
        captureSession = AVCaptureSession();
        captureSession?.sessionPreset = AVCaptureSessionPresetHigh;
        captureSession?.addInput(input as! AVCaptureInput);
        
        let captureMetadataOutput = AVCaptureMetadataOutput();
        captureSession?.addOutput(captureMetadataOutput);
        
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue());
        captureMetadataOutput.metadataObjectTypes = supportedBarCodes;
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
        videoPreviewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.LandscapeRight;
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill;
        videoPreviewLayer?.frame = view.layer.bounds;
        
        //view.layer.addSublayer(videoPreviewLayer);
        
        //captureSession?.startRunning();
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection videoConnection: AVCaptureConnection!) {
        
        for view in self.view.subviews{
            var hideThisView = view as! UIView;
            hideThisView.hidden = true;
        }
        
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRectZero;
            println("No QR code is detected");
            return
        }
        
        for rawMetaDataObject in metadataObjects{
            if contains(self.QRSerializer, { $0.stringValue == rawMetaDataObject.stringValue }) {
                
            }
            else{
                fetchAvatarPreset(rawMetaDataObject.stringValue);
                self.QRSerializer.append(rawMetaDataObject);
            }
        }
        
        
        for parsedQRobject in metadataObjects{
            
            for loopView in self.view.subviews{
                
                if let replaceImageView = loopView as? QRReplaceImageView{
                    
                    if parsedQRobject.stringValue == String(replaceImageView.myId){
                        replaceImageView.hidden = false;
                        moveQRdisplayedImages(parsedQRobject as! AVMetadataMachineReadableCodeObject,qrCodeFrameView: replaceImageView);
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func moveQRdisplayedImages(parsedQRobject:AVMetadataMachineReadableCodeObject, qrCodeFrameView:QRReplaceImageView){
        
        qrCodeFrameView.layer.borderColor = UIColor.greenColor().CGColor;
        qrCodeFrameView.layer.borderWidth = 2;
        
        let metadataObj = parsedQRobject as AVMetadataMachineReadableCodeObject;
        
        if supportedBarCodes.filter({ $0 == metadataObj.type }).count > 0 {
            
            let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject;
            //qrCodeFrameView.frame = barCodeObject.bounds;
            qrCodeFrameView.frame = barCodeObject.bounds;
            
            if metadataObj.stringValue != nil {
                
                //messageLabel.text = metadataObj.stringValue
                //launchApp(metadataObj.stringValue);
                
            }
            
        }
        
    }
    
    func fetchAvatarPreset(idVal:String){
        
        let url = self.url + idVal;
        
        Alamofire.request(.GET, url).responseJSON{(_,_,data,_)in
            
            let avatar:QRReplaceImageModel = AlamoFactory.createAvatarPreviewsFromJSONData(JSON(data!));
            let qrReplacementImageVC:QRReplaceImageViewController;
            qrReplacementImageVC = QRReplaceImageViewController(avatar: avatar, url: self.imgUrl);
            self.view.addSubview(qrReplacementImageVC.view);
            
            
        }
        
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
