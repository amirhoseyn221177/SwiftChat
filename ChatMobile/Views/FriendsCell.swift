//
//  FriendsCell.swift
//  SwiftChatApp
//
//  Created by Amir Sayyar on 2021-06-22.
//

import UIKit

class FriendsCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var friendView: UIView!
    @IBOutlet weak var friendCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        friendCell.sizeToFit()
    
    }
    
    func updateTheImageView(imageData : Data?){
        userImage.image = UIImage(data: imageData!)
    }
    
    

    
    
    
    
}
