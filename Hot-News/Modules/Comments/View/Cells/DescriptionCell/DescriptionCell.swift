//
//  DescriptionCell.swift
//  Hot-News
//
//  Created by Apple on 9/07/22.
//

import UIKit

class DescriptionCell: UICollectionViewCell {

    @IBOutlet private weak var descriptionLabel: UILabel!
    
    func configureCell(description: String) {
        descriptionLabel.text = description
    }
}
