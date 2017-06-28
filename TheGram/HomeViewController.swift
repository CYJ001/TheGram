//
//  HomeViewController.swift
//  TheGram
//
//  Created by Chanel Johnson on 6/27/17.
//  Copyright © 2017 Chanel Johnson. All rights reserved.
//

import UIKit
import Parse
class HomeViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var pictures: [PFObject]? = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        fetchPhotos()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "PictureCell", for: indexPath) as! PictureCell
        let pictureData = pictures?[indexPath.row]
            let image = pictureData?["media"] as! PFFile
        image.getDataInBackground { (imageData:Data!,error: Error?) in
            cell.postView.image = UIImage(data:imageData)
        }
        
      /*  if let user = messageData?["user"] as? PFUser {
            // User found! update username label with username
            cell.usernameLabel.text = user.username
        } else {
            // No user found, set default username
            cell.usernameLabel.text = "🤖"
        }*/
        let caption = pictureData?["caption"] as! String
        //cell.postView.image = picture
        cell.captionUploadLabel.text = caption
        return cell 
 
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func fetchPhotos(){
        let query = PFQuery(className: "Post")
        query.includeKey("user")
        query.addDescendingOrder("createdAt")
        
        query.findObjectsInBackground(block: { (pictures : [PFObject]?, error: Error?) in
            self.pictures = pictures
            self.tableView.reloadData()
        })
    }
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
