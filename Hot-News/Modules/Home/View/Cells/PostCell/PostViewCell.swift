//
//  PostViewCell.swift
//  Hot-News
//
//  Created by Apple on 8/07/22.
//

import UIKit
import RxCocoa
import RxSwift

protocol PostViewCellDelegate: AnyObject {
    func onLikedPost(with postId: Int)
}

class PostViewCell: UICollectionViewCell {
    // MARK: IBOutlet:
    @IBOutlet private weak var titlePostLabel: UILabel!
    @IBOutlet private weak var userPostImageView: UIImageView!
    @IBOutlet private weak var leadingView: UIView!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var likeImageView: UIImageView!
    
    //MARK: Properties
    weak var delegate: PostViewCellDelegate?
    private var post: Post?
    
    //MARK: Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUICell()
    }
    
    // configure UI of cell
    private func setupUICell() {
        leadingView.backgroundColor = .blue
        leadingView.backgroundColor = UIColor(named: "customBlue")
        userPostImageView.layer.cornerRadius = userPostImageView.bounds.height / 2
        userPostImageView.layer.shadowColor = UIColor.black.cgColor
        userPostImageView.layer.shadowOffset = CGSize(width: 10, height: 10)
        userPostImageView.layer.shadowOpacity = 1
        userPostImageView.contentMode = .scaleAspectFill
        
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
    
        // Configure info of cell
    func configurateCell(post: Post, showLikeButton: Bool = true) {
        self.post = post
        titlePostLabel.text = post.title.capitalized
        descriptionLabel.text = post.body
        userPostImageView.image = UIImage(named: post.imageUser)
        configLikeIcon()
        likeImageView.isHidden = !showLikeButton
    }

    //MARK: IBActions
    
    // Action of press like Button
    @IBAction func pressLike(_ sender: Any) {
        guard let delegate = delegate, let post = post else {
            return
        }

        delegate.onLikedPost(with: post.id)
        configLikeIcon()
    }
    
    // Configure like icon of cell
    private func configLikeIcon() {
        guard let post = post else {
            return
        }
        
        let imageName = post.isLiked ? "heart-solid" : "heart-regular"
        likeImageView.image = UIImage(named: imageName)
    }
    
}
