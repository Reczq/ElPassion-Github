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

protocol APIManagerProtocol {
    var baseURL: String { get }
    var path: String { get }
    var parser: APIResultParser { get }

    init(with baseURL: String, parser: APIResultParser)
    func search(with queryString: String, completion: @escaping ([APIResultModel]) -> ())
}

extension APIManagerProtocol {
    func search(with queryString: String, completion: @escaping ([APIResultModel]) -> ()) {
        let fullPath = baseURL + path
        let params = ["q" : queryString]

        Alamofire.request(fullPath, parameters: params).responseData { response in
            if let responseData =  response.result.value {
                let jsonData = JSON(data: responseData)
                let result = self.parser.parse(data: jsonData)
                completion(result)
            }
        }
    }
}

////////////////////////////
protocol APIResultModel {
    var name: String { get }
    var iden: String { get }
}

struct UserModel: APIResultModel {
    var name: String
    var iden: String
}

struct RespositoryModel: APIResultModel {
    var name: String
    var iden: String
}
////////////////////////////
protocol APIResultParser {
    func parse(data: JSON) -> [APIResultModel]
}

struct APIUserParser: APIResultParser {

    func parse(data: JSON) -> [APIResultModel] {
        var models = [UserModel]()

        guard let items = data["items"].array else { return models }

        for item in items {
            let userId = item["id"].stringValue
            let userName = item["login"].stringValue
            let model = UserModel(name: userName, iden: userId)
            models.append(model)
        }

        return models
    }
}

struct APIRepositoryParser: APIResultParser {

    func parse(data: JSON) -> [APIResultModel] {
        var models = [RespositoryModel]()

        guard let items = data["items"].array else { return models }

        for item in items {
            let userId = item["id"].stringValue
            let userName = item["name"].stringValue
            let model = RespositoryModel(name: userName, iden: userId)
            models.append(model)
        }

        return models
    }
}
////////////////////////////
class APIUserManager: APIManagerProtocol {

    let baseURL: String
    let path: String
    let parser: APIResultParser

    required init(with baseURL: String, parser: APIResultParser) {
        self.baseURL = baseURL
        self.parser = parser
        self.path = "/search/users"
    }
}

class APIRepositoryManager: APIManagerProtocol {

    let baseURL: String
    let path: String
    let parser: APIResultParser

    required init(with baseURL: String, parser: APIResultParser) {
        self.baseURL = baseURL
        self.parser = parser
        self.path = "/search/repositories"
    }
}
