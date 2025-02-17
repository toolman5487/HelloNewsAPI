//
//  AppleTableViewCell.swift
//  HelloNewsAPI
//
//  Created by Willy Hsu on 2025/1/14.
//

import UIKit

class AppleTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var appleNewsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
