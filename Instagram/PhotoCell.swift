//
//  PhotoCell.swift
//  Instagram
//
//  Created by Javier Bustillo on 3/1/16.
//  Copyright © 2016 Javier Bustillo. All rights reserved.
//

import UIKit
import Parse
import AFNetworking



class PhotoCell: UITableViewCell {

    @IBOutlet weak var captionLabel: UILabel!
    
    
    @IBOutlet weak var postImageView: UIImageView!
    
   var post: PFObject!{
        didSet {
            captionLabel.text = post["caption"] as? String
           
            let file = post["media"] as? PFFile
            let url = NSURL(string: (file?.url)!)
            postImageView.setImageWithURL(url!)
            
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
