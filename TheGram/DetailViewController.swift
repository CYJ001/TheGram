//
//  DetailViewController.swift
//  TheGram
//
//  Created by Chanel Johnson on 6/28/17.
//  Copyright © 2017 Chanel Johnson. All rights reserved.
//

import UIKit
import Parse
class DetailViewController: UIViewController {

    @IBOutlet weak var detailCaptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    var post : PFObject?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let post = post{
            let image = post["media"] as! PFFile
            image.getDataInBackground { (imageData:Data!,error: Error?) in
                self.detailImageView.image = UIImage(data:imageData)
                let caption = post["caption"] as! String
                self.detailCaptionLabel.text = caption
                self.timeLabel.text = post["date"] as! String
        }
        // Do any additional setup after loading the view.
    }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
