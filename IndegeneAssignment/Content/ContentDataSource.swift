import Foundation

enum JSONParserError: Error {
    case jsonError(message: String)
}

protocol ContentDataSource {
    func loadContent() throws -> [Content]
}

class IndengeContentDataSource: ContentDataSource {
    let repository: ContentRepository
    
    init(repository: ContentRepository = IndgeneContentRepository()) {
        self.repository = repository
    }
    
    func loadContent() throws -> [Content] {
        let jsonContent = try repository.loadJSON(name: "content")
        guard let contents = jsonContent["content"] as? [Json] else {
            throw JSONParserError.jsonError(message: "Key for content might have changed")
        }
        return contents.map({ dict -> Content? in do { return try Content(json: dict) } catch { return nil }}).flatMap { $0 }
    }
}
