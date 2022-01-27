//
//  FavViewController.swift
//  Filter It
//
//  Created by Saif on 03/01/22.
//

import UIKit

class FavViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath)
        as! mainCell
        
        cell.photoView.image = arrayofFavimages[indexPath.row]
        cell.favAddButton.isHidden = true
        cell.premiumLabal.isHidden = true
        
        
        return cell
    }
    
    var arrayofFavimages:[UIImage] = [UIImage]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayofFavimages.count
    }
    
    @IBOutlet weak var myView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = UserDefaults.standard.value(forKey: "fav") as? Data {
            if let dict = NSKeyedUnarchiver.unarchiveObject(with: data) as? [[Int:Int]] {
        
                for i in dict {
                    getImagewithFilter(row: i.first?.key ?? 0, item: i.first?.value ?? 0) { Image in
                        self.arrayofFavimages.append(Image!)
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.myView.delegate = self
                    self.myView.dataSource = self
                    self.myView.reloadData()
                }
                
            }
        }


       
    }
    
    
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        dismiss(animated: true) {
            if let data = UserDefaults.standard.value(forKey: "fav") as? Data {
                if let dict = NSKeyedUnarchiver.unarchiveObject(with: data) as? [[Int:Int]] {
                    
                    DispatchQueue.main.async {
                        let main = UIStoryboard.init(name: "Main", bundle: Bundle.main)
                        let vc = main.instantiateViewController(withIdentifier: "ImageColorEditorVC") as! ImageColorEditorVC
                        vc.modalPresentationStyle = .fullScreen
                        vc.row = dict[indexPath.row].first?.key
                        vc.item = dict[indexPath.row].first?.value
                        if let topController = UIApplication.topViewController() {
                            topController.present(vc, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = self.myView.bounds.width / 2.1
        
        return CGSize(width: size , height: size)
    }


}


extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
