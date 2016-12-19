import SwiftyJSON

struct APIRepositoryParser: APIResultParserProtocol {

    func parse(data: JSON) -> [APIResultModelProtocol] {
        var models = [RespositoryModel]()

        guard let items = data["items"].array else { return models }

        for item in items {
            let repositoryId = item["id"].stringValue
            let repositoryName = item["name"].stringValue
            let repositoryStars = item["score"].stringValue
            let repositoryLanguage = item["language"].stringValue
            let repositoryDescription = item["description"].stringValue
            let repositoryWatchersCounter = item["watchers_count"].stringValue
            let repositoryForksCounter = item["forks_count"].stringValue
            let repositoryOwnerAvatarURL = item["owner"]["avatar_url"].stringValue
            let model = RespositoryModel(name: repositoryName,
                                         iden: repositoryId,
                                         stars: repositoryStars,
                                         language: repositoryLanguage,
                                         description: repositoryDescription,
                                         watchersCounter: repositoryWatchersCounter,
                                         forksCounter: repositoryForksCounter,
                                         ownerAvatarURL: repositoryOwnerAvatarURL)
            models.append(model)
        }

        return models
    }
}
