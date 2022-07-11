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
    @IBOutlet private weak var collectionView: UICollectionView!
    
    
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
    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToProfileInformation()
        setupTransparentNavigationBar()
        configureNavigationBar()
    }
    
    private func subscribeToProfileInformation() {
        viewModel.getProfileDetail()
            .take(until: self.rx.deallocated)
            .subscribe { user, posts in
                self.viewModel.posts = posts
                self.viewModel.user = user
                self.collectionView.reloadData()
            }.disposed(by: disposeBag)
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        configureCollection()
        navigationItem.leftBarButtonItem = customizingNavigationBar(image: UIImage(named: "arrow")!, imageWidth: 20, imageHeight: 20, completion: {
            dismissViewController()
        })
    }
    
    
    private func configureCollection() {
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        collectionView.delegate = self
        collectionView.dataSource = self
        layout?.sectionHeadersPinToVisibleBounds = true
        collectionView.register(UINib(nibName: "HeaderProfileCell", bundle: nil), forCellWithReuseIdentifier: "HeaderProfileCell")
        collectionView.register(UINib(nibName: "PostViewCell", bundle: nil), forCellWithReuseIdentifier: "PostViewCell")
        collectionView.register(UINib(nibName: "HeaderCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCell")
    }
    
    @objc private func dismissViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    private func customizingNavigationBar(image: UIImage, imageWidth: CGFloat, imageHeight: CGFloat, completion: () -> Void) -> UIBarButtonItem {
        let buttonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        let leftImageView = UIImageView(frame: .zero)
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        leftImageView.widthAnchor.constraint(equalToConstant: imageWidth).isActive = true
        leftImageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        leftImageView.contentMode = .scaleAspectFit
        leftView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        leftView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        let button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        leftView.backgroundColor = .white
        leftView.addSubview(leftImageView)
        leftView.addSubview(button)
        leftView.layer.cornerRadius = 22
        leftImageView.image = image
        leftImageView.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 12).isActive = true
        leftImageView.topAnchor.constraint(equalTo: leftView.topAnchor, constant: 12).isActive = true
        button.topAnchor.constraint(equalTo: leftView.topAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: leftView.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: leftView.trailingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: leftView.bottomAnchor).isActive = true
        buttonItem.customView = leftView
        navigationController?.navigationBar.barTintColor = .white
        return buttonItem
    }
    
    private func setupTransparentNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationItem.compactAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.standardAppearance = appearance
    }
}


//MARK: UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDataSource {
    // Register cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let headerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderProfileCell", for: indexPath) as? HeaderProfileCell else {
                return UICollectionViewCell()
            }
            headerCell.setupCell(user: viewModel.user, post: viewModel.posts.count, likes: viewModel.likes)
            return headerCell
        default:
            guard let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostViewCell", for: indexPath) as? PostViewCell else {
                return UICollectionViewCell()
            }
            postCell.configurateCell(post: viewModel.posts[indexPath.row], showLikeButton: false)
            return postCell
        }
    }
    // Register Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCell", for: indexPath) as? HeaderCell else {
            return UICollectionReusableView()
        }
        return header
    }
    
    //
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

//MARK: UICollectionViewDelegateFlowLayout
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: 330, height: 250)
        
        default:
            return CGSize(width: 360, height: 110)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: 0, height: 0)
        }
        return CGSize(width: UIScreen.main.bounds.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 1 {
            return 20
        }
        return 0
    }
}

//MARK: UICollectionViewDelegate
extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            present(CommetsViewController(post: viewModel.posts[indexPath.row]), animated: true)
        }
    }
}
