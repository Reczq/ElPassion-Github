import UIKit

class RepositoryDetailsViewController: UIViewController {

    let repositoryModel: RespositoryModel

    init(with repository: RespositoryModel) {
        self.repositoryModel = repository

        super.init(nibName: nil, bundle: nil)
        self.edgesForExtendedLayout = []

        self.castedView().avatar.loadImageFromURL(repository.ownerAvatarURL) { [weak self] (image: UIImage) in
            guard let strongSelf = self else { return }

            strongSelf.castedView().avatar.image = image
            strongSelf.castedView().avatar.makeCircular()
        }
        castedView().name.text = repository.name
        castedView().repositoryDescription.text = repository.description
        castedView().stats.text = repository.stars.components(separatedBy: ".")[0]
        castedView().langauge.text = repository.language
        castedView().watchersCounter.text = repository.watchersCounter
        castedView().forksCounter.text = repository.forksCounter
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = RepositoryDetailsView()
    }

    func castedView() -> RepositoryDetailsView {
        return self.view as! RepositoryDetailsView
    }
}
