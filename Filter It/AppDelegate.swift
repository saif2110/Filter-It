//
//  AppDelegate.swift
//  Filter It
//
//  Created by Saif on 21/11/21.
//

import Purchases
import UIKit
import FirebaseCore


var premiumFilters = [1,3,4,6]

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: "appl_yhlBkfnbkEMelAFuCdpQTDSAUmw")
        isSubsActive()
        
        if UserDefaults.standard.isProMember(){
            premiumFilters.removeAll()
        }
        
        UserDefaults.standard.setnumberOftimeAppOpen(value: UserDefaults.standard.getnumberOftimeAppOpen() + 1)
      
       FirebaseApp.configure()
        
        return true
    }
    
    
    func isSubsActive(){
        
        Purchases.shared.purchaserInfo { (purchaserInfo, error) in
            
            if purchaserInfo?.entitlements.all[IPA.OneYearPro.rawValue]?.isActive == true ||
                purchaserInfo?.entitlements.all[IPA.OneMonthPro.rawValue]?.isActive == true {
                
                UserDefaults.standard.setisProMember(value: true)
                
            }else{
                
                UserDefaults.standard.setisProMember(value: false)
                
            }
        }
    }
    
}



import UIKit

extension UIView {
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }

    
    @IBInspectable var shadowLight: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow2()
            }
        }
    }
    
    @IBInspectable var isCircle: Bool {
        get {
            return false
        }
        set {
            if newValue == true {
                self.layer.cornerRadius = self.layer.bounds.width/2
                self.backgroundColor = .white
                
                
                // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
                if shadow == false {
                    self.layer.masksToBounds = true
                }
            }
        }
    }
    
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            if isCircle {
                self.layer.cornerRadius = self.layer.frame.width/2
            } else{
                self.layer.cornerRadius = newValue
            }
            
            // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
            if shadow == false {
                self.layer.masksToBounds = true
            }
        }
    }
    
    
    func addShadow(shadowColor: CGColor = UIColor.lightGray.cgColor,
                   shadowOffset: CGSize = CGSize(width: 0, height: 0),
                   shadowOpacity: Float = 0.8,
                   shadowRadius: CGFloat = 4.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        self.center = center
    }
    
    
    func addShadow2(shadowColor: CGColor = UIColor.lightGray.cgColor,
                   shadowOffset: CGSize = CGSize(width: 0, height: 0),
                   shadowOpacity: Float = 0.75,
                   shadowRadius: CGFloat = 4.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        self.center = center
    }
}



extension UIImageView {
    func applyshadowWithCorner(containerView : UIView, cornerRadious : CGFloat){
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.lightGray.cgColor
        containerView.layer.shadowOpacity = 0.7
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = 3
        containerView.layer.cornerRadius = cornerRadious
        //containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
    }
}

