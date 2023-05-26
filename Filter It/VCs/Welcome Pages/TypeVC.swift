//
//  TypeVC.swift
//  Motivational Widget
//
//  Created by Junaid Mukadam on 25/04/21.
//

import UIKit
import AppTrackingTransparency

var isFirsttimeClick = true

class TypeVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var mainTitle: UILabel!
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        type.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectType", for: indexPath) as! selectType
        
        cell.typeTXT.text = type[indexPath.item].capitalized
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: 60)
    }
    
    
    var selectdType = [String]()
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! selectType
        
        bounce(cell: cell)
        
        if cell.blueView.backgroundColor != .white {
            deSelect(cell: cell)
        }else{
            select(cell:cell)
        }
    }
    
    func select(cell:selectType) {
        cell.typeTXT.textColor = .white
        cell.imageVIew.tintColor = .white
        cell.blueView.backgroundColor = UIColor.systemGreen
        //cell.blueView.layer.borderColor = tintColor.cgColor
        
        selectdType.append(cell.typeTXT.text!)
        if selectdType.count > 2{
            getStartedOutlet.isEnabled = true
            getStartedOutlet.backgroundColor = UIColor.systemGreen
            getStartedOutlet.setTitle(isFirsttimeClick ? "CONTINUE" : "GET STARTED", for: .normal)
        }
    }
    
    func deSelect(cell:selectType) {
        cell.typeTXT.textColor = UIColor.black
        cell.imageVIew.tintColor = UIColor.black
        cell.blueView.backgroundColor = UIColor.white
        //cell.blueView.layer.borderColor = UIColor.white.cgColor
        
        selectdType.removeAll { $0 == cell.typeTXT.text! }
        if selectdType.count < 3{
            getStartedOutlet.isEnabled = false
            getStartedOutlet.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.3)
            getStartedOutlet.setTitle("SELECT THREE", for: .normal)
            
        }
    }
    
    func bounce(cell:selectType){
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            
            // HERE
            cell.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2) // Scale your image
            
        }) { (finished) in
            UIView.animate(withDuration: 0.1, animations: {
                
                cell.transform = CGAffineTransform.identity // undo in 1 seconds
                
            })
        }
    }
    
    
    
    @IBOutlet weak var getStartedOutlet: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var type = [
        "Creativity",
        "Personalization",
        "Quality",
        "Versatility",
        "Fun",
        "Professionalism",
        "Expression",
        "Aesthetics",
        "Engagement",
        "Memorable"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTitle.text = isFirsttimeClick ? "Why you want use this app for ?" : "What you like the most in editing apps ?"
        
        getStartedOutlet.isEnabled = false
        getStartedOutlet.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.3)
        getStartedOutlet.setTitleColor(UIColor.white, for: .normal)
        
        getStartedOutlet.setTitle("SELECT THREE", for: .normal)
        
        self.collectionView.register(UINib(nibName: "selectType", bundle: nil), forCellWithReuseIdentifier: "selectType")
        
        self.collectionView.backgroundColor = .white
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
        
    }
    
    
    
    @IBAction func getStarted(_ sender: Any) {
        if isFirsttimeClick {
            //same page
         
            dismiss(animated: true) {
                let vc = TypeVC()
                
                vc.type = ["Versatility","Flexibility","Efficiency","Control","Creativity","Filters","Effects","AI"]
                
                vc.modalPresentationStyle = .fullScreen
                if let topController = UIApplication.topViewController() {
                    topController.present(vc, animated: false, completion: nil)
                }
            }
            
        }else{
            
            //continue
            dismiss(animated: true) {
                let vc = InAppPurchases()
                vc.modalPresentationStyle = .fullScreen
                if let topController = UIApplication.topViewController() {
                    topController.present(vc, animated: false, completion: nil)
                }
            }
            
        }
        
        
        
        isFirsttimeClick = false
        
    }
}



