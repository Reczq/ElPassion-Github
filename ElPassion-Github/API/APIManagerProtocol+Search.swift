import Alamofire
import SwiftyJSON

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
