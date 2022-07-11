//
//  CommetsViewController.swift
//  Hot-News
//
//  Created by Apple on 8/07/22.
//

import UIKit
import RxSwift
import RxCocoa

class CommetsViewController: UIViewController {
    // MARK: IBOutles
    @IBOutlet private weak var collectionview: UICollectionView!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var titileLabel: UILabel!
    
    // MARK: Properties
    private var viewModel: ViewModelCommentsProtocol
    private var disposeBag = DisposeBag()
    
    //MARK: Initializers
    init(post: Post) {
        self.viewModel = ViewModelComments(post: post)
        super.init(nibName: "CommetsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
        subscribeToCommentsInformation()
        setupUI()
    }
    
    // Configure collectionView
    private func configureCollection() {
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.register(UINib(nibName: "CommentCell", bundle: nil), forCellWithReuseIdentifier: "CommentCell")
        collectionview.register(UINib(nibName: "DescriptionCell", bundle: nil), forCellWithReuseIdentifier: "DescriptionCell")
    }
    
    // Subscribe to the signal of the call to the ApiServices and receive the comments of the publication and the user detail
    private func subscribeToCommentsInformation() {
        viewModel.getPostDetails()
            .subscribe(onNext:  { (comments, user) in
                self.viewModel.comments = comments
                self.viewModel.user = user
                self.configurateHeader()
                self.collectionview.reloadData()
            }).disposed(by: disposeBag)
    }
    
    
    // Configure UI
    private func setupUI() {
        userImageView.layer.cornerRadius = userImageView.bounds.height / 2
        userImageView.image = UIImage(named: viewModel.post.imageUser)
        userImageView.contentMode = .scaleAspectFill
    }
    
    // Configure header
    private func configurateHeader() {
        titileLabel.text = viewModel.post.title.capitalized
        nameLabel.text = "Write by: \(viewModel.user.name)"
        emailLabel.text = viewModel.user.email
    }
    
    // Get text size
    private func takeHeigthOftTitle(text: String, font: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 50))
        label.text = text
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byTruncatingHead
        label.font = UIFont(name: "System", size: font)
        label.sizeToFit()
        let heigth = label.bounds.height
        return heigth
    }
    
    
}
// MARK: UICollectionViewDataSource
extension CommetsViewController: UICollectionViewDataSource {
    // Register number of items in sections
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return viewModel.comments.count
    }
    
    // Register and configure cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cellDescription = collectionView.dequeueReusableCell(withReuseIdentifier: "DescriptionCell", for: indexPath) as? DescriptionCell else {
                return UICollectionViewCell()
            }
            if viewModel.comments.count > 0 {
                cellDescription.configureCell(description: viewModel.post.body)
            }
            return cellDescription
        } else {
            guard let cellComment = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCell", for: indexPath) as? CommentCell else {
                return UICollectionViewCell()
            }
            if viewModel.comments.count > 0 {
                cellComment.configurateCell(comment: viewModel.comments[indexPath.row])
            }
            return cellComment
        }
    }
    
    // Register number of sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
}
// MARK: UICollectionViewDelegate
extension CommetsViewController: UICollectionViewDelegate {}


// MARK: UICollectionViewDelegateFlowLayout
extension CommetsViewController: UICollectionViewDelegateFlowLayout {
    // Register size of items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 32
        var heigth: CGFloat = 0.0
        guard indexPath.section == 0 else {
            heigth = takeHeigthOftTitle(text: viewModel.comments[indexPath.row].body, font: 14)
            return CGSize(width: width, height: heigth + 40)
        }
        heigth = takeHeigthOftTitle(text: viewModel.post.body, font: 16)
        return CGSize(width: width - 32, height: heigth + 80)
    }
    
    // Register spacing of cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return section == 0 ? 0.0 : 20
    }
}


