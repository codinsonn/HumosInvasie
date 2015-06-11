//
//  ViewController.swift
//  QRReaderDemo
//
//  Created by Simon Ng on 23/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire

class QrDetectionViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    var QRSerializer:Array<AnyObject> = []
    var avatarImageArray:Array<UIImageView> = []
    
    var url:String = "http://student.howest.be/thorr.stevens/20142015/MA4/BADGET/api/presets/"
    var imgUrl:String = "http://student.howest.be/thorr.stevens/20142015/MA4/BADGET/img/presets/"
    
    // Added to support different barcodes
    let supportedBarCodes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeUPCECode, AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeAztecCode]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
        // as the media type parameter.
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)

        var error:NSError?
        let input: AnyObject! = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: &error)
        
        if (error != nil) {
            // If any error occurs, simply log the description of it and don't continue any more.
            println("\(error?.localizedDescription)")
            return
        }
        
        // Initialize the captureSession object.
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSessionPresetHigh
        // Set the input device on the capture session.
        captureSession?.addInput(input as! AVCaptureInput)
        
        // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        
        // Set delegate and use the default dispatch queue to execute the call back
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        captureMetadataOutput.metadataObjectTypes = supportedBarCodes
        
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.LandscapeRight
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds

        view.layer.addSublayer(videoPreviewLayer)
        
        // Start video capture.
        captureSession?.startRunning()
        
        // Move the message label to the top view
        //var timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("screenShotMethod"), userInfo: nil, repeats: true)
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection videoConnection: AVCaptureConnection!) {

        for view in self.view.subviews{
            var hideThisView = view as! UIView
            hideThisView.hidden = true
        }
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRectZero
            //messageLabel.text = 
            println("No QR code is detected")
            return
        }
        
        // Get the metadata object.
        for rawMetaDataObject in metadataObjects{
            if contains(self.QRSerializer, { $0.stringValue == rawMetaDataObject.stringValue }) {
            }
            else{
                fetchAvatarPreset(rawMetaDataObject.stringValue)
                self.QRSerializer.append(rawMetaDataObject)
            }
        }
        
        
        for parsedQRobject in metadataObjects{
            
            for loopView in self.view.subviews{
            
                if let replaceImageView = loopView as? QRReplaceImageView{
                    
                    if parsedQRobject.stringValue == String(replaceImageView.myId){
                        replaceImageView.hidden = false
                        moveQRdisplayedImages(parsedQRobject as! AVMetadataMachineReadableCodeObject,qrCodeFrameView: replaceImageView)
                    }
                }
            }

        }

    }
    
    func moveQRdisplayedImages(parsedQRobject:AVMetadataMachineReadableCodeObject, qrCodeFrameView:QRReplaceImageView){

        qrCodeFrameView.layer.borderColor = UIColor.greenColor().CGColor
        qrCodeFrameView.layer.borderWidth = 2
        
        let metadataObj = parsedQRobject as AVMetadataMachineReadableCodeObject
        
        if supportedBarCodes.filter({ $0 == metadataObj.type }).count > 0 {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            //qrCodeFrameView.frame = barCodeObject.bounds
            qrCodeFrameView.frame = barCodeObject.bounds
            
            if metadataObj.stringValue != nil {
                //messageLabel.text = metadataObj.stringValue
                //launchApp(metadataObj.stringValue)
            }
        }

    }
    
    func fetchAvatarPreset(idVal:String){
        let url = self.url + idVal
            Alamofire.request(.GET, url).responseJSON{(_,_,data,_)in
                let avatar:QRReplaceImageModel = AlamoFactory.createAvatarPreviewsFromJSONData(JSON(data!))
                //self.QRFetchedAvatars.append(avatar)
                let qrReplacementImageVC:QRReplaceImageViewController
                qrReplacementImageVC = QRReplaceImageViewController(avatar: avatar, url: self.imgUrl)
                self.view.addSubview(qrReplacementImageVC.view)
        }
    }
    
    
    func screenShotMethod() {
        //Create the UIImage
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.layer.renderInContext(UIGraphicsGetCurrentContext())
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //Save it to the camera roll
        //println(image)
        //let testImage:UIImageView = UIImageView(image: image)
        
        let imageToCIImage = CIImage(image: image)
        
        let context = CIContext(options:[kCIContextUseSoftwareRenderer : true])
        let filter = CIFilter(name: "CISepiaTone", withInputParameters: [kCIInputImageKey: imageToCIImage, kCIInputIntensityKey: NSNumber(double: 2.5)])
        
        let result = filter.outputImage;
        var UIIMageResult = UIImage(CIImage: result)

        let resultView = UIImageView(image: UIIMageResult)
       
        
        self.view.addSubview(resultView)
        self.view.bringSubviewToFront(resultView)
    }
}

