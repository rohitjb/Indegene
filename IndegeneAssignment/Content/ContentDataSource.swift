import Foundation

protocol ContentDataSource {
    func loadContent() throws -> Content
}

class IndengeContentDataSource: ContentDataSource {
    let repository: ContentRepository
    
    init(repository: ContentRepository = IndgeneContentRepository()) {
        self.repository = repository
    }
    
    func loadContent() throws -> Content {
        let json = try repository.loadJSON(name: "content1")
        print(json)
        return Content(json: [:])
    }
}
