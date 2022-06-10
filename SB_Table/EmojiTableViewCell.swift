//
//  EmojiTableViewCell.swift
//  SB_Table
//
//  Created by andrew on 18.04.22.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {

    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func set (object: Emoji) {
        emojiLabel.text = object.emoji
        nameLabel.text = object.name
        descriptionLabel.text = object.description
        
    }
}
