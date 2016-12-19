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
                cell.name.text = user.name
                cell.avatar.loadImageFromURL(user.avatarURL) { (image: UIImage) -> Void in
                    cell.avatar.image = image
                    cell.avatar.makeCircular()
                }
                cell.stats.text = user.stars.components(separatedBy: ".")[0]
            }

            return cell
        case .repositories:
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchIdentifiers.repoCell, for: indexPath) as! RepoCell

            if let repo = items.repositories[indexPath.row] as? RespositoryModel {
                cell.name.text = repo.name
                cell.avatar.loadImageFromURL(repo.ownerAvatarURL) { (image: UIImage) -> Void in
                    cell.avatar.image = image
                    cell.avatar.makeCircular()
                }
                cell.watchersCounter.text = repo.watchersCounter
                cell.forksCounter.text = repo.forksCounter
            }

            return cell
        }
    }
}
