//
//  InAppPurchases.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 19/06/21.
//

import UIKit
import Purchases
import Photos
import SafariServices

enum IPA:String {
    case OneMonthPro = "FilterProMonth"
    case OneYearPro = "FilterProYear"
}


var purpleColur = #colorLiteral(red: 0.1607843137, green: 0.1137254902, blue: 0.1725490196, alpha: 1)
var selectedIPA = 0

class InAppPurchases: UIViewController {
    
    var AllPackage = [Purchases.Package]()
    
    
    @IBOutlet weak var continueOutlet: UIButton!{
        didSet{
            continueOutlet.clipsToBounds = true
            continueOutlet.layer.cornerRadius = 17
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        Purchases.shared.offerings { (offerings, error) in
            if let offerings = offerings {
                
                guard let package = offerings[IPA.OneMonthPro.rawValue]?.availablePackages.first else {
                    return
                }
                
                guard let package2 = offerings[IPA.OneYearPro.rawValue]?.availablePackages.first else {
                    return
                }
                
                self.AllPackage.append(package)
                self.AllPackage.append(package2)
                
                
                let priceone = offerings[IPA.OneMonthPro.rawValue]?.monthly?.localizedPriceString
                
                let pricetwo = offerings[IPA.OneYearPro.rawValue]?.annual?.localizedPriceString
                
              
                
              
                
                //self.PriceMessage(price: priceone ?? "$0.49")
                
               // self.PriceMessage(price: pricetwo ?? "$0.49")
                
                
            }
           
        }
        
    }

  
    
    override func viewDidAppear(_ animated: Bool) {
        backButtonoutlet.fadeIn()
        let photos = PHPhotoLibrary.authorizationStatus()
            if photos == .notDetermined {
                PHPhotoLibrary.requestAuthorization({status in
                    if status == .authorized{
                       
                    } else {}
                })
            }
    }
    
    
    func Offer(price:String,save:String) -> NSAttributedString {
        let attrString = NSMutableAttributedString(string: price+"\n",
                                                   attributes: [NSAttributedString.Key.font: UIFont(name: "Arial-BoldMT", size: 15)!,NSAttributedString.Key.foregroundColor: purpleColur]);
        
        attrString.append(NSMutableAttributedString(string: save,
                                                    attributes: [NSAttributedString.Key.font: UIFont(name: "ArialMT", size: 12)!]))
        return attrString
    }
    
    
    func PriceMessage(price:String) -> NSAttributedString {
        let attrString = NSMutableAttributedString(string: price+"\n",
                                                   attributes: [NSAttributedString.Key.font: UIFont(name: "Arial-BoldMT", size: 14)!]);
        return attrString
    }
    
    func select(vw:UIView){
        vw.layer.borderWidth = 3
        vw.layer.borderColor = purpleColur.cgColor
    }
    
    func Deselect(vw:UIView){
        vw.layer.borderWidth = 0
        vw.layer.borderColor = UIColor.clear.cgColor
    }
    
    
    func customView(vw:UIView){
        vw.layer.cornerRadius = 10
        vw.shadow2()
    }
    
    func customLabelBanner(vw:UILabel){
        vw.layer.masksToBounds = true
        vw.layer.cornerRadius = 10
        vw.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    func upperView(vw:UIView){
        vw.layer.masksToBounds = true
        vw.layer.cornerRadius = 10
        vw.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    
    @IBAction func continueAction (_ sender: Any) {
        if AllPackage.count > 0 {
            startIndicator(selfo: self)
            Purchases.shared.purchasePackage(AllPackage[selectedIPA]) { (transaction, purchaserInfo, error, userCancelled) in
                if purchaserInfo?.entitlements.all[IPA.OneMonthPro.rawValue]?.isActive == true ||  purchaserInfo?.entitlements.all[IPA.OneYearPro.rawValue]?.isActive == true {
                    
                    self.PerchesedComplte()
                    
                }else{
                    
                    stopIndicator()
                }
            }
        }
    }
    
    func PerchesedComplte(){
        stopIndicator()
        premiumFilters.removeAll()
        UserDefaults.standard.setisProMember(value: true)
        self.present(myAlt(titel:"Congratulations !",message:"You are a pro member now. Enjoy seamless experience with all features unlock."), animated: true, completion: nil)
    }
    
    @IBAction func restore(_ sender: Any) {
        
        Purchases.shared.restoreTransactions { (purchaserInfo, error) in
            
            if purchaserInfo?.entitlements.all[IPA.OneYearPro.rawValue]?.isActive == true ||  purchaserInfo?.entitlements.all[IPA.OneMonthPro.rawValue]?.isActive == true {
                
                
                self.PerchesedComplte()
                
            }
        }
        
       
    }
    
    
    
    @IBOutlet weak var backButtonoutlet:UIButton!
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toc(sender:UIButton){
        let url = URL(string: "https://apps15.com/termsofuse.html")
        let vc = SFSafariViewController(url: url!)
        vc.modalPresentationStyle = .automatic
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func privacyPolicy(sender:UIButton){
        let url = URL(string: "https://apps15.com/privacy.html")
        let vc = SFSafariViewController(url: url!)
        vc.modalPresentationStyle = .automatic
        present(vc, animated: true, completion: nil)
    }
    
}


extension UIView {
    func fadeIn(duration: TimeInterval = 1.4, delay: TimeInterval = 0.5, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.isHidden = false
            self.alpha = 0.65
        }, completion: completion)
    }
}


//https://fluffy.es/scrollview-storyboard-xcode-11/


//Add a UIScrollView to the view and add top, bottom, leading, and trailing constraints.
//Add a UIView to the scroll view. We will call this the content view.
//Add top, bottom, leading, and trailing constraints from the content view to the scroll view's Content Layout Guide. Set the constraints to 0.
//Add an equal width constraint between the content view and the scroll view's Frame Layout Guide. (Not the scroll view or the main view!)
//Temporarily add a height constraint to the content view so that you can add your content. Make sure that all content has top, bottom, leading, and trailing constraints.
//Delete the height constraint on the content view.


extension UIView {
    
    
    
    func shadow2()  {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
    }
}


var indicator = UIActivityIndicatorView()

func startIndicator(selfo:UIViewController) {
    indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    indicator.color = purpleColur
    indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    indicator.center = selfo.view.center
    selfo.view.addSubview(indicator)
    selfo.view.bringSubviewToFront(indicator)
    indicator.startAnimating()
}

func stopIndicator() {
    indicator.stopAnimating()
}


enum UserDefaultsKeys : String {
    case isLogin
    case isFirstTimeOpen
    case LikeDisLikeTime
    case numberofTimesconnected
    case isRated
    case IP1
    case IP2
    case FullAccess
    case numberOftimeAppOpen
    case isProMember
    case islifeTimePro
    case Useremail
    case Username
    case UserProfilePic
    case id
}



extension UserDefaults{
    
    func setisFirstTimeOpen(value: Bool){
        set(value,forKey: UserDefaultsKeys.isFirstTimeOpen.rawValue)
    }
    
    func isFirstTimeOpen() -> Bool{
        return bool(forKey: UserDefaultsKeys.isFirstTimeOpen.rawValue)
    }
    
    func setisProMember(value: Bool){
        set(value,forKey: UserDefaultsKeys.isProMember.rawValue)
    }
    
    func isProMember() -> Bool{
        return bool(forKey: UserDefaultsKeys.isProMember.rawValue)
    }
    
    func setislifeTimePro(value: Bool){
        set(value,forKey: UserDefaultsKeys.islifeTimePro.rawValue)
    }
    
    func islifeTimePro() -> Bool{
        return bool(forKey: UserDefaultsKeys.islifeTimePro.rawValue)
    }
    
    func setnumberOftimeAppOpen(value: Double){
        set(value,forKey: UserDefaultsKeys.numberOftimeAppOpen.rawValue)
    }
    
    func getnumberOftimeAppOpen() -> Double{
        return double(forKey: UserDefaultsKeys.numberOftimeAppOpen.rawValue)
    }
    
    func setLikeDisLikeTime(value: Double){
        set(value,forKey: UserDefaultsKeys.LikeDisLikeTime.rawValue)
    }
    
    func getLikeDisLikeTime() -> Double{
        return double(forKey: UserDefaultsKeys.LikeDisLikeTime.rawValue)
    }
    
    
    func setisLogin(value: Bool){
        set(value,forKey: UserDefaultsKeys.isLogin.rawValue)
    }
    
    func isLogin() -> Bool{
        return bool(forKey: UserDefaultsKeys.isLogin.rawValue)
    }
    
    
    func setid(value: String){
        set(value, forKey: UserDefaultsKeys.id.rawValue)
    }
    func getid() -> String{
        return string(forKey: UserDefaultsKeys.id.rawValue) ?? "123"
    }
    
    func setUserEmail(value: String){
        set(value, forKey: UserDefaultsKeys.Useremail.rawValue)
    }
    func getUserEmail() -> String{
        return string(forKey: UserDefaultsKeys.Useremail.rawValue) ?? "123"
    }
    
    func setFullAccess(value: String){
        set(value, forKey: UserDefaultsKeys.FullAccess.rawValue)
    }
    
    func getFullAccess() -> String{
        return string(forKey: UserDefaultsKeys.FullAccess.rawValue) ?? "123"
    }
    
    func setUsername(value: String){
        set(value, forKey: UserDefaultsKeys.Username.rawValue)
    }
    func getUsername() -> String{
        return string(forKey: UserDefaultsKeys.Username.rawValue) ?? "123"
    }
    
    func setUserUserProfilePic(value: String){
        set(value, forKey: UserDefaultsKeys.UserProfilePic.rawValue)
    }
    func getUserProfilePic() -> String{
        return string(forKey: UserDefaultsKeys.UserProfilePic.rawValue) ?? "null"
    }
    
}



func requestToRate() {
    if #available(iOS 14.0, *) {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    } else if #available(iOS 10.3, *) {
        SKStoreReviewController.requestReview()
    }
}
