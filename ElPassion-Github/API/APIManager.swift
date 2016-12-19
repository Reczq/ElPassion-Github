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
