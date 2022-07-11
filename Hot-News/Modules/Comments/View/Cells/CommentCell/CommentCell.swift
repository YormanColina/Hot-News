//
//  CommentCell.swift
//  Hot-News
//
//  Created by Apple on 9/07/22.
//

import UIKit

class CommentCell: UICollectionViewCell {

    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func configurateCell(comment: Comment) {
        nameLabel.text = comment.name.capitalized
        emailLabel.text = comment.email
        commentLabel.text = comment.body
        userImageView.image = UIImage(named: comment.userImage)
    }
    
    private func setupUI() {
        userImageView.layer.cornerRadius = userImageView.bounds.height / 2
        userImageView.contentMode = .scaleAspectFill
    }

}
