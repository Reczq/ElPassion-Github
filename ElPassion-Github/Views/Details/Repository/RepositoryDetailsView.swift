 import UIKit

 struct RepositoryDetailsBackgroundViewOffsets {
    static let leftOffset: CGFloat = 30
    static let rightOffset: CGFloat = 30
 }

 struct RepositoryDetailsItemsOffsets {
    static let topNameOffset: CGFloat = 10
    static let topAvatarOffset: CGFloat = 10
    static let leftRepositoryDescription: CGFloat = 10
    static let rightRepositoryDescription: CGFloat = -10
    static let topRepositoryDescription: CGFloat = 10
    static let bottomRepositoryDescription: CGFloat = -10

    static let betweenDetailsOffset: CGFloat = 10
    static let topDetailsOffset: CGFloat = 20
    static let leftDetailsOffset: CGFloat = 20
    static let rightDetailsOffset: CGFloat = -20
    static let bottomDetailsOffset: CGFloat = -25
 }

 class RepositoryDetailsView: UIView {

    var topBackground: UIView = {
        var topBackground = UIView()
        topBackground.backgroundColor = #colorLiteral(red: 0.1879811585, green: 0.1879865527, blue: 0.1879836619, alpha: 1)
        return topBackground
    }()

    var detailsBackground: UIView = {
        let detailsBackground = UIView()
        detailsBackground.layer.borderWidth = 1.0
        detailsBackground.layer.borderColor = UIColor.white.cgColor
        detailsBackground.layer.cornerRadius = 10.0
        detailsBackground.backgroundColor = #colorLiteral(red: 0.2274459004, green: 0.2274520993, blue: 0.2274487615, alpha: 1)
        return detailsBackground
    }()

    var bottomBackground: UIView = {
        let bottomBackground = UIView()

        bottomBackground.layer.shadowColor = UIColor.darkGray.cgColor
        bottomBackground.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        bottomBackground.layer.shadowOpacity = 0.3

        bottomBackground.backgroundColor = #colorLiteral(red: 0.244104743, green: 0.197486341, blue: 0.1611926854, alpha: 1)
        return bottomBackground
    }()

    let avatar: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    let name: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        label.textColor = #colorLiteral(red: 0.1353544295, green: 0.7183163762, blue: 0.2491897941, alpha: 1)
        return label
    }()

    let repositoryDescription: UILabel = {
        let repositoryDescription = UILabel()
        repositoryDescription.font = UIFont(name: "Roboto-Regular", size: 13)
        repositoryDescription.numberOfLines = 0
        repositoryDescription.lineBreakMode = .byWordWrapping
        repositoryDescription.textColor = #colorLiteral(red: 0.1353544295, green: 0.7183163762, blue: 0.2491897941, alpha: 1)
        repositoryDescription.textAlignment = .center
        return repositoryDescription
    }()

    let starImage: UIView = {
        var starImage = UIImageView()
        starImage = UIImageView(image: #imageLiteral(resourceName: "blackstar"))
        return starImage
    }()

    let stats: UILabel = {
        let stats = UILabel()
        stats.font = UIFont(name: "Roboto-Regular", size: 16)
        stats.numberOfLines = 0
        stats.lineBreakMode = .byClipping
        stats.textColor = #colorLiteral(red: 0.1353544295, green: 0.7183163762, blue: 0.2491897941, alpha: 1)
        return stats
    }()

    let languageImage: UIView = {
        var languageImage = UIImageView()
        languageImage = UIImageView(image: #imageLiteral(resourceName: "language"))
        return languageImage
    }()

    let langauge: UILabel = {
        let langauge = UILabel()
        langauge.font = UIFont(name: "Roboto-Regular", size: 15)
        langauge.numberOfLines = 0
        langauge.lineBreakMode = .byClipping
        langauge.textColor = #colorLiteral(red: 0.1353544295, green: 0.7183163762, blue: 0.2491897941, alpha: 1)
        return langauge
    }()

    let watchersImage: UIView = {
        var watchersImage = UIImageView()
        watchersImage = UIImageView(image: #imageLiteral(resourceName: "watchers"))
        return watchersImage
    }()

    let watchersCounter: UILabel = {
        let watchersCounter = UILabel()
        watchersCounter.font = UIFont(name: "Roboto-Regular", size: 16)
        watchersCounter.numberOfLines = 0
        watchersCounter.lineBreakMode = .byClipping
        watchersCounter.textColor = #colorLiteral(red: 0.1353544295, green: 0.7183163762, blue: 0.2491897941, alpha: 1)
        return watchersCounter
    }()

    let forksImage: UIView = {
        var forksImage = UIImageView()
        forksImage = UIImageView(image: #imageLiteral(resourceName: "forks"))
        return forksImage
    }()

    let forksCounter: UILabel = {
        let forksCounter = UILabel()
        forksCounter.font = UIFont(name: "Roboto-Regular", size: 16)
        forksCounter.numberOfLines = 0
        forksCounter.lineBreakMode = .byClipping
        forksCounter.textColor = #colorLiteral(red: 0.1353544295, green: 0.7183163762, blue: 0.2491897941, alpha: 1)
        return forksCounter
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
        backgroundColor = #colorLiteral(red: 0.5158632398, green: 0.5158758759, blue: 0.515869081, alpha: 1)
        addSubview(topBackground)
        addSubview(detailsBackground)
        addSubview(bottomBackground)
        addSubview(avatar)
        addSubview(name)
        addSubview(repositoryDescription)

        addSubview(starImage)
        addSubview(stats)
        addSubview(languageImage)
        addSubview(langauge)
        addSubview(watchersImage)
        addSubview(watchersCounter)
        addSubview(forksImage)
        addSubview(forksCounter)
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
        let bottomBackgroundHeight: CGFloat = self.frame.size.height.multiplied(by: 0.2)
        let topDetailsOffsets: CGFloat = -(topBackgroundHeight.multiplied(by: 0.2))
        let topAvatarOffset = topBackgroundHeight.multiplied(by: 0.1)
        let detailsBackgroundHeight = self.frame.size.height.multiplied(by: 0.25)

        topBackground.snp.updateConstraints { (maker) in
            maker.top.equalTo(self)
            maker.left.right.equalTo(self)
            maker.height.equalTo(topBackgroundHeight)
        }

        detailsBackground.snp.updateConstraints { (maker) in
            maker.left.equalTo(self).offset(RepositoryDetailsBackgroundViewOffsets.leftOffset)
            maker.right.equalTo(self).offset(-(RepositoryDetailsBackgroundViewOffsets.rightOffset))

            maker.top.equalTo(topBackground.snp.bottom).offset(topDetailsOffsets)
            maker.height.equalTo(detailsBackgroundHeight)
        }

        bottomBackground.snp.updateConstraints { (maker) in
            maker.bottom.equalTo(self)
            maker.left.right.equalTo(self)
            maker.height.equalTo(bottomBackgroundHeight)
        }

        avatar.snp.updateConstraints { (maker) in
            maker.centerX.equalTo(self)
            maker.top.equalTo(self).offset(topAvatarOffset)
            maker.size.equalTo(CGSize(width: 100, height: 100))
        }

        name.snp.updateConstraints { (maker) in
            maker.centerX.equalTo(self)
            maker.top.equalTo(avatar.snp.bottom).offset(RepositoryDetailsItemsOffsets.topNameOffset)
        }

        repositoryDescription.snp.updateConstraints { (maker) in
            maker.top.equalTo(bottomBackground).offset(RepositoryDetailsItemsOffsets.leftRepositoryDescription)
            maker.bottom.equalTo(bottomBackground).offset(RepositoryDetailsItemsOffsets.rightRepositoryDescription)
            maker.left.equalTo(bottomBackground).offset(RepositoryDetailsItemsOffsets.leftRepositoryDescription)
            maker.right.equalTo(bottomBackground).offset(RepositoryDetailsItemsOffsets.rightRepositoryDescription)
        }

        starImage.snp.updateConstraints { (maker) in
            maker.left.equalTo(detailsBackground).offset(RepositoryDetailsItemsOffsets.leftDetailsOffset)
            maker.top.equalTo(detailsBackground).offset(RepositoryDetailsItemsOffsets.topDetailsOffset)
            maker.size.equalTo(CGSize(width: 40, height: 40))
        }

        stats.snp.updateConstraints { (maker) in
            maker.top.equalTo(starImage.snp.bottom).offset(RepositoryDetailsItemsOffsets.topDetailsOffset)
            maker.bottom.equalTo(detailsBackground).offset(RepositoryDetailsItemsOffsets.bottomDetailsOffset)
            maker.centerX.equalTo(starImage)
        }

        languageImage.snp.updateConstraints { (maker) in
            maker.left.equalTo(starImage.snp.right).offset(RepositoryDetailsItemsOffsets.leftDetailsOffset)
            maker.top.equalTo(detailsBackground).offset(RepositoryDetailsItemsOffsets.topDetailsOffset)
            maker.size.equalTo(CGSize(width: 40, height: 40))
        }

        langauge.snp.updateConstraints { (maker) in
            maker.bottom.equalTo(detailsBackground).offset(RepositoryDetailsItemsOffsets.bottomDetailsOffset)
            maker.top.equalTo(languageImage.snp.bottom).offset(RepositoryDetailsItemsOffsets.topDetailsOffset)
            maker.centerX.equalTo(languageImage)
            maker.size.width.equalTo(42)
        }

        watchersImage.snp.updateConstraints { (maker) in
            maker.right.equalTo(forksImage.snp.left).offset(RepositoryDetailsItemsOffsets.rightDetailsOffset)
            maker.top.equalTo(detailsBackground).offset(RepositoryDetailsItemsOffsets.topDetailsOffset)
            maker.size.equalTo(CGSize(width: 40, height: 40))
        }

        watchersCounter.snp.updateConstraints { (maker) in
            maker.centerX.equalTo(watchersImage)
            maker.top.equalTo(watchersImage.snp.bottom).offset(RepositoryDetailsItemsOffsets.topDetailsOffset)
            maker.bottom.equalTo(detailsBackground).offset(RepositoryDetailsItemsOffsets.bottomDetailsOffset)
        }

        forksImage.snp.updateConstraints { (maker) in
            maker.right.equalTo(detailsBackground).offset(RepositoryDetailsItemsOffsets.rightDetailsOffset)
            maker.top.equalTo(detailsBackground).offset(RepositoryDetailsItemsOffsets.topDetailsOffset)
            maker.size.equalTo(CGSize(width: 40, height: 40))
        }

        forksCounter.snp.updateConstraints { (maker) in
            maker.centerX.equalTo(forksImage)
            maker.top.equalTo(forksImage.snp.bottom).offset(RepositoryDetailsItemsOffsets.topDetailsOffset)
            maker.bottom.equalTo(detailsBackground).offset(RepositoryDetailsItemsOffsets.bottomDetailsOffset)
        }
    }
 }
