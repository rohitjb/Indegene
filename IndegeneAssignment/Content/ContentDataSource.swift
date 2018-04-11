import Foundation

protocol ContentDataSource {
}

class IndengeContentDataSource: ContentDataSource {
    let fetcher: ContentFetcher
    
    init(fetcher: ContentFetcher) {
        self.fetcher = fetcher
    }
}
