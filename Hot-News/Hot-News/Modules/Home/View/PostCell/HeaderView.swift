//
//  HeaderView.swift
//  Hot-News
//
//  Created by Apple on 8/07/22.
//

import UIKit

class HeaderView: UICollectionReusableView {
    @IBOutlet weak var headerTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupHeader(title: String) {
        headerTitle.text = title
    }
    
}
