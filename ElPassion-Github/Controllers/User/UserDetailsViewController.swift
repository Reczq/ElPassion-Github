import UIKit

class UserDetailsViewController: UIViewController {

    let userModel: UserModel

    init(with user: UserModel) {
        self.userModel = user

        super.init(nibName: nil, bundle: nil)
        self.edgesForExtendedLayout = []

        self.castedView().avatar.loadImageFromURL(user.avatarURL) { [weak self] (image: UIImage) in
            guard let strongSelf = self else { return }

            strongSelf.castedView().avatar.image = image
            strongSelf.castedView().avatar.makeCircular()
        }
        castedView().name.text = user.name
        castedView().stats.text = user.stars.components(separatedBy: ".")[0]
        castedView().idNumber.text = user.iden
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = UserDetailsView()
    }

    func castedView() -> UserDetailsView {
        return self.view as! UserDetailsView
    }
}


