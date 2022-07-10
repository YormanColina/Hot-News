//
//  PostViewCell.swift
//  Hot-News
//
//  Created by Apple on 8/07/22.
//

import UIKit

class PostViewCell: UICollectionViewCell {
    // MARK: IBOutlet:
    @IBOutlet weak var titlePostLabel: UILabel!
    @IBOutlet weak var userPostImageView: UIImageView!
    @IBOutlet weak var leadingView: UIView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUICell()
    }
    //MARK: Properties
    
    
    //MARK: Methods
    private func setupUICell() {
        leadingView.backgroundColor = .blue
        leadingView.backgroundColor = UIColor(named: "customBlue")
        userPostImageView.layer.cornerRadius = userPostImageView.bounds.height / 2
        userPostImageView.layer.shadowColor = UIColor.black.cgColor
        userPostImageView.layer.shadowOffset = CGSize(width: 10, height: 10)
        userPostImageView.layer.shadowOpacity = 1
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 3, height: 5)
        layer.masksToBounds = false
        layer.cornerRadius = 20
        layer.borderWidth = 0.1
        layer.borderColor = UIColor.darkGray.cgColor
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
    }
    
    func configurateCell(post: Post) {
        titlePostLabel.text = post.title.capitalized
        descriptionLabel.text = post.body
    }

    @IBAction func pressLike(_ sender: Any) {
        
    }
    
    func sendLike() -> Int {
        return 1
    }
}
