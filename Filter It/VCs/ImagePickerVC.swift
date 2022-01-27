//
//  ImagePickerVC.swift
//  Filter It
//
//  Created by Saif on 29/11/21.
//

import UIKit
import Photos
import OpalImagePicker

class ImagePickerVC: UIViewController,OpalImagePickerControllerDelegate {
    
    var didTapCancel = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
   
    
    override func viewDidAppear(_ animated: Bool) {
        
        let imagePicker = OpalImagePickerController()
        imagePicker.modalPresentationStyle = .fullScreen
        imagePicker.maximumSelectionsAllowed = 1
        imagePicker.allowedMediaTypes = Set([PHAssetMediaType.image])
        imagePicker.imagePickerDelegate = self
        self.present(imagePicker, animated: false, completion: nil)
    }
    
    
    func imagePickerDidCancel(_ picker: OpalImagePickerController) {
        self.dismiss(animated: false, completion: nil)
        self.tabBarController?.selectedIndex = 0
    }
    



func imagePicker(_ picker: OpalImagePickerController, didFinishPickingAssets assets: [PHAsset]) {
    
    let generator = UIImpactFeedbackGenerator(style: .medium)
    generator.impactOccurred()
    
    let img = proFilterClass.call.pro1(photoTObeEdit: convertImageFromAsset(asset: assets[0]))
    
    //print(assets.count)
    
    SelectedPhoto = img
    
    dismiss(animated: true) {
        
        DispatchQueue.main.async {
            let main = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = main.instantiateViewController(withIdentifier: "PhotoEditorVC") as! PhotoEditorVC
            vc.modalPresentationStyle = .fullScreen
            if let topController = UIApplication.topViewController() {
                topController.present(vc, animated: true, completion: nil)
            }
            
        }
        
    }
    
}

func convertImageFromAsset(asset: PHAsset) -> UIImage {
    let manager = PHImageManager.default()
    let option = PHImageRequestOptions()
    var image = UIImage()
    option.isSynchronous = true
    manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
        image = result!
    })
    return image
}

}

