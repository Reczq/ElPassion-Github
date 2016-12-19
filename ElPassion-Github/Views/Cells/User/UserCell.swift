import UIKit

struct UserCellOffsets {
    static let leftOffset: CGFloat = 15
    static let rightOffset: CGFloat = 15
    static let betweenOffset: CGFloat = 5
}

struct UserMainViewOffsets {
    static let topOffset: CGFloat = 5
    static let bottomOffset: CGFloat = 5
    static let leftOffset: CGFloat = 5
    static let rightOffset: CGFloat = 5
}

class UserCell: UITableViewCell {

    let mainView: UIView = {
        let mainView = UIView()

        mainView.layer.masksToBounds = false
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
        mainView.layer.shadowOpacity = 0.2
        mainView.layer.cornerRadius = 20.0
        mainView.backgroundColor = #colorLiteral(red: 0.2696356177, green: 0.2742565274, blue: 0.2743487656, alpha: 1)
        return mainView
    }()

    let name: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 17)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textColor = #colorLiteral(red: 0.3563290536, green: 0.7290251851, blue: 0.7285040617, alpha: 1)
        return label
    }()

    let avatar: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    let starImage: UIView = {
        var starImage = UIImageView()
        starImage = UIImageView(image: #imageLiteral(resourceName: "blackstar"))
        return starImage
    }()

    let stats: UILabel = {
        let stats = UILabel()
        stats.font = UIFont(name: "Roboto-Regular", size: 17)
        stats.numberOfLines = 0
        stats.lineBreakMode = .byClipping
        stats.textColor = #colorLiteral(red: 0.3563290536, green: 0.7290251851, blue: 0.7285040617, alpha: 1)
        return stats
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.prepareView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func prepareView() {
        self.backgroundColor = #colorLiteral(red: 0.1879811585, green: 0.1879865527, blue: 0.1879836619, alpha: 1)
        self.selectionStyle = .none

        self.addSubview(mainView)
        mainView.addSubview(avatar)
        mainView.addSubview(name)
        mainView.addSubview(starImage)
        mainView.addSubview(stats)
        self.setNeedsUpdateConstraints()
    }

    override func updateConstraints() {
        super.updateConstraints()

        mainView.snp.updateConstraints { (maker) in
            maker.top.equalTo(self).offset(UserMainViewOffsets.topOffset)
            maker.left.equalTo(self).offset(UserMainViewOffsets.leftOffset)
            maker.right.equalTo(self).offset(-(UserMainViewOffsets.rightOffset))
            maker.bottom.equalTo(self).offset(-(UserMainViewOffsets.bottomOffset))
        }

        name.snp.updateConstraints { (maker) in
            maker.left.equalTo(mainView).offset(UserCellOffsets.leftOffset)
            maker.centerY.equalTo(mainView)
            maker.size.equalTo(CGSize(width: 100, height: 30))
        }

        avatar.snp.updateConstraints { (maker) in
            maker.centerX.equalTo(mainView)
            maker.centerY.equalTo(mainView)
            maker.size.equalTo(CGSize(width: 70, height: 70))
        }

        stats.snp.updateConstraints { (maker) in
            maker.right.equalTo(starImage.snp.left).offset(-(UserCellOffsets.betweenOffset))
            maker.centerY.equalTo(mainView)
        }

        starImage.snp.updateConstraints { (maker) in
            maker.right.equalTo(mainView).offset(-(UserCellOffsets.rightOffset))
            maker.centerY.equalTo(mainView)
            maker.size.equalTo(CGSize(width: 25, height: 25))
        }
    }
}
