//
//  mainCell.swift
//  Filter It
//
//  Created by Saif on 02/12/21.
//

import UIKit
import Foundation

class mainCell: UICollectionViewCell {
    
    @IBOutlet weak var favAddButton: UIButton!
    
    @IBOutlet weak var premiumLabal: UILabel!
    
    @IBOutlet weak var photoView: UIImageView!
    
    func config(isShadowon:Bool = true) {
        
        if isShadowon {
            photoView.applyshadowWithCorner(containerView: self, cornerRadious: 10)
        }else{
            self.clipsToBounds = true
            self.layer.cornerRadius = 10
        }
        
    }
}



func myAlt(titel:String,message:String)-> UIAlertController{
    let alert = UIAlertController(title: titel, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        switch action.style{
        case .default:
            print("")
        case .cancel:
            print("")
        case .destructive:
            print("")
        @unknown default:
            fatalError()
        }}))
                 
    return alert
    
}



//copy paste this

//self.present(myAlt(titel:"Failure",message:"Something went wrong."), animated: true, completion: nil)

