import UIKit

struct RepoCellOffsets {
    static let topOffset: CGFloat = 10
    static let bottomOffset: CGFloat = 10
    static let leftOffset: CGFloat = 15
    static let rightOffset: CGFloat = 15
    static let betweenOffset: CGFloat = 5
}

struct RepoMainViewOffsets {
    static let topOffset: CGFloat = 5
    static let bottomOffset: CGFloat = 5
    static let leftOffset: CGFloat = 5
    static let rightOffset: CGFloat = 5
}

class RepoCell: UITableViewCell {

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
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textColor = #colorLiteral(red: 0.1353544295, green: 0.7183163762, blue: 0.2491897941, alpha: 1)
        return label
    }()

    let avatar: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    let watchersCounter: UILabel = {
        let watchersCounter = UILabel()
        watchersCounter.font = UIFont(name: "Roboto-Regular", size: 17)
        watchersCounter.numberOfLines = 0
        watchersCounter.lineBreakMode = .byClipping
        watchersCounter.textColor = #colorLiteral(red: 0.1353544295, green: 0.7183163762, blue: 0.2491897941, alpha: 1)
        return watchersCounter
    }()

    let forksCounter: UILabel = {
        let forksCounter = UILabel()
        forksCounter.font = UIFont(name: "Roboto-Regular", size: 17)
        forksCounter.numberOfLines = 0
        forksCounter.lineBreakMode = .byClipping
        forksCounter.textColor = #colorLiteral(red: 0.1353544295, green: 0.7183163762, blue: 0.2491897941, alpha: 1)
        return forksCounter
    }()

    let watchersImage: UIView = {
        var watchersImage = UIImageView()
        watchersImage = UIImageView(image: #imageLiteral(resourceName: "watchers"))
        return watchersImage
    }()

    let forksImage: UIView = {
        var forksImage = UIImageView()
        forksImage = UIImageView(image: #imageLiteral(resourceName: "forks"))
        return forksImage
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
        mainView.addSubview(name)
        mainView.addSubview(avatar)
        mainView.addSubview(watchersCounter)
        mainView.addSubview(forksCounter)
        mainView.addSubview(watchersImage)
        mainView.addSubview(forksImage)

        self.setNeedsUpdateConstraints()
    }

    override func updateConstraints() {
        super.updateConstraints()

        mainView.snp.updateConstraints { (maker) in
            maker.top.equalTo(self).offset(RepoMainViewOffsets.topOffset)
            maker.left.equalTo(self).offset(RepoMainViewOffsets.leftOffset)
            maker.right.equalTo(self).offset(-(RepoMainViewOffsets.rightOffset))
            maker.bottom.equalTo(self).offset(-(RepoMainViewOffsets.bottomOffset))
        }

        name.snp.updateConstraints { (maker) in
            maker.left.equalTo(mainView).offset(RepoCellOffsets.leftOffset)
            maker.centerY.equalTo(mainView)
            maker.size.equalTo(CGSize(width: 100, height: 30))
        }

        avatar.snp.updateConstraints { (maker) in
            maker.centerX.equalTo(mainView)
            maker.centerY.equalTo(mainView)
            maker.size.equalTo(CGSize(width: 70, height: 70))
        }

        watchersCounter.snp.updateConstraints { (maker) in
            maker.centerY.equalTo(watchersImage)
            maker.right.equalTo(watchersImage.snp.left).offset(-(RepoCellOffsets.betweenOffset))
        }
        forksCounter.snp.updateConstraints { (maker) in
            maker.centerY.equalTo(forksImage)
            maker.right.equalTo(forksImage.snp.left).offset(-(RepoCellOffsets.betweenOffset))
        }

        watchersImage.snp.updateConstraints { (maker) in
            maker.top.equalTo(mainView).offset(RepoCellOffsets.topOffset)
            maker.right.equalTo(mainView).offset(-(RepoCellOffsets.rightOffset))
            maker.size.equalTo(CGSize(width: 30, height: 30))
        }

        forksImage.snp.updateConstraints { (maker) in
            maker.bottom.equalTo(mainView).offset(-(RepoCellOffsets.bottomOffset))
            maker.right.equalTo(mainView).offset(-(RepoCellOffsets.rightOffset))
            maker.size.equalTo(CGSize(width: 30, height: 30))
        }
    }
}
