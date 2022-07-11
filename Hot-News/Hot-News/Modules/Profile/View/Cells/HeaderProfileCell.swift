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
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var emailLoader: UIView!
    @IBOutlet weak var userNameLoader: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    private func configureCell() {
        userImageView.layer.cornerRadius = userImageView.bounds.width / 2
        userImageView.contentMode = .scaleAspectFill
    }
    
    func setupCell(user: User, post: Int, likes: Int) {
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
