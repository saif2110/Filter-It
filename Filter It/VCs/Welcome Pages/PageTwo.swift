//
//  PageOne.swift
//  Filter It
//
//  Created by Saif on 23/01/22.
//

import UIKit
import Lottie

class PageTwo: UIViewController {
    
    @IBOutlet weak var viewLottie: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let LottiV = AnimationView()
        LottiV.frame = viewLottie.bounds
        LottiV.backgroundColor = .clear
        LottiV.animation = Animation.named("PageTwo")
        LottiV.contentMode = .scaleAspectFit
        LottiV.loopMode = .loop
        DispatchQueue.main.async {
            self.viewLottie.addSubview(LottiV)
            LottiV.play { bool in
                
            }
            
        }
        
        
    }
    
    @IBAction func next(_ sender: Any) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        dismiss(animated: true) {
            let vc = PageThree()
            vc.modalPresentationStyle = .fullScreen
            if let topController = UIApplication.topViewController() {
                topController.present(vc, animated: true, completion: nil)
            }
        }
        
    }
    
    
}
