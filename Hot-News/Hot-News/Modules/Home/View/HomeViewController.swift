//
//  HomeViewController.swift
//  Hot-News
//
//  Created by Apple on 8/07/22.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    // MARK: IBoutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var profileButton: UIButton!
    @IBOutlet private weak var profileImage: UIImageView!
    
    // MARK: Properties
    private var viewModel: ViewModelHomeProtocol
    private var disposeBag = DisposeBag()
    
    // MARK: Initializers
    init() {
        self.viewModel = ViewModelHome()
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    private func setupUI() {
        collectionView.contentInset = UIEdgeInsets(top: 70, left: 0, bottom: 0, right: 0)
        profileImage.layer.cornerRadius = profileImage.bounds.height / 2
        profileImage.image = UIImage(named: "user1")
        profileImage.contentMode = .scaleAspectFill
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       subscribeToHomeInformation()
        setupUI()
        configureCollection()
    }
    
    private func subscribeToHomeInformation() {
        viewModel.callService()
            .subscribe { posts in
                self.collectionView.reloadData()
            }.disposed(by: disposeBag)
    }
    
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PostViewCell", bundle: nil), forCellWithReuseIdentifier: "PostViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: IBActions
    
    @IBAction private func openProfileView(_ sender: Any) {
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
}

// MARK: UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostViewCell", for: indexPath) as? PostViewCell else{
            return UICollectionViewCell()
        }
        cell.configurateCell(post: viewModel.posts[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
}


// MARK: UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360, height: 110)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
}


// MARK: UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        present(CommetsViewController(post: viewModel.posts[indexPath.row]), animated: true)
    }
}

extension HomeViewController: PostViewCellDelegate {
    func onLikedPost(with postId: Int) {
        viewModel.saveLikePost(id: postId)
    }
    
}

