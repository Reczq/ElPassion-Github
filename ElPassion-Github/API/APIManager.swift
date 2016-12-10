//
//  APIManager.swift
//  ElPassion-Github
//
//  Created by Dominik Reczek on 10/12/16.
//  Copyright © 2016 Dominik Reczek. All rights reserved.
//

import UIKit
import Alamofire

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
    func search(with queryString: String, completion: ([APIResultModel]) -> ())
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

struct ModelRespository: APIResultModel {
    var name: String
    var iden: String
}
////////////////////////////
protocol APIResultParser {
    func parse(data: DataRequest) -> [APIResultModel]
}

struct APIUserParser: APIResultParser {
    func parse(data: DataRequest) -> [APIResultModel] {
        return []
    }
}

struct APIRepositoryParser: APIResultParser {
    func parse(data: DataRequest) -> [APIResultModel] {
        return []
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

    func search(with queryString: String, completion: ([APIResultModel]) -> ()) {
//        Alamofire.request("https://httpbin.org/get", parameters: [:]).responseJSON { response in
//
//        }
    }
}

class APIRepositoryManager: APIManagerProtocol {

    let baseURL: String
    let path: String
    let parser: APIResultParser

    required init(with baseURL: String, parser: APIResultParser) {
        self.baseURL = baseURL
        self.parser = parser
        self.path = "/search/repos"
    }

    func search(with queryString: String, completion: ([APIResultModel]) -> ()) {

    }
}
