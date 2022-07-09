//
//  DescriptionCell.swift
//  Hot-News
//
//  Created by Apple on 9/07/22.
//

import UIKit

class DescriptionCell: UICollectionViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(description: String) {
        descriptionLabel.text = description
    }
}
