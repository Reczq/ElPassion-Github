//
//  RepositoryDetailsViewController.swift
//  ElPassion-Github
//
//  Created by Dominik Reczek on 11/12/16.
//  Copyright © 2016 Dominik Reczek. All rights reserved.
//

import UIKit

class RepositoryDetailsViewController: UIViewController {

    let repositoryModel: RespositoryModel

    init(with repository: RespositoryModel) {
        self.repositoryModel = repository

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = RepositoryDetailsView()
    }

}
