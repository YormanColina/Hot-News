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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.callService()
            .subscribe { posts in
                self.collectionView.reloadData()
            }.disposed(by: disposeBag)
        setupUI()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PostViewCell", bundle: nil), forCellWithReuseIdentifier: "PostViewCell")
        collectionView.register(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    
    // MARK: Methods
    func setupUI() {
        collectionView.contentInset = UIEdgeInsets(top: 70, left: 0, bottom: 0, right: 0)
        profileImage.layer.cornerRadius = profileImage.bounds.height / 2
    }
    
    // MARK: IBActions
    
    @IBAction func openProfileView(_ sender: Any) {
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
}


extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostViewCell", for: indexPath) as? PostViewCell else{
            return UICollectionViewCell()
        }
        cell.configurateCell(post: viewModel.posts[indexPath.row])
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView  else { return  UICollectionReusableView() }
            
        return header
        
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360, height: 110)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        present(CommetsViewController(post: viewModel.posts[indexPath.row]), animated: true)
    }
}

