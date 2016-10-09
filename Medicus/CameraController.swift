//
//  CameraController.swift
//  Medicus
//
//  Created by Jesse Bartola on 10/8/16.
//  Copyright © 2016 VJRE. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation
import Clarifai

class CameraController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,
AVCapturePhotoCaptureDelegate, AVCaptureVideoDataOutputSampleBufferDelegate {

    
    @IBOutlet weak var segueButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var audioPlayer = AVAudioPlayer()
    
    let captureSession = AVCaptureSession()
    var previewLayer : AVCaptureVideoPreviewLayer?
    
    // If we find a device we'll store it here for later use
    var captureDevice : AVCaptureDevice?
    var client: ClarifaiClient? = nil
    var picArr: [UIImage] = []
    var diagnosis: String = ""
    var confidence: Float = 0.0
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let client = ClarifaiClient(apiKey: "vikmP0140G5t-f9_3pCztAoiAY7V0-30eil5I0Rc",
                                    secretKey: "YuOjJnxaSYVSzjxhdWy1x7MABUzCjLIsJW9R3sl2")
        
        let custom = CustomModel(applicaiton: client, disease: .cancer)
        picArr = custom.toHugeArray()
        
        let chosenPic = picArr[Int(arc4random_uniform(30))]
        client.getConcepts(image: chosenPic, modelName: "Medicus-3", conceptCompletion: { (tupleArr) in
            if let tuples = tupleArr {
                if tuples.count != 0 {
                    self.diagnosis = tuples[0].0
                    self.confidence = tuples[0].1

                    
                }
            }
        })
        
        let music = Bundle.main.path(forResource: "snap", ofType: "mp3")
        
        // Try to initialize the audioplayer
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: music!))
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch{
            print(error)
        }
        
        
        imagePicker.delegate = self
        
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        let devices = AVCaptureDeviceDiscoverySession(deviceTypes: [AVCaptureDeviceType.builtInTelephotoCamera,
                                                                    AVCaptureDeviceType.builtInDuoCamera,
                                                                    AVCaptureDeviceType.builtInWideAngleCamera], mediaType: nil,
                                                      position: .back).devices
        
        // Loop through all the capture devices on this phone
        for device in devices! {
            // Make sure this particular device supports video
            if (device.hasMediaType(AVMediaTypeVideo)) {
                // Finally check the position and confirm we've got the back camera
                if(device.position == AVCaptureDevicePosition.back) {
                    captureDevice = device as? AVCaptureDevice
                    if captureDevice != nil {
                        
                        beginSession()
                    }
                }
            }
        }
    }
    
    
    func focusTo(value: Float) {
        if let device = captureDevice {
            do {
                try device.lockForConfiguration()
                device.setFocusModeLockedWithLensPosition(value, completionHandler: { (time) -> Void in
                    //
                })
                device.unlockForConfiguration()
            } catch {
                print("Failed")
            }
        }
    }
    
    let screenWidth = UIScreen.main.bounds.size.width
    
    
    func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let anyTouch = touches.anyObject() as! UITouch
        let touchPercent = anyTouch.location(in: self.view).x / screenWidth
        focusTo(value: Float(touchPercent))
    }
    
    func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        
        var anyTouch = touches.anyObject() as! UITouch
        var touchPercent = anyTouch.location(in: self.view).x / screenWidth
        focusTo(value: Float(touchPercent))
    }
    
    func configureDevice() {
        if let device = captureDevice {
            do {
                try device.lockForConfiguration()
                device.focusMode = .locked
                
                //device.isAdjustingFocus = true
                
                device.unlockForConfiguration()
            } catch {
                // Else
                print("error")
            }
            
        }
        
    }
    
    func beginSession() {
        
        configureDevice()
        
        var err : NSError? = nil
        do {
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                try captureSession.addInput(input)
            } catch {
                print("error")
            }
            
        } catch let error as NSError {
            print(error)
        }
        
        //let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) as AVCaptureDevice
        
        /*do {
            let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            
            captureSession.beginConfiguration()
            
            if (captureSession.canAddInput(deviceInput) == true) {
                captureSession.addInput(deviceInput)
            }
            
            let dataOutput = AVCaptureVideoDataOutput()
            dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
            dataOutput.alwaysDiscardsLateVideoFrames = true
            
            if (captureSession.canAddOutput(dataOutput) == true) {
                captureSession.addOutput(dataOutput)
            }
            
            captureSession.commitConfiguration()
            //let i = dispatch_queue_create(<#T##label: UnsafePointer<Int8>?##UnsafePointer<Int8>?#>, <#T##attr: __OS_dispatch_queue_attr?##__OS_dispatch_queue_attr?#>)
            let queue = DispatchQueue(label: "com.vjre.Medicus")
            dataOutput.setSampleBufferDelegate(self, queue: queue)
            
        }
        catch let error as NSError {
            NSLog("\(error), \(error.localizedDescription)")
        }
        
        
        if err != nil {
            print("error: \(err?.localizedDescription)")
        }*/
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.view.layer.addSublayer(previewLayer!)
        previewLayer?.frame = imageView.layer.frame
        
        captureSession.startRunning()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // UNUSED
    // MARK: - Delegates
    /*func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("Does this get executedd?")
        var chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.contentMode = .scaleAspectFit
        imageView.image = chosenImage

        print("Image is \(chosenImage)")
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }*/
    
    @IBAction func openCameraButton(_ sender: UIButton) {
        imageView.superview?.bringSubview(toFront: imageView)
        
        print("Should take a picture")
        let output = AVCapturePhotoOutput()
        audioPlayer.play()
        
    }
    /*
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        let i = previewPhotoSampleBuffer as! UIImage
        print("he")
        imageView.image = i
    }
    
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        
        // Here you collect each frame and process it
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.noneSkipFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)
        imageView.image = UIImage(cgImage: bitmapInfo as! CGImage)
        print(bitmapInfo)
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didDropSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        // Here you can count how many frames are dopped
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "diagnosisSegue" {
            if let destination = segue.destination as? ReportController {
                destination.diagnosis = self.diagnosis
                destination.confidence = self.confidence
                
            }
            
            
            
        }
    }
    
    
    
    
}
