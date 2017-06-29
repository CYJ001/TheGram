//
//  ProfileViewController.swift
//  TheGram
//
//  Created by Chanel Johnson on 6/27/17.
//  Copyright © 2017 Chanel Johnson. All rights reserved.
//

import UIKit
import Parse
class ProfileViewController: UIViewController, UICollectionViewDataSource {
    var pictures: [PFObject]? = []
    @IBOutlet weak var collectionView: UICollectionView!

    @IBAction func logOutUser(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            // PFUser.currentUser() will now be nil
        }
        NotificationCenter.default.post(name: NSNotification.Name("logoutNotfication"),object: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
collectionView.dataSource = self
        fetchPhotos()
        // Do any additional setup after loading the view.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures!.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SmallPictCell", for:
        indexPath) as! SmallPictCell
        let picture = pictures?[indexPath.item]
        let pictureData = pictures?[indexPath.row]
        let image = picture?["media"] as! PFFile
        image.getDataInBackground { (imageData:Data!,error: Error?) in
            cell.smallPictView.image = UIImage(data:imageData)
        }
return cell
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func fetchPhotos(){
        let query = PFQuery(className: "Post")
        query.limit = 20
        query.includeKey("user")
        query.addDescendingOrder("createdAt")
        
        query.findObjectsInBackground(block: { (pictures : [PFObject]?, error: Error?) in
            self.pictures = pictures
            self.collectionView.reloadData()
        })
        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
}
