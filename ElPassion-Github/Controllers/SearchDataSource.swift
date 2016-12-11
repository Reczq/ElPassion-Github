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
        return UITableViewCell()
    }
}
//////////
class SearchDelegate: NSObject, UITableViewDelegate {

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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


    }
}
