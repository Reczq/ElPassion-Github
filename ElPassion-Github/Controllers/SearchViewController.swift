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
    let resultDataSource: SearchDataSource
    let resultDelegate: SearchDelegate

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.getTextField()?.keyboardAppearance = .dark
        searchBar.textColor(color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))

        resultDataSource = SearchDataSource()
        resultDelegate = SearchDelegate()

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
        tableViewSetup()

        search(with: "Dev")
    }

    func tableViewSetup() {
        castedView().resultTableView.register(UITableViewCell.self, forCellReuseIdentifier: "defualtCell")
        castedView().resultTableView.dataSource = resultDataSource
        castedView().resultTableView.delegate = resultDelegate
    }

    func navigationBarSetup() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1879811585, green: 0.1879865527, blue: 0.1879836619, alpha: 1)
    }
}

// API
extension SearchViewController {

    func search(with q: String) {
        searchUser(with: q) { [weak self] (users) in
            guard let strongSelf = self else { return }

            strongSelf.searchRepo(with: q) { [weak self] (repos) in
                guard let strongSelf = self else { return }

                let items = SearchItems(repositories: repos, users: users)
                print(items)
                strongSelf.resultDataSource.updateItems(items: items)
                strongSelf.resultDelegate.updateItems(items: items)
                strongSelf.castedView().resultTableView.reloadData()
            }
        }
    }

    func searchUser(with q: String, completion: @escaping ([APIResultModelProtocol]) -> ()) {
        let userManager = APIManager().createUserManager()
        userManager.search(with: q) { (models) in

            let sortedModel = models.sorted(by: { Int($0.iden)! < Int($1.iden)! })

            completion(sortedModel)
        }
    }

    func searchRepo(with q: String, completion: @escaping ([APIResultModelProtocol]) -> ()) {
        let repoManager = APIManager().createRepositoryManager()
        repoManager.search(with: q) { (models) in

            let sortedModel = models.sorted(by: { Int($0.iden)! < Int($1.iden)! })

            completion(sortedModel)
        }
    }
}
