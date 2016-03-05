//
//  FeedViewController.swift
//  Instagram
//
//  Created by Javier Bustillo on 3/1/16.
//  Copyright © 2016 Javier Bustillo. All rights reserved.
//

import UIKit
import Parse
import AFNetworking

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var posts: [PFObject]!
    
    let imagePicker = UIImagePickerController()
    var image: UIImage = UIImage()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
        refreshData()
        
        // Do any additional setup after loading the view.
    }

    func refreshData() {
        
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let media = media {
                self.posts = media
                self.tableView.reloadData()
            } else {
                // handle error
            }
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          if let posts = posts {
            return posts.count
        }
        else {
            return 0
        }
        
        
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
        
        cell.post = posts![indexPath.row]
        
        
        return cell
    }
    
    @IBAction func logOut(sender: AnyObject) {
        PFUser.logOutInBackground()
        dismissViewControllerAnimated(false, completion: nil)
    }
    @IBAction func uploadImage(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        imagePicker.delegate = self
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
    
        
        self.image = originalImage
        
        dismissViewControllerAnimated(false, completion: nil)
        performSegueWithIdentifier("upload", sender: self)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "upload" {
            let vc = segue.destinationViewController as! UploadViewControler
            vc.uploadedPhoto = self.image
        
    }
    

}
}