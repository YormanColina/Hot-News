//
//  HeaderProfileCell.swift
//  Hot-News
//
//  Created by Apple on 10/07/22.
//

import UIKit

class HeaderProfileCell: UICollectionViewCell {
    // MARK: @IBOutlets
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var postsQuantityLabel: UILabel!
    @IBOutlet private weak var likesQuantityLabel: UILabel!
    @IBOutlet private weak var editProfileButton: UIButton!
    @IBOutlet private weak var emailLoader: UIView!
    @IBOutlet private weak var userNameLoader: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // Configure UI of cell
    private func setupUI() {
        userImageView.layer.cornerRadius = userImageView.bounds.width / 2
        userImageView.contentMode = .scaleAspectFill
    }
    
    // Configure cell information
    func configureCell(user: User, post: Int, likes: Int) {
        nameLabel.text = user.userName
        userNameLabel.text = user.email
        emailLoader.backgroundColor = .clear
        userNameLoader.backgroundColor = .clear
        postsQuantityLabel.text = String(post)
        likesQuantityLabel.text = String(likes)
        editProfileButton.layer.cornerRadius = 10
        userImageView.image = UIImage(named: "user1")
    }

}
