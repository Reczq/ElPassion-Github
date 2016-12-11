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
    let userManager: APIManagerProtocol
    let repoManager: APIManagerProtocol

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.getTextField()?.keyboardAppearance = .dark
        searchBar.textColor(color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))

        resultDataSource = SearchDataSource()
        resultDelegate = SearchDelegate()

        let apiManager = APIManager()
        userManager = apiManager.createUserManager()
        repoManager = apiManager.createRepositoryManager()

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        searchBar.delegate = self
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
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        searchBar.endEditing(true)
    }

    func tableViewSetup() {
        castedView().resultTableView.register(UserCell.self, forCellReuseIdentifier: SearchIdentifiers.userCell)
        castedView().resultTableView.register(RepoCell.self, forCellReuseIdentifier: SearchIdentifiers.repoCell)

        castedView().resultTableView.dataSource = resultDataSource
        castedView().resultTableView.delegate = resultDelegate

        resultDelegate.didSelectUser = { [weak self] user in
            guard let strongSelf = self else { return }

            let userViewController = UserDetailsViewController(with: user)
            strongSelf.navigationController?.pushViewController(userViewController, animated: true)
        }

        resultDelegate.didSelectRepo = { [weak self] repo in
            guard let strongSelf = self else { return }

            let repositoryViewController = RepositoryDetailsViewController(with: repo)
            strongSelf.navigationController?.pushViewController(repositoryViewController, animated: true)
        }
    }

    func navigationBarSetup() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1879811585, green: 0.1879865527, blue: 0.1879836619, alpha: 1)
    }
}

// SearchBar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        print(searchText)
        search(with: searchText)
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

        userManager.search(with: q) { (models) in
            let sortedModel = models.sorted(by: { Int($0.iden)! < Int($1.iden)! })

            completion(sortedModel)
        }
    }

    func searchRepo(with q: String, completion: @escaping ([APIResultModelProtocol]) -> ()) {

        repoManager.search(with: q) { (models) in
            let sortedModel = models.sorted(by: { Int($0.iden)! < Int($1.iden)! })

            completion(sortedModel)
        }
    }
}
