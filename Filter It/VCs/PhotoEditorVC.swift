//
//  PhotoEditorVC.swift
//  Filter It
//
//  Created by Saif on 02/12/21.
//

import UIKit

class PhotoEditorVC: UIViewController,UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presentingViewController)
    }
    
    var done = false
    
    @IBOutlet weak var backbutton: UIButton!
    
    @IBOutlet weak var fav: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(okButtonPressed), name: Notification.Name("okButtonPressed"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(filterSelected), name: Notification.Name("filterSelected"), object: nil)
        
        addAllfiltertoVC()
        
    }
    
    var favArray = [UIImage]()
    
    @IBAction func favSelected(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        var arrayofFavimages = [UIImage]()
        
        var count = 0
        
        if let data = UserDefaults.standard.value(forKey: "fav") as? Data {
            if let dict = NSKeyedUnarchiver.unarchiveObject(with: data) as? [[Int:Int]] {
                
                for i in dict {
                    count += 1
                    getImagewithFilter(row: i.first?.key ?? 0, item: i.first?.value ?? 0) { Image in
                        arrayofFavimages.append(Image!)
                    }
                }
                
            }
            
            if count != 0  {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "FavViewController") as! FavViewController
                vc.modalPresentationStyle = .custom
                vc.transitioningDelegate = self
                self.present(vc, animated: true, completion: nil)
                
            }else{
                
                self.present(myAlt(titel:"Favorite is empty!",message:"There is no filter marked as a favorite. Please first add some filters as favorite."), animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true) {
            
            if let topController = UIApplication.topViewController() {
                topController.tabBarController?.selectedIndex = 0
            }
            
        }
    }
}


// MARK:- if modify replicate also in ImageColourEditor

func getImagewithFilter(row:Int,item:Int,completion: @escaping (UIImage?) -> Void) {
    
    let resizedImage = resizeImage(image: SelectedPhoto!, targetSize: CGSize(width: 1024, height: 1024))
    
    if row == 0 {
        
        completion(proFilterClass.call.ImageColorEditorVC(photoTObeEdit: resizedImage)[item])
        
    }else if row == 1 {
        
        process(image: resizedImage, LUTname: soBeautifulFilterClass.call.LUTarray[item]) { img in
            
            return completion(img!)
            
        }
        
    }else if row == 2 {
        
        return completion(soColourFilterClass.call.ImageColorEditorVC(photoTObeEdit: resizedImage)[item])
        
        
    }else if row == 3 {
        
        process(image: resizedImage, LUTname: SelfiClass.call.LUTarray[item]) { img in
            completion(img!)
        }
        
    }else if row == 4 {
        
        process(image: resizedImage, LUTname: HardtouchClass.call.LUTarray[item]) { img in
            completion(img!)
        }
        
    }else if row == 5 {
        
        process(image: resizedImage, LUTname: CinematicClass.call.LUTarray[item]) { img in
            completion(img!)
        }
        
    }else if row == 6 {
        
        process(image: resizedImage, LUTname: blackWhiteFilterClass.call.LUTarray[item]) { img in
            completion(img!)
        }
        
    }
}


extension PhotoEditorVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //print(parentImagearray.count)
        
        return parentImagearray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "verticleCell", for: indexPath) as! verticleCell
        
//        print(mainTitleArray[indexPath.row],parentImagearray[indexPath.row].count)
        
        print(parentImagearray[indexPath.row].count)
        
        cell.arraytoBedisplay = parentImagearray[indexPath.row]
        cell.mainTitle.text = mainTitleArray[indexPath.row]
        cell.mainDescription.text = mainDescriptionArray[indexPath.row]
        cell.tagForCollection = indexPath.row
        cell.calldelegate()
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 290
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)
        
    }
    
    @objc func okButtonPressed(notification: Notification) {
        DispatchQueue.main.async {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }
            
        
    }
    
    
    
    @objc func filterSelected(notification: Notification){
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        if let userInfo = notification.userInfo {
//            print(userInfo["row"] ?? 0)
//            print(userInfo["item"] ?? 0)
            
            DispatchQueue.main.async {
                let main = UIStoryboard.init(name: "Main", bundle: Bundle.main)
                let vc = main.instantiateViewController(withIdentifier: "ImageColorEditorVC") as! ImageColorEditorVC
                vc.modalPresentationStyle = .fullScreen
                vc.row = userInfo["row"] as? Int
                vc.item = userInfo["item"] as? Int
                self.present(vc, animated: true, completion: nil)
            }
            
        }
    }
    
}

class HalfSizePresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let bounds = containerView?.bounds else { return .zero }
        return CGRect(x: 0, y: bounds.height / 2, width: bounds.width, height: bounds.height / 2)
    }
}


//if let data = UserDefaults.standard.value(forKey: "fav") as? Data {
//    if let dict = NSKeyedUnarchiver.unarchiveObject(with: data) as? [[Int:Int]] {
//
//        for i in dict {
//            getImagewithFilter(row: i.first?.key ?? 0, item: i.first?.value ?? 0) { Image in
//                self.favArray.append(Image!)
//            }
//
//        }
//
//    }
//
//
//
//}
