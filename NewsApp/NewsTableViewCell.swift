//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by 孙政 on 2021/5/26.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleText: UILabel!
    
    @IBOutlet weak var timeText: UILabel!
    
    @IBOutlet weak var imageContent: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
