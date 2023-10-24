//
//  ViewController.swift
//  Filter It
//
//  Created by Saif on 21/11/21.
// pod 'OpalImagePicker' image picker

import UIKit
import StoreKit
import BBMetalImage
import AVFoundation

var SelectedPhoto:UIImage?

class ViewController: UIViewController,AVCapturePhotoCaptureDelegate {
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var imagePreview: UIImageView!
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var input: AVCaptureDeviceInput!
    
    @IBOutlet weak var cameraView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onBoardingProcess()
        
    }
    
    
    
    @IBOutlet weak var flash: UIButton!{
        didSet{
            flash.setImage(UIImage(named: "thunder"),for: .normal)
        }
    }
    
    @IBAction func flashAction(_ sender: Any) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        toggleFlash()
    }
    
    @IBAction func editAction(_ sender: Any) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        DispatchQueue.main.async {
            let main = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = main.instantiateViewController(withIdentifier: "PhotoEditorVC") as! PhotoEditorVC
            vc.modalPresentationStyle = .fullScreen
            if let topController = UIApplication.topViewController() {
                topController.present(vc, animated: true, completion: nil)
            }
            
        }
    }
    
    func toggleFlash() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        guard device.hasTorch else { return }
        
        do {
            try device.lockForConfiguration()
            
            if (device.torchMode == AVCaptureDevice.TorchMode.on) {
                device.torchMode = AVCaptureDevice.TorchMode.off
                flash.setImage(UIImage(named: "thunder"),for: .normal)
            } else {
                do {
                    try device.setTorchModeOn(level: 1.0)
                    flash.setImage(UIImage(named: "thunderFilled"),for: .normal)
                } catch {
                    print(error)
                }
            }
            
            device.unlockForConfiguration()
        } catch {
            print(error)
        }
    }
    
    @IBOutlet weak var IPAButton: UIButton!{
        didSet{
            IPAButton.isHidden = UserDefaults.standard.isProMember()
        }
    }
    
    
    @IBAction func IPA(_ sender: Any) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        let vc = InAppPurchases()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    @IBAction func didTakePhoto(_ sender: Any) {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }
    
    
    @IBAction func switchCamera(sender:UIButton){
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        captureSession.removeInput(input)
        captureSession.removeOutput(stillImageOutput)
        
        input.device.position == .back ? showFrontcamera() : showBackcamera()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.captureSession.stopRunning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.selectedIndex = 0
        self.editButton.isHidden = true
        
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back) else {return}
        
        
        if(backCamera.isFocusModeSupported(.continuousAutoFocus)) {
            try! backCamera.lockForConfiguration()
            backCamera.focusMode = .continuousAutoFocus
            backCamera.isSmoothAutoFocusEnabled = true
            backCamera.unlockForConfiguration()
        }
        
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
            stillImageOutput = AVCapturePhotoOutput()
            stillImageOutput.isHighResolutionCaptureEnabled = true
            
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
    }
    
}

extension ViewController {
    
    func showBackcamera() {
        flash.isHidden = false
        guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back) else {return}
        
        
        if(backCamera.isFocusModeSupported(.continuousAutoFocus)) {
            try! backCamera.lockForConfiguration()
            backCamera.focusMode = .continuousAutoFocus
            backCamera.isSmoothAutoFocusEnabled = true
            backCamera.unlockForConfiguration()
        }
        
        
        
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
            stillImageOutput = AVCapturePhotoOutput()
            stillImageOutput.isHighResolutionCaptureEnabled = true
            
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                //setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
        
    }
    
    
    func showFrontcamera() {
        flash.setImage(UIImage(named: "thunder"),for: .normal)
        flash.isHidden = true
        guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .front) else {return}
        
        if(frontCamera.isFocusModeSupported(.continuousAutoFocus)) {
            try! frontCamera.lockForConfiguration()
            frontCamera.focusMode = .continuousAutoFocus
            frontCamera.isSmoothAutoFocusEnabled = true
            frontCamera.unlockForConfiguration()
            
        }
        
        do {
            input = try AVCaptureDeviceInput(device: frontCamera)
            stillImageOutput = AVCapturePhotoOutput()
            stillImageOutput.isHighResolutionCaptureEnabled = true
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                //setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
        
    }
    
    func setupLivePreview() {
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        cameraView.layer.addSublayer(videoPreviewLayer)
        
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
        
        DispatchQueue.main.async {
            self.videoPreviewLayer.frame = self.cameraView.bounds
        }
        
    }
    
    func onBoardingProcess(){
        // == 1
        if UserDefaults.standard.getnumberOftimeAppOpen() != 1 {
            DispatchQueue.main.async {
                let story = UIStoryboard(name: "Welcome", bundle: nil)
                let vc = story.instantiateViewController(withIdentifier: "Nevigation")
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
            }
            
        }else{
            openInappPurchase()
        }
    }
    
    func openInappPurchase()  {
        if !UserDefaults.standard.isProMember(){
            DispatchQueue.main.async {
                let vc  = InAppPurchases()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
        else { return }
        
        let options: [CIRAWFilterOption : Any] = [
            CIRAWFilterOption.noiseReductionAmount: 0.0,
            CIRAWFilterOption.luminanceNoiseReductionAmount: 0.0,
            CIRAWFilterOption.colorNoiseReductionAmount: 0.0]
        
        // this is raw || use float value to adjust remaing data
        
        let rawFilter = CIFilter(imageData: imageData, options: options)
        
        let image = rawFilter?.outputImage
        imagePreview.contentMode = .scaleAspectFill
        imagePreview.layer.cornerRadius = 8
        imagePreview.image = UIImage(ciImage: image!)
        
        
        let context = CIContext() // Prepare for create CGImage
        let cgimg = context.createCGImage((rawFilter?.outputImage)!, from: (rawFilter?.outputImage?.extent)!)
        let output = UIImage(cgImage: cgimg!)
        SelectedPhoto = output
        editButton.isHidden = false
        
        UIImageWriteToSavedPhotosAlbum(output, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            showAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
            showAlertWith(title: "Saved!", message: "Your image has been saved to your photos.")
        }
    }
    
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    
}
