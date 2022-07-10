//
//  HeaderProfileCell.swift
//  Hot-News
//
//  Created by Apple on 10/07/22.
//

import UIKit

class HeaderProfileCell: UICollectionViewCell {
    // MARK: @IBOutlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postsQuantityLabel: UILabel!
    @IBOutlet weak var likesQuantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    private func configureCell() {
        userImageView.layer.cornerRadius = userImageView.bounds.width / 2
    }
    
    func setupCell(user: User, post: Int) {
        nameLabel.text = user.userName
        userNameLabel.text = user.email
        postsQuantityLabel.text = String(post)
    }

}
