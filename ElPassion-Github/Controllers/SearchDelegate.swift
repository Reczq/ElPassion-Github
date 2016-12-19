import UIKit

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

        guard let section = SearchSections(rawValue: section) else { return UIView() }

        switch section {
        case .users:
            label.text = "Users"
            label.textAlignment = .center
            label.textColor = #colorLiteral(red: 0.1418412328, green: 0.9105157852, blue: 1, alpha: 1)
        case .repositories:
            label.text = "Repositories"
            label.textAlignment = .center
            label.textColor = #colorLiteral(red: 0, green: 0.8358530402, blue: 0.3524739146, alpha: 1)
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
