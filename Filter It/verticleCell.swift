//
//  verticleCell.swift
//  Filter It
//
//  Created by Saif on 02/12/21.
//

import UIKit

public var favObject:[[Int:Int]] = [[Int:Int]]()

class verticleCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var tagForCollection:Int?
    
    @IBOutlet weak var mainTitle: UILabel!
    
    @IBOutlet weak var mainDescription: UILabel!
    
    var arraytoBedisplay:[UIImage] = [UIImage]()
    
    
    var favSelected:[Int] = [Int]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arraytoBedisplay.count
    }
    
    
    @IBOutlet weak var myView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath)
        as! mainCell
        
        if let data = UserDefaults.standard.value(forKey: "fav") as? Data {
            if let dict = NSKeyedUnarchiver.unarchiveObject(with: data) as? [[Int:Int]] {
                favObject = dict
                for i in dict {
                    if i.keys.contains(tagForCollection ?? 0) {
                        if i.values.contains(indexPath.row) {
                            for j in i.values {
                                favSelected.append(j)
                            }
                        }
                    }
                }
            }
        }
        
        
       
        cell.photoView.image = arraytoBedisplay[indexPath.row]
        cell.photoView.tag = indexPath.row
        cell.favAddButton.tag = indexPath.row
        cell.favAddButton.addTarget(self, action: #selector(addfiltertoFav), for: .touchUpInside)
        
        if favSelected.contains(indexPath.row){
            cell.favAddButton.setImage(UIImage(named: "fav-fill"), for: .normal)
        }else{
            cell.favAddButton.setImage(UIImage(named: "fav"), for: .normal)
        }
        
        cell.premiumLabal.isHidden = premiumFilters.contains(indexPath.row) ? false : true
        
        cell.favAddButton.isHidden = premiumFilters.contains(indexPath.row) ? true : false
        
        return cell
    }
    
    
    @objc func addfiltertoFav(sender:UIButton) {
        
        if favSelected.contains(sender.tag){
            // remove fav from storage and UI changes
            favSelected = favSelected.filter {$0 != sender.tag}
            sender.setImage(UIImage(named: "fav"), for: .normal)
            favObject = favObject.filter {$0 != [tagForCollection ?? 0 : sender.tag]}
            let data = try? NSKeyedArchiver.archivedData(withRootObject: favObject, requiringSecureCoding: false)
            UserDefaults.standard.set(data, forKey: "fav")
        }else{
            // add fav to storage and UI changes
            favSelected.append(sender.tag)
            favObject.append([tagForCollection ?? 0 : sender.tag])
            sender.setImage(UIImage(named: "fav-fill"), for: .normal)
            let data = try? NSKeyedArchiver.archivedData(withRootObject: favObject, requiringSecureCoding: false)
            UserDefaults.standard.set(data, forKey: "fav")
        }
        //print(favObject)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if !premiumFilters.contains(indexPath.row) {
            NotificationCenter.default.post(name: Notification.Name("filterSelected"), object: nil, userInfo: ["row": tagForCollection ?? 0,"item":indexPath.row])
        }else{
            
            let vc = InAppPurchases()
            vc.modalPresentationStyle = .fullScreen
            if let topController = UIApplication.topViewController() {
                topController.present(vc, animated: true, completion: nil)
            }
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing = 10 * 3 // 10 points spacing between cells, two on each side
        let availableWidth = collectionView.bounds.width - CGFloat(totalSpacing)

        // Calculate the width for each cell (divide available width by 2 for two cells in one row)
        let cellWidth = availableWidth / 2
        
        // Set the height to be the same as the width to make it a square cell
        let cellHeight = cellWidth
        
        // Return the CGSize with equal width and height for the cell
        return CGSize(width: cellWidth, height: cellHeight)
    }

    
    
    func calldelegate(){
        self.myView.delegate = self
        self.myView.dataSource = self
        self.myView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
        
    }

}
