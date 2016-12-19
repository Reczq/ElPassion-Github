import SwiftyJSON

struct APIUserParser: APIResultParserProtocol {

    func parse(data: JSON) -> [APIResultModelProtocol] {
        var models = [UserModel]()

        guard let items = data["items"].array else { return models }

        for item in items {
            let userId = item["id"].stringValue
            let userName = item["login"].stringValue
            let userStars = item["score"].stringValue
            let userAvatarURL = item["avatar_url"].stringValue
            let model = UserModel(name: userName,
                                  iden: userId,
                                  stars: userStars,
                                  avatarURL: userAvatarURL)
            models.append(model)
        }

        return models
    }
}
