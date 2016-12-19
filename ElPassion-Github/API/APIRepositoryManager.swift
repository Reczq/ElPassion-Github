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
