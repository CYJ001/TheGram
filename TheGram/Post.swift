//
//  Post.swift
//  TheGram
//
//  Created by Chanel Johnson on 6/27/17.
//  Copyright © 2017 Chanel Johnson. All rights reserved.
//

import Foundation
import Parse
class Post : NSObject {
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        post["media"] = getPFFileFromImage(image: image) // PFFile column type
        post["author"] = PFUser.current() // Pointer column type that points to PFUser
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        let date = Date()
        let formatter = DateFormatter()
formatter.dateFormat = "EEEE, MMM d, yyyy"
        let result = formatter.string(from: date)
        post["date"] = result
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)
    }
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
}
