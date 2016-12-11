//
//  UserDetailsViewController.swift
//  ElPassion-Github
//
//  Created by Dominik Reczek on 11/12/16.
//  Copyright © 2016 Dominik Reczek. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {

    let userModel: UserModel

    init(with user: UserModel) {
        self.userModel = user

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = UserDetailsView()
    }

    func castedView() -> UserDetailsView {
        return self.view as! UserDetailsView
    }
}
