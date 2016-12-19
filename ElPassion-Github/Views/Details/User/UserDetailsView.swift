import UIKit

struct UserDetailsBackgroundViewOffsets {
    static let leftOffset: CGFloat = 35
    static let rightOffset: CGFloat = 35
}

 struct UserDetailsItemsOffsets {
    static let topNameOffset: CGFloat = 10
    static let leftStarImageOffset: CGFloat = 25
    static let leftStatsOffset: CGFloat = 25
    static let rightIdIconOffset: CGFloat = -25
    static let rightIdNumberOffset: CGFloat = -25
    static let bottomIdNumberOffset: CGFloat = -15
    static let bottomStatsOffset: CGFloat = -15
 }

class UserDetailsView: UIView {

    var topBackground: UIView = {
        var topBackground = UIView()
        topBackground.backgroundColor = #colorLiteral(red: 0.1879811585, green: 0.1879865527, blue: 0.1879836619, alpha: 1)
        return topBackground
    }()

    var detailsBackground: UIView = {
        let detailsBackground = UIView()
        detailsBackground.layer.shadowColor = UIColor.darkGray.cgColor
        detailsBackground.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        detailsBackground.layer.shadowOpacity = 0.3
        detailsBackground.layer.cornerRadius = 10.0
        detailsBackground.backgroundColor = #colorLiteral(red: 0.2274459004, green: 0.2274520993, blue: 0.2274487615, alpha: 1)
        return detailsBackground
    }()

    let avatar: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    let name: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 19)
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        label.textColor = #colorLiteral(red: 0.3563290536, green: 0.7290251851, blue: 0.7285040617, alpha: 1)
        return label
    }()

    let idIcon: UIImageView = {
        var idIcon = UIImageView()
        idIcon = UIImageView(image: #imageLiteral(resourceName: "id"))
        return idIcon
    }()

    let idNumber: UILabel = {
        let idNumber = UILabel()
        idNumber.font = UIFont(name: "Roboto-Regular", size: 19)
        idNumber.numberOfLines = 0
        idNumber.lineBreakMode = .byClipping
        idNumber.textColor = #colorLiteral(red: 0.3563290536, green: 0.7290251851, blue: 0.7285040617, alpha: 1)
        return idNumber
    }()

    let starImage: UIView = {
        var starImage = UIImageView()
        starImage = UIImageView(image: #imageLiteral(resourceName: "blackstar"))
        return starImage
    }()

    let stats: UILabel = {
        let stats = UILabel()
        stats.font = UIFont(name: "Roboto-Regular", size: 19)
        stats.numberOfLines = 0
        stats.lineBreakMode = .byClipping
        stats.textColor = #colorLiteral(red: 0.3563290536, green: 0.7290251851, blue: 0.7285040617, alpha: 1)
        return stats
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareView()
        avatarAndNameAnimation()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func prepareView() {
        backgroundColor = #colorLiteral(red: 0.2595435381, green: 0.2595504522, blue: 0.2595467567, alpha: 1)
        addSubview(topBackground)
        addSubview(detailsBackground)
        addSubview(avatar)
        addSubview(name)
        addSubview(starImage)
        addSubview(stats)
        addSubview(idIcon)
        addSubview(idNumber)
        self.setNeedsUpdateConstraints()
    }


    func avatarAndNameAnimation() {
        avatar.alpha = 0
        name.alpha = 0
        UIView.animate(withDuration: 0.85, animations: {
            self.avatar.center.y = -200
            self.name.center.y = -200
            self.avatar.alpha = 1.0
            self.name.alpha = 1.0
        })
    }

    override func updateConstraints() {
        super.updateConstraints()

        let topBackgroundHeight: CGFloat = self.frame.size.height.multiplied(by: 0.5)
        let topDetailsOffsets: CGFloat = -(topBackgroundHeight.multiplied(by: 0.25))
        let topAvatarOffset = topBackgroundHeight.multiplied(by: 0.1)

        topBackground.snp.updateConstraints { (maker) in
            maker.top.equalTo(self)
            maker.left.right.equalTo(self)
            maker.height.equalTo(topBackgroundHeight)
        }

        detailsBackground.snp.updateConstraints { (maker) in
            maker.left.equalTo(self).offset(UserDetailsBackgroundViewOffsets.leftOffset)
            maker.right.equalTo(self).offset(-(UserDetailsBackgroundViewOffsets.rightOffset))

            maker.top.equalTo(topBackground.snp.bottom).offset(topDetailsOffsets)
            maker.height.equalTo(self.snp.height).multipliedBy(0.33)
        }

        avatar.snp.updateConstraints { (maker) in
            maker.centerX.equalTo(self)
            maker.top.equalTo(self).offset(topAvatarOffset)
            maker.size.equalTo(CGSize(width: 100, height: 100))
        }

        name.snp.updateConstraints { (maker) in
            maker.centerX.equalTo(self)
            maker.top.equalTo(avatar.snp.bottom).offset(UserDetailsItemsOffsets.topNameOffset)
        }

        starImage.snp.updateConstraints { (maker) in
            maker.centerY.equalTo(detailsBackground)
            maker.left.equalTo(detailsBackground).offset(UserDetailsItemsOffsets.leftStarImageOffset)
            maker.size.equalTo(CGSize(width: 50, height: 50))
        }

        stats.snp.updateConstraints { (maker) in
            maker.bottom.equalTo(starImage.snp.top).offset(UserDetailsItemsOffsets.bottomStatsOffset)
            maker.centerX.equalTo(starImage)
        }

        idIcon.snp.updateConstraints { (maker) in
            maker.centerY.equalTo(detailsBackground)
            maker.right.equalTo(detailsBackground).offset(UserDetailsItemsOffsets.rightIdIconOffset)
            maker.size.equalTo(CGSize(width: 50, height: 50))
        }

        idNumber.snp.updateConstraints { (maker) in
            maker.bottom.equalTo(idIcon.snp.top).offset(UserDetailsItemsOffsets.bottomIdNumberOffset)
            maker.centerX.equalTo(idIcon)
        }
    }
}
