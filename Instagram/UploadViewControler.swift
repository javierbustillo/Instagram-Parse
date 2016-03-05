//
//  UploadViewControler.swift
//  Instagram
//
//  Created by Javier Bustillo on 3/5/16.
//  Copyright © 2016 Javier Bustillo. All rights reserved.
//

import UIKit

class UploadViewControler: UIViewController {

    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var photoView: UIImageView!
    var uploadedPhoto = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoView.image = uploadedPhoto
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resizeImg(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    @IBAction func postButton(sender: AnyObject) {
        let image = resizeImg(photoView.image!, newSize: CGSizeMake(200,200))
        Post.postUserImage(image, withCaption: captionField.text, withCompletion: nil)
        print("posted pic")
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
