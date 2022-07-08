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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUICell()
    }
    //MARK: Properties
    
    
    //MARK: Methods
    private func setupUICell() {
        backgroundColor = .white
        leadingView.backgroundColor = .blue
        layer.cornerRadius = 20
        userPostImageView.layer.cornerRadius = userPostImageView.bounds.height / 2
        leadingView.backgroundColor = UIColor(named: "customBlue")
        userPostImageView.layer.shadowColor = UIColor.black.cgColor
        userPostImageView.layer.shadowOffset = CGSize(width: 10, height: 10)
        userPostImageView.layer.shadowOpacity = 1
    }
    
    func configurateCell(post: Post) {
        titlePostLabel.text = post.title
    }

    @IBAction func pressLike(_ sender: Any) {
        print("se dio like")
    }
}
