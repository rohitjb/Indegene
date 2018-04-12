import Foundation
import RxSwift

protocol ContentUseCase {
    func contentViewState() -> ContentViewState
}

class IndengeContentUseCase: ContentUseCase {
    let dataSource: ContentDataSource
    
    init(dataSource: ContentDataSource) {
        self.dataSource = dataSource
    }
    
    func contentViewState() -> ContentViewState {
        do {
            _ = try dataSource.loadContent()
        } catch {
            print(error)
        }
        return ContentViewState()
    }
}
