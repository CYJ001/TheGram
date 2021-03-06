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
    @IBOutlet weak var userLabel: UILabel!
    var pictures: [PFObject]? = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        fetchPhotos()
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
       refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
    
        // Do any additional setup after loading the view.
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        // ... Create the URLRequest `myRequest` ...
        
        // Configure session so that completion handler is executed on main UI thread
       
            
            // ... Use the new data to update the data source ...
            fetchPhotos()
            // Reload the tableView now that there is new data
            tableView.reloadData()
            
            // Tell the refreshControl to stop spinning
            refreshControl.endRefreshing()
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
        //cell.userLabel.text = PFUser.current()?.username
        if let user = pictureData?["author"] as? PFUser {
            print(user.username)
            cell.userLabel.text = user.username
        }
        return cell 
 
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let  post = pictures?[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.post = post!
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func fetchPhotos(){
        let query = PFQuery(className: "Post")
        query.limit = 20
        query.includeKey("author")
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
