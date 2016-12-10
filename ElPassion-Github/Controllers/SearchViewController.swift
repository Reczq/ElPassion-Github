//
//  SearchViewController.swift
//  ElPassion-Github
//
//  Created by Dominik Reczek on 10/12/16.
//  Copyright © 2016 Dominik Reczek. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    let searchBar: UISearchBar

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.getTextField()?.keyboardAppearance = .dark
        searchBar.textColor(color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        navigationItem.titleView = searchBar
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = SearchView()
    }

    func castedView() -> SearchView {
        return view as! SearchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarSetup()

        testo()
    }

    func testo() {
        let userManager = APIManager().createUserManager()
        userManager.search(with: "mojombo") { (models) in
            print(models)
        }

        let repoManager = APIManager().createRepositoryManager()
        repoManager.search(with: "swift") { (models) in
            print(models)
        }
    }

    func navigationBarSetup() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1879811585, green: 0.1879865527, blue: 0.1879836619, alpha: 1)
    }
}
