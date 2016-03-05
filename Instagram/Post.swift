//
//  Post.swift
//  Instagram
//
//  Created by Javier Bustillo on 3/5/16.
//  Copyright © 2016 Javier Bustillo. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let media = PFObject(className: "Post")
        
        media["media"] = getPFFileFromImage(image)
        media["author"] = PFUser.currentUser()
        media["caption"] = caption
        
        
        media.saveInBackgroundWithBlock(completion)
    }
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        
        if let image = image {
            
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}
