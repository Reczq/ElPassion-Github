//
//  APIManager.swift
//  ElPassion-Github
//
//  Created by Dominik Reczek on 10/12/16.
//  Copyright © 2016 Dominik Reczek. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class APIManager {

    let baseURL: String

    init() {
        baseURL = "https://api.github.com"
    }

    func createUserManager() -> APIManagerProtocol {
        let parser = APIUserParser()
        return APIUserManager(with: baseURL, parser: parser)
    }

    func createRepositoryManager() -> APIManagerProtocol {
        let parser = APIRepositoryParser()
        return APIRepositoryManager(with: baseURL, parser: parser)
    }
}
//////////////////////////////
protocol APIManagerProtocol {
    var baseURL: String { get }
    var path: String { get }
    var parser: APIResultParserProtocol { get }

    init(with baseURL: String, parser: APIResultParserProtocol)
    func search(with queryString: String, completion: @escaping ([APIResultModelProtocol]) -> ())
}

extension APIManagerProtocol {

    func search(with queryString: String, completion: @escaping ([APIResultModelProtocol]) -> ()) {
        let fullPath = baseURL + path
        let params = ["q" : queryString]

        Alamofire.request(fullPath, parameters: params).responseData { response in
            if let responseData =  response.result.value {
                let jsonData = JSON(data: responseData)
                let result = self.parser.parse(data: jsonData)
                print(jsonData)
                completion(result)
            }
        }
    }
}

////////////////////////////
// Models
protocol APIResultModelProtocol {
    var name: String { get }
    var iden: String { get }
}
////////////////////////////
// Models
struct UserModel: APIResultModelProtocol {
    var name: String
    var iden: String
    var stars: String
    var avatarURL: String
}
////////////////////////////
// Models
struct RespositoryModel: APIResultModelProtocol {
    var name: String
    var iden: String
    var stars: String
    var language: String
    var description: String
    var watchersCounter: String
    var forksCounter: String
    var ownerAvatarURL: String
}
////////////////////////////
protocol APIResultParserProtocol {
    func parse(data: JSON) -> [APIResultModelProtocol]
}
////////////////////////////
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
////////////////////////////

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
////////////////////////////
class APIUserManager: APIManagerProtocol {

    let baseURL: String
    let path: String
    let parser: APIResultParserProtocol

    required init(with baseURL: String, parser: APIResultParserProtocol) {
        self.baseURL = baseURL
        self.parser = parser
        self.path = "/search/users"
    }
}
////////////////////////////

class APIRepositoryManager: APIManagerProtocol {

    let baseURL: String
    let path: String
    let parser: APIResultParserProtocol

    required init(with baseURL: String, parser: APIResultParserProtocol) {
        self.baseURL = baseURL
        self.parser = parser
        self.path = "/search/repositories"
    }
}
