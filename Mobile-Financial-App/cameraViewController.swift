/******************************************************************************************
 * Citiation:
 *    Title: Building a Simple Barcode Scanner in iOS
 *    Author: Greg Brown
 *    Date: March 22, 2018
 *    Code version: 1.0
 *    Availability: https://dzone.com/articles/building-a-simple-barcode-scanner-innbspios
 ******************************************************************************************/

//
//  cameraViewController.swift
//  Mobile-Financial-App
//
//  Created by Michael Ren on 2018-03-22.
//  Copyright © 2018 55487145. All rights reserved.
//


import UIKit
import AVFoundation

//add the cameraView Class first
class CameraView: UIView {
    //to specify that the view will be backed by an instance of AVCaptureVideoPreviewLayer
    override class var layerClass: AnyClass {
        get {
            return AVCaptureVideoPreviewLayer.self
        }
    }
    //to cast the return value to AVCaptureVideoPreviewLayer to make it easier to access the properties of the preview layer later
    override var layer: AVCaptureVideoPreviewLayer {
        get {
            return super.layer as! AVCaptureVideoPreviewLayer
        }
    }
}
//the main class
class cameraViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    //contain the camera view
    var cameraView: CameraView!
    // AV capture session and dispatch queue
    let session = AVCaptureSession()
    let sessionQueue = DispatchQueue(label: AVCaptureSession.self.description(), attributes: [], target: nil)
    //initialize the view
    override func loadView() {
        cameraView = CameraView()
        view = cameraView!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //the capture starts
        session.beginConfiguration()
        let videoDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        if (videoDevice != nil) {
            let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice)
            if (videoDeviceInput != nil) {
                if (session.canAddInput(videoDeviceInput)) {
                    session.addInput(videoDeviceInput)
                }
            }
            let metadataOutput = AVCaptureMetadataOutput()
            if (session.canAddOutput(metadataOutput)) {
                session.addOutput(metadataOutput)
                metadataOutput.metadataObjectTypes = [
                    AVMetadataObjectTypeEAN13Code,
                    AVMetadataObjectTypeQRCode
                ]
                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            }
        }
        session.commitConfiguration()
        cameraView.layer.session = session
        cameraView.layer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        // Set initial camera orientation
        let videoOrientation : AVCaptureVideoOrientation
        switch UIApplication.shared.statusBarOrientation {
            case .portrait:
                videoOrientation = .portrait
            case .portraitUpsideDown:
                videoOrientation = .portraitUpsideDown
            case .landscapeLeft:
                videoOrientation = .landscapeLeft
            case .landscapeRight:
                videoOrientation = .landscapeRight
            default:
                videoOrientation = .portrait
        }
        //cameraView.layer.connection.videoOrientation = videoOrientation
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Start AV capture session
        sessionQueue.async {
            self.session.startRunning()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Stop AV capture session
        sessionQueue.async {
            self.session.stopRunning()
        }
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        // Update camera orientation
        let videoOrientation: AVCaptureVideoOrientation
        switch UIDevice.current.orientation {
        case .portrait:
            videoOrientation = .portrait
        case .portraitUpsideDown:
            videoOrientation = .portraitUpsideDown
        case .landscapeLeft:
            videoOrientation = .landscapeRight
        case .landscapeRight:
            videoOrientation = .landscapeLeft
        default:
            videoOrientation = .portrait
        }
        //cameraView.layer.connection.videoOrientation = videoOrientation
    }
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        // Display barcode value
        if (metadataObjects.count > 0 && metadataObjects.first is AVMetadataMachineReadableCodeObject) {
            let scan = metadataObjects.first as! AVMetadataMachineReadableCodeObject
            //store the barcode
            let val = scan.stringValue
            let alertController = UIAlertController(title: "Barcode Scanned", message: val, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
            present(alertController, animated: true, completion: nil)
        }
    }
}
