//
//  ImageColorEditorVC.swift
//  Filter It
//
//  Created by Saif on 19/12/21.
//

import UIKit

class ImageColorEditorVC: UIViewController {
    
    var row:Int?
    var item:Int?
    
    var selectedLocal:UIImage!
    
    @IBOutlet weak var brightnessSlider: UISlider!{
        didSet{
            brightnessSlider.minimumValue = -0.6
            brightnessSlider.maximumValue = 0.6
        }
    }
    
    @IBOutlet weak var contrastSlider: UISlider!{
        didSet{
            contrastSlider.minimumValue = 0.5
            contrastSlider.maximumValue = 1.5
        }
    }
    
    
    @IBOutlet weak var saturationSlider: UISlider!{
        didSet{
            saturationSlider.minimumValue = 0.5
            saturationSlider.maximumValue = 1.5
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!{
        didSet{
            imageView.image = SelectedPhoto
        }
    }
    
    @IBOutlet weak var britnessView: UIView!
    
    @IBOutlet weak var brightnessControl: UIButton!
    
    @IBAction func brightnessAction(_ sender: Any) {
        
        let down = UIImage(named: "down")
        let up = UIImage(named: "up")
        
        brightnessControl.currentImage == down ? brightnessControl.setImage(up, for: .normal) : brightnessControl.setImage(down, for: .normal)
        
        if brightnessControl.currentImage == down {
            britnessView.isHidden = false
        }else{
            britnessView.isHidden = true
        }
        
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            self.present(myAlt(titel:"Failure",message:"Something went wrong."), animated: true, completion: nil)
            
        } else {
            self.present(myAlt(titel:"Saved!",message:"Your image has been saved to your photos."), animated: true, completion: nil)
        }
    }
    
    
    @IBOutlet weak var saveButton: UIButton!{
        didSet{
            saveButton.clipsToBounds = true
            saveButton.cornerRadius = saveButton.bounds.height/2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImagewithFilter()
    }
    
    @IBAction func scaleChnages(_ sender: Any) {
        if imageView.contentMode == .scaleAspectFit{
            imageView.contentMode = .scaleAspectFill
        }else{
            imageView.contentMode = .scaleAspectFit
        }
    }
    
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK:- if modify replicate also in PhotoEditorVC
    
    func getImagewithFilter() {
        if row == 0 {
            
            imageView.image = proFilterClass.call.ImageColorEditorVC(photoTObeEdit: SelectedPhoto!)[item ?? 0]
            selectedLocal = imageView.image
            
        }else if row == 1 {
            
            process(image: SelectedPhoto!, LUTname: soBeautifulFilterClass.call.LUTarray[item ?? 0]) { img in
                DispatchQueue.main.async {
                    self.imageView.image = img
                    self.selectedLocal = img
                }
            }
            
        }else if row == 2 {
            
            imageView.image = soColourFilterClass.call.ImageColorEditorVC(photoTObeEdit: SelectedPhoto!)[item ?? 0]
            self.selectedLocal = self.imageView.image
            
        }else if row == 3 {
            
            process(image: SelectedPhoto!, LUTname: SelfiClass.call.LUTarray[item ?? 0]) { img in
                DispatchQueue.main.async {
                    self.imageView.image = img
                    self.selectedLocal = img
                }
            }
            
        }else if row == 4 {
            
            process(image: SelectedPhoto!, LUTname: HardtouchClass.call.LUTarray[item ?? 0]) { img in
                DispatchQueue.main.async {
                    self.imageView.image = img
                    self.selectedLocal = img
                }
            }
        }else if row == 5 {
            
            process(image: SelectedPhoto!, LUTname: CinematicClass.call.LUTarray[item ?? 0]) { img in
                DispatchQueue.main.async {
                    self.imageView.image = img
                    self.selectedLocal = img
                }
            }
        }else if row == 6 {
            
            process(image: SelectedPhoto!, LUTname: blackWhiteFilterClass.call.LUTarray[item ?? 0]) { img in
                DispatchQueue.main.async {
                    self.imageView.image = img
                    self.selectedLocal = img
                }
            }
        }
    }
    
    
    @IBAction func brightness(_ sender: UISlider) {
        imageView.image = Brightness(intensity: sender.value, image: selectedLocal)
    }
    
    @IBAction func contrast(_ sender: UISlider) {
        imageView.image = Contrast(intensity: sender.value, image: selectedLocal)
    }
    
    @IBAction func saturation(_ sender: UISlider) {
        imageView.image = Saturation(intensity: sender.value, image: selectedLocal)
    }
    
}
