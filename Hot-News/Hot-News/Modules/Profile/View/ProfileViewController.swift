//
//  ProfileViewController.swift
//  Hot-News
//
//  Created by Apple on 8/07/22.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {
    //MARK: @IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //MARK: Properties
    private var viewModel: ViewModelProfileProtocol
    private var disposeBag = DisposeBag()
    
    //MARK: Initizlizers
    
    init() {
        self.viewModel = ViewModelProfile()
        super.init(nibName: "ProfileViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getProfileDetail()
            .take(until: self.rx.deallocated)
            .subscribe { user, posts in
                self.viewModel.posts = posts
                self.viewModel.user = user
                self.collectionView.reloadData()
            }
        
        navigationController?.navigationBar.isHidden = false
        configureCollection()
    }
    
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "HeaderProfileCell", bundle: nil), forCellWithReuseIdentifier: "HeaderProfileCell")
        collectionView.register(UINib(nibName: "PostViewCell", bundle: nil), forCellWithReuseIdentifier: "PostViewCell")
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let headerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderProfileCell", for: indexPath) as? HeaderProfileCell else {
                return UICollectionViewCell()
            }
            headerCell.setupCell(user: viewModel.user, post: viewModel.posts.count)
            return headerCell
        default:
            guard let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostViewCell", for: indexPath) as? PostViewCell else {
                return UICollectionViewCell()
            }
            postCell.configurateCell(post: viewModel.posts[indexPath.row])
            return postCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return viewModel.posts.count
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: 330, height: 230)
        
        default:
            return CGSize(width: 360, height: 110)
        }
        
    }
}

extension ProfileViewController: UICollectionViewDelegate {
    
}
