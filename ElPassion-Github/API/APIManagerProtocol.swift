import SwiftyJSON

protocol APIManagerProtocol {
    var baseURL: String { get }
    var path: String { get }
    var parser: APIResultParserProtocol { get }

    init(with baseURL: String, parser: APIResultParserProtocol)
    func search(with queryString: String, completion: @escaping ([APIResultModelProtocol]) -> ())
}
