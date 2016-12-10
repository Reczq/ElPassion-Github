//
//  APIManager.swift
//  ElPassion-Github
//
//  Created by Dominik Reczek on 10/12/16.
//  Copyright © 2016 Dominik Reczek. All rights reserved.
//

import UIKit

class APIManager {

    let baseURL: String

    init() {
        baseURL = "https://api.github.com/"
    }

    func createUserManager() -> APIManagerProtocol {
        return APIUserManager(with: baseURL)
    }

    func createRepositoryManager() -> APIManagerProtocol {
        return APIRepositoryManager(with: baseURL)
    }
}

protocol APIManagerProtocol {
    var baseURL: String { get }

    init(with baseURL: String)
    func search(with queryString: String)
}

class APIUserManager: APIManagerProtocol {

    let baseURL: String

    required init(with baseURL: String) {
        self.baseURL = baseURL
    }

    func search(with queryString: String) {

    }
}

class APIRepositoryManager: APIManagerProtocol {

    let baseURL: String

    required init(with baseURL: String) {
        self.baseURL = baseURL
    }

    func search(with queryString: String) {

    }
}
