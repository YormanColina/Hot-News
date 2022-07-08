//
//  CommetsViewController.swift
//  Hot-News
//
//  Created by Apple on 8/07/22.
//

import UIKit

class CommetsViewController: UIViewController {
    
    init() {
        super.init(nibName: "CommetsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
    }

}
