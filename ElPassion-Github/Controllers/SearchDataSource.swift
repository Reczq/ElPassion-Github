//
//  SearchDataSource.swift
//  ElPassion-Github
//
//  Created by Dominik Reczek on 11/12/16.
//  Copyright © 2016 Dominik Reczek. All rights reserved.
//

import UIKit

enum SearchSections: Int {
    case users
    case repositories

    static func count() -> Int {
        return 2
    }
}

struct SearchItems {
    var repositories = [APIResultModelProtocol]()
    var users = [APIResultModelProtocol]()
}

struct SearchIdentifiers {
    static let userCell = "UserCell"
    static let repoCell = "RepoCell"
}

struct SearchSizes {
    static let headerHeight: CGFloat = 40
    static let headerLabelHeight: CGFloat = 20
    static let footerHeight: CGFloat = 0
}

class SearchDataSource: NSObject, UITableViewDataSource {

    var items: SearchItems

    convenience override init() {
        self.init(with: SearchItems())
    }

    init(with items: SearchItems) {
        self.items = items

        super.init()
    }

    func updateItems(items: SearchItems) {
        self.items = items
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return SearchSections.count()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let section = SearchSections(rawValue: section) else { return 0 }

        switch section {
        case .users:
            return items.users.count
        case .repositories:
            return items.repositories.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let section = SearchSections(rawValue: indexPath.section) else {
            return UITableViewCell()
        }

        switch section {
        case .users:
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchIdentifiers.userCell, for: indexPath) as! UserCell

            if let user = items.users[indexPath.row] as? UserModel {
                cell.textLabel?.text = user.name
            }

            return cell
        case .repositories:
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchIdentifiers.repoCell, for: indexPath) as! RepoCell

            if let repo = items.repositories[indexPath.row] as? RespositoryModel {
                cell.textLabel?.text = repo.name
            }

            return cell
        }
    }
}
//////////
class SearchDelegate: NSObject, UITableViewDelegate {

    var items: SearchItems
    var didSelectUser: ((UserModel) -> ())?
    var didSelectRepo: ((RespositoryModel) -> ())?

    convenience override init() {
        self.init(with: SearchItems())
    }

    init(with items: SearchItems) {
        self.items = items

        super.init()
    }

    func updateItems(items: SearchItems) {
        self.items = items
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let section = SearchSections(rawValue: indexPath.section) else { return }

        switch section {
        case .users:
            if let user = items.users[indexPath.row] as? UserModel,
                let didSelectUser = didSelectUser {
                didSelectUser(user)
            }
        case .repositories:
            if let repo = items.repositories[indexPath.row] as? RespositoryModel,
                let didSelectRepo = didSelectRepo {
                didSelectRepo(repo)
            }
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerFrame = CGRect(x: 0,
                                 y: 0,
                                 width: tableView.frame.width,
                                 height: SearchSizes.headerLabelHeight)
        let label = UILabel(frame: headerFrame)
        label.textColor = #colorLiteral(red: 0, green: 0.8358530402, blue: 0.3524739146, alpha: 1)

        guard let section = SearchSections(rawValue: section) else { return UIView() }

        switch section {
        case .users:
            label.text = "  Users"
        case .repositories:
            label.text = "  Repositories"
        }

        return label
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SearchSizes.headerHeight
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return SearchSizes.footerHeight
    }
}
